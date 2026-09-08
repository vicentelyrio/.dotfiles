#!/usr/bin/env bash
# Kills deadlocked/orphaned Proton "iscriptevaluator.exe" install-script processes.
#
# This is a known, unfixed upstream Proton bug (ValveSoftware/Proton#1717,
# open since 2018): the install-script/prerequisites stage that runs before
# a game's actual executable can hang forever on certain systems. A Proton
# contributor's own guidance in that issue is "the only workaround in the
# meantime is manually killing the process after launching the game" - no
# real fix has ever shipped. This script automates that workaround two ways:
#
#  1. Duplicate detection: Steam never legitimately runs two installers for
#     the same AppId concurrently, so if a second reaper shows up for an
#     AppId that already has one running, the older one is guaranteed to be
#     an orphan (typically left behind by an unrelated Steam crash, e.g. the
#     also-unfixed xwayland-satellite panic killing Steam mid-launch) - kill
#     it immediately. This matters because an orphaned tree's wineserver
#     keeps holding the Wine prefix lock, silently blocking any fresh
#     relaunch attempt from ever starting (symptom: stuck at "Running" with
#     no window, or endlessly "Launching").
#  2. Deadlock detection: if a (non-duplicate) tree shows zero CPU progress
#     across its entire subtree for a sustained period, kill it too.

set -u

POLL_INTERVAL=5        # seconds between checks
ZERO_GROWTH_SAMPLES=3  # consecutive zero-progress polls required before killing
GRACE_PERIOD=15        # seconds after first observed before eligible for a deadlock kill

declare -A first_seen=()
declare -A prev_ticks=()
declare -A zero_count=()

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*"
}

# utime+stime in jiffies, read straight from /proc to avoid ps's
# locale/format-dependent HH:MM:SS rendering (not directly usable in
# bash arithmetic). The comm field can contain spaces/parens, so split
# on the last ')' rather than naive whitespace splitting.
cpu_ticks() {
    local pid=$1 stat rest
    stat=$(</proc/"$pid"/stat) 2>/dev/null || { echo 0; return; }
    rest=${stat##*) }
    read -r _ _ _ _ _ _ _ _ _ _ _ utime stime _ <<<"$rest"
    echo $((${utime:-0} + ${stime:-0}))
}

subtree_of() {
    local root=$1
    local -n _ppid_of=$2
    local queue=("$root") result=() p c
    while ((${#queue[@]})); do
        p="${queue[0]}"
        queue=("${queue[@]:1}")
        result+=("$p")
        for c in "${!_ppid_of[@]}"; do
            [[ "${_ppid_of[$c]}" == "$p" ]] && queue+=("$c")
        done
    done
    printf '%s\n' "${result[@]}"
}

kill_subtree() {
    local -a pids=("$@")
    kill -TERM "${pids[@]}" 2>/dev/null
    sleep 1
    kill -KILL "${pids[@]}" 2>/dev/null
}

while true; do
    snapshot=$(ps -eo pid=,ppid=,cmd= 2>/dev/null)

    declare -A ppid_of=()
    declare -A cmd_of=()
    while read -r pid ppid rest; do
        [[ -n "$pid" ]] || continue
        ppid_of["$pid"]="$ppid"
        cmd_of["$pid"]="$rest"
    done <<<"$snapshot"

    declare -A roots_seen=()
    for pid in "${!cmd_of[@]}"; do
        [[ "${cmd_of[$pid]}" == *iscriptevaluator.exe* ]] || continue
        cur="$pid"
        root=""
        for _ in $(seq 1 20); do
            if [[ "${cmd_of[$cur]:-}" == */reaper\ SteamLaunch* ]]; then
                root="$cur"
                break
            fi
            cur="${ppid_of[$cur]:-}"
            [[ -n "$cur" && "$cur" != "1" ]] || break
        done
        [[ -n "$root" ]] || continue
        roots_seen["$root"]=1
    done

    now=$(date +%s)

    # --- pass 1: kill orphaned duplicates (same AppId, older reaper) ---
    declare -A roots_by_appid=()
    for root in "${!roots_seen[@]}"; do
        if [[ "${cmd_of[$root]}" =~ AppId=([0-9]+) ]]; then
            appid="${BASH_REMATCH[1]}"
        else
            appid="unknown-$root"
        fi
        roots_by_appid[$appid]="${roots_by_appid[$appid]:-}${roots_by_appid[$appid]:+ }$root"
    done

    for appid in "${!roots_by_appid[@]}"; do
        read -ra roots_for_appid <<<"${roots_by_appid[$appid]}"
        ((${#roots_for_appid[@]} > 1)) || continue
        newest=$(printf '%s\n' "${roots_for_appid[@]}" | sort -n | tail -1)
        for root in "${roots_for_appid[@]}"; do
            [[ "$root" != "$newest" ]] || continue
            age=$((now - ${first_seen[$root]:-$now}))
            ((age >= POLL_INTERVAL)) || continue
            mapfile -t subtree < <(subtree_of "$root" ppid_of)
            log "iscriptevaluator.exe duplicate: appid $appid has newer reaper $newest - killing orphaned older reaper $root (${#subtree[@]} processes)"
            kill_subtree "${subtree[@]}"
            unset "first_seen[$root]" "prev_ticks[$root]" "zero_count[$root]" "roots_seen[$root]"
        done
    done

    # --- pass 2: kill deadlocked (zero CPU growth) trees ---
    for root in "${!roots_seen[@]}"; do
        mapfile -t subtree < <(subtree_of "$root" ppid_of)
        total=0
        for p in "${subtree[@]}"; do
            total=$((total + $(cpu_ticks "$p")))
        done

        key="$root"
        if [[ -z "${first_seen[$key]:-}" ]]; then
            first_seen[$key]=$now
            prev_ticks[$key]=$total
            zero_count[$key]=0
            continue
        fi

        age=$((now - first_seen[$key]))
        if [[ "$total" == "${prev_ticks[$key]}" ]]; then
            zero_count[$key]=$((zero_count[$key] + 1))
        else
            zero_count[$key]=0
        fi
        prev_ticks[$key]=$total

        if ((age >= GRACE_PERIOD && zero_count[$key] >= ZERO_GROWTH_SAMPLES)); then
            log "iscriptevaluator.exe deadlock: reaper pid $root, ${age}s old, no CPU progress for $((zero_count[$key] * POLL_INTERVAL))s - killing subtree (${#subtree[@]} processes)"
            kill_subtree "${subtree[@]}"
            unset "first_seen[$key]" "prev_ticks[$key]" "zero_count[$key]"
        fi
    done

    for key in "${!first_seen[@]}"; do
        [[ -n "${roots_seen[$key]:-}" ]] || unset "first_seen[$key]" "prev_ticks[$key]" "zero_count[$key]"
    done

    unset ppid_of cmd_of roots_seen roots_by_appid
    sleep "$POLL_INTERVAL"
done
