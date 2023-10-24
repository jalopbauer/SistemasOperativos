#!/bin/sh    
# Ensure that the script checks for the necessary permissions before trying to make changes.
# What are those permissions? 
USERS_FILE=users

does_the_user_exist() {
  if [ -z "$(grep "$1" "$2")" ]; then
    return 1 # User already exists
  else
    return 0 # User does not exist
  fi
}

add_user() {
  if does_the_user_exist "$1" "$2"; then
    return 1
  else
    echo $1 >> $2
    return 0
  fi
}

if [ -z "$1" ]; then
  echo "Invalid running without any parameters"
  exit 1
fi

case "$1" in
  --add-user)
    if [ -z "$2" ]; then
      echo "Please provide a username after '--add-user' flag."
      exit 1
    fi
    NEW_USERNAME="$2"
    if add_user "$NEW_USERNAME" "$USERS_FILE"; then
      echo "Saved user $NEW_USERNAME"
      exit 0
    else
      echo "Cannot add new user with username: $NEW_USERNAME because it already exists"
      exit 1
    fi
    ;;
  --from-file)
    if [ -z "$2" ]; then
      echo "Please provide a file path after '--from-file' flag."
      exit 1
    fi
    FILE="$2"
    echo "Processing users from file: $FILE"

    shift 2
    ;;
  --user)
    if [ -z "$2" ]; then
      echo "Please provide a username after '--user' flag."
      exit 1
    fi
    USERNAME="$2"
    shift 2
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --delete-user)
          if does_the_user_exist "$USERNAME" "$USERS_FILE"; then
            echo "Deleting $USERNAME"
            sed -i "/\b$USERNAME\b/d" $USERS_FILE
            exit 0            
          else
            echo "Not deleting $USERNAME"
            exit 1
          fi
          shift 1
          ;;
        --add-to-group)
          if [ -z "$2" ]; then
            echo "Please provide a group name after '--add-to-group' flag."
            exit 1
          fi
          GROUPNAME="$2"
          echo "Adding $USERNAME to group: $GROUPNAME"
          shift 2
          ;;
        --remove-from-group)
          if [ -z "$2" ]; then
            echo "Please provide a group name after '--remove-from-group' flag."
            exit 1
          fi
          GROUPNAME="$2"
          echo "Removing $USERNAME from group: $GROUPNAME"
          
          shift 2
          ;;
        --change-password)
          echo "Changing password for user: $USERNAME"

          shift 1
          ;;
      esac
    done
    ;;
  *)
    echo "Invalid option: $1"
    exit 1
    ;;
esac

echo ""

# ./user_management.sh
# ./user_management.sh --add-user Indigo
# ./user_management.sh --from-file ./users.csv
# ./user_management.sh --user Indigo --delete-user
# ./user_management.sh --user Indigo --add-to-group junior_developer
# ./user_management.sh --user Indigo --remove-from-group junior_developer
# ./user_management.sh --user Indigo --change-password                                                                             
# ./user_management.sh --user Indigo --add-to-group senior_developer --change-password --remove-from-group junior_developer  