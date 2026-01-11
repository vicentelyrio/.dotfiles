# AGENTS.md

This file contains guidelines and commands for agentic coding agents working in this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository that uses Ansible to provision macOS and Arch Linux systems. The repository contains:

- **Ansible playbooks** for system configuration and software installation
- **Shell scripts** for bootstrapping and validation
- **Configuration files** for various tools and applications
- **Variable definitions** for user preferences and system settings

## Build/Test/Lint Commands

### Ansible Operations
```bash
# Install Ansible collections
cd provision && ansible-galaxy install -r requirements.yml

# Check Ansible playbook syntax
cd provision && ansible-playbook --syntax-check arch/system/main.yml
cd provision && ansible-playbook --syntax-check arch/development/main.yml
cd provision && ansible-playbook --syntax-check macos/system/main.yml
cd provision && ansible-playbook --syntax-check macos/development/main.yml

# Run playbook in dry-run mode (check mode)
cd provision && ansible-playbook --check arch/system/main.yml
cd provision && ansible-playbook --check arch/development/main.yml

# List tasks in a playbook
cd provision && ansible-playbook --list-tasks arch/system/main.yml

# List hosts for a playbook
cd provision && ansible-playbook --list-hosts arch/system/main.yml
```

### Shell Script Validation
```bash
# Validate shell scripts with shellcheck
shellcheck start.sh
shellcheck validateOs.sh
shellcheck interface.sh
shellcheck dependencies.sh
shellcheck packages.sh

# Test OS detection
source validateOs.sh && validateOs
```

### Running Single Tests/Playbooks
```bash
# Run specific system role (use tags if defined)
cd provision && ansible-playbook arch/system/main.yml --tags system-user

# Run specific development role
cd provision && ansible-playbook arch/development/main.yml --tags github

# Run with limit to specific host
cd provision && ansible-playbook arch/system/main.yml --limit localhost
```

## Code Style Guidelines

### YAML/Ansible Style
- **Indentation**: 2 spaces (consistent with .editorconfig)
- **Line endings**: LF (Unix style)
- **Charset**: UTF-8
- **Trailing whitespace**: Trimmed
- **Final newline**: Required

#### Ansible Task Structure
```yaml
---
- name: Descriptive task name
  become: true
  ansible.builtin.package:
    name:
      - package-name
    state: present
```

#### Variable Files
- Use snake_case for variable names
- Group related variables under parent keys
- Include comments for complex configurations
- Example from `vars/all.yml`:
```yaml
system:
  locale: en_US.utf8
  timezone: America/Sao_Paulo
  processor: intel

user:
  name: vicentelyrio
  group: users
  shell: /bin/zsh
```

### Shell Script Style
- **Shebang**: Use `#!/usr/bin/env bash`
- **Error handling**: Include `set -e` at the top
- **Functions**: Use camelCase for function names
- **Variables**: Use UPPER_CASE for constants, lower_case for variables
- **Comments**: Include shellcheck directives where applicable

#### Example Shell Script Structure
```bash
#!/usr/bin/env bash

set -e

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Functions
require() {
  local DIR="${BASH_SOURCE%/*}"
  if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
  local FILE="$DIR/$1"
  chmod +x "$FILE"
  echo "$FILE"
}

main() {
  # Main logic here
  echo "Running main function"
}

main "$@"
```

### File Organization
- **Playbooks**: Organized by OS (arch/, macos/) and category (system/, development/, apps/)
- **Roles**: Each role has tasks/, files/, templates/, handlers/ as needed
- **Variables**: Centralized in `provision/vars/all.yml`
- **Inventory**: Located in `provision/inventory/localhost`

### Import/Include Patterns
- Use `ansible.builtin.include_tasks` for dynamic task inclusion
- Use `ansible.builtin.import_tasks` for static task inclusion
- Use relative paths with `{{ playbook_dir }}` for file references

### Error Handling
- Use `ignore_errors: true` with `register:` for non-critical failures
- Include proper error messages and logging
- Use `failed_when:` for custom failure conditions
- Test playbooks with `--check` mode before applying

### Security Best Practices
- Never commit secrets or sensitive data
- Use Ansible vault for encrypted variables if needed
- Validate user input in shell scripts
- Use `become: true` only when necessary for privilege escalation

### Naming Conventions
- **Files**: kebab-case for playbooks and roles (e.g., system-user, github-cli)
- **Variables**: snake_case (e.g., external_display, graphics_card)
- **Tasks**: Descriptive names with action and object (e.g., "Github - install git-cli")
- **Hosts**: Use consistent naming (localhost for local provisioning)

### Git Configuration
The repository includes git configuration in `vars/all.yml`:
- Default branch: main
- Push behavior: autoSetupRemote, current
- Pager: delta (with specific features)
- Editor: nvim

## Testing Strategy
1. **Syntax checking**: Use `ansible-playbook --syntax-check`
2. **Dry-run mode**: Use `--check` flag to simulate changes
3. **Task listing**: Use `--list-tasks` to verify task order
4. **Shell validation**: Use shellcheck for all shell scripts
5. **OS validation**: Test OS detection functions separately

## Common Issues and Solutions
- **Permission errors**: Ensure proper use of `become: true` for system-level changes
- **Path issues**: Use `{{ playbook_dir }}` for relative file references
- **Package availability**: Handle different package managers (pacman, brew, apt)
- **OS-specific tasks**: Use conditional logic with `ansible_os_family` or custom OS detection