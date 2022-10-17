#!/usr/bin/env bash

configPrimaryAccount() {
  printQuestion "Git config for your default user (leave blank to skip)" 

  NAME=$(gum input --placeholder "Your github username")  
  EMAIL=$(gum input --placeholder "Your github email")  

  test -n "$NAME" && git config --global user.name "$NAME"
  test -n "$EMAIL" && git config --global user.email "$EMAIL" 
  
  onConfigSecondary
}

configSecondaryAccount() {
  SCOPE=$(gum input --placeholder "Scope for this user (e.g.: work)")  
  FOLDER=$(gum input --placeholder "The path of the scoped folder (e.g.: ~/Sites/Acme)")  
  NAME=$(gum input --placeholder "Your github username")  
  EMAIL=$(gum input --placeholder "Your github email")  

  if [ "$FOLDER" ] && [ "$SCOPE" ] && [ "$NAME" ] && [ "$EMAIL" ]; then
    FILE=".gitconfig-$SCOPE"
    >> ~/$FILE

    git config --global includeIf."gitdir/i:$FOLDER".path "$FILE"
    git config --file "$FILE" user.name "$NAME"
    git config --file "$FILE" user.email "$EMAIL"
    
    onConfigSecondary
  fi
}

onConfigSecondary() {
  printQuestion "Do you want to configure another user? (as a scoped account)?" 

  YES="Yes"
  NO="No"
  
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
 
  if [ $ACTIONS == $YES ]; then
    configSecondaryAccount 
  fi
}

onGitConfig() {
  if [ "$(git config --global --get user.email)" ]; then
    printWarning "You already have an github user configured"
    printQuestion "Do you want to configure it anyway?" 

    YES="Yes"
    NO="No"
    
    ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
   
    if [ $ACTIONS == $YES ]; then
      configPrimaryAccount 
    fi
  else
    configPrimaryAccount
  fi 
}
