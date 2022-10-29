#!/usr/bin/env bash

# Config the main git user, used as default
configPrimaryUser() {
  printLine
  printMessage "Default git user (leave blank to skip)" 

  # USERNAME
  local NAME_LABEL="Your github username" 
  local NAME_PLACEHOLDER="username"
  
  printQuestion "$NAME_LABEL" 
  
  local NAME=$(gum input --placeholder "$NAME_PLACEHOLDER")
  test -n "$NAME" && git config --global user.name "$NAME" && printMessage "$NAME"

  # EMAIL
  local EMAIL_LABEL="Your github email" 
  local EMAIL_PLACEHOLDER="username@email.com"
  
  printQuestion "$EMAIL_LABEL"

  EMAIL=$(gum input --placeholder "$EMAIL_PLACEHOLDER")  
  test -n "$EMAIL" && git config --global user.email "$EMAIL" && printMessage "$EMAIL"
  
  printLine
  printSuccess "Default user setup completed"

  # START SECONDARY ACCOUNT
  startSecondaryUserConfig 
}

# Config a secondary user, scoped by some folder in your file system
configSecondaryUser() {
  printLine
  printMessage "Secondary user (leave blank to skip)"

  # SCOPE 
  local SCOPE_LABEL="Scope for this user" 
  local SCOPE_PLACEHOLDER="work"
  
  printQuestion "$SCOPE_LABEL" 
  
  SCOPE=$(gum input --placeholder "$SCOPE_PLACEHOLDER")  
  test -n "$SCOPE" && printMessage "$SCOPE"

  # FOLDER
  local FOLDER_LABEL="Specify a folder for the scoped user" 
  local FOLDER_PLACEHOLDER="~/Sites/Acme"
  
  printQuestion "$FOLDER_LABEL" 
  
  FOLDER=$(gum input --placeholder "$FOLDER_PLACEHOLDER")  
  test -n "$FOLDER" && printMessage "$FOLDER"
  
  # NAME
  local NAME_LABEL="Your $SCOPE github username" 
  local NAME_PLACEHOLDER="username"
  
  printQuestion "$NAME_LABEL" 
  
  NAME=$(gum input --placeholder "$NAME_PLACEHOLDER")  
  test -n "$NAME" && printMessage "$NAME"
  
  # EMAIL
  local EMAIL_LABEL="Your $SCOPE github email" 
  local EMAIL_PLACEHOLDER="username@acme.com"
  
  printQuestion "$EMAIL_LABEL" 
  
  EMAIL=$(gum input --placeholder "$EMAIL_PLACEHOLDER")  
  test -n "$EMAIL" && printMessage "$EMAIL"

  # Create git file
  if [ "$FOLDER" ] && [ "$SCOPE" ] && [ "$NAME" ] && [ "$EMAIL" ]; then
    FILE=".gitconfig-$SCOPE"
    >> ~/$FILE

    git config --global includeIf."gitdir/i:$FOLDER".path "$FILE"
    git config --file "$FILE" user.name "$NAME"
    git config --file "$FILE" user.email "$EMAIL"
    
    printLine
    printSuccess "$SCOPE user setup completed"
    startSecondaryUserConfig
  fi
}

startSecondaryUserConfig() {
  printLine
  printQuestion "Do you want to configure another user? (as a scoped user)?" 

  YES="Yes"
  NO="No"
  
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
 
  if [ $ACTIONS == $YES ]; then
    configSecondaryUser 
  fi
}

startGitConfig() {
  if [ "$(git config --global --get user.email)" ]; then
    printWarning "You already have an github user configured"
    printQuestion "Do you want to configure it anyway?" 

    YES="Yes"
    NO="No"
    
    ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
   
    if [ $ACTIONS == $YES ]; then
      configPrimaryUser 
    fi
  else
    configPrimaryUser
  fi 
}
