#!/bin/bash
# Ensure that the script checks for the necessary permissions before trying to make changes.
# What are those permissions? 
USERS_FILE=users
USERS_PASSWORDS_FILE=users_passwords
USERS_GROUPS_FILE=users_group

if [ "$EUID" -ne 0 ]; then
    echo "Error: Permission denied. You must run this script as root."
    exit 1
fi

if [ -z "$1" ]; then
  echo "Invalid running without any parameters"
  exit 1
fi

exit_if_username_not_set() {
  if [ -z "$2" ]; then
    echo "$1"
    exit 1
  fi
}

exit_if_username_exists() {
  if id "$1" &>/dev/null; then
    echo "Username: $1 already exists"
    exit 1
  fi
}

exit_if_username_does_not_exist() {
  if ! id "$1" &>/dev/null; then
    echo "Username: $1 does not exist"
    exit 1
  fi
}

case "$1" in
  --add-user)
    username="$2"
    exit_if_username_not_set "Please provide a username after '--add-user' flag." $username
    exit_if_username_exists $username
    useradd -m "$username"
    ;;
  --user)
    username="$2"
    exit_if_username_not_set "Please provide a username after '--add-user' flag." $username
    shift 2
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --delete-user)
          exit_if_username_does_not_exist $username
          userdel -r $username
          shift 1
          ;;
        --add-to-group)
          if [ -z "$2" ]; then
            echo "Please provide a group name after '--add-to-group' flag."
            exit 1
          fi
          GROUPNAME="$2"
          if does_the_user_exist "$USERNAME" "$USERS_FILE"; then
            if add_user_group "$USERNAME" "$GROUPNAME" "$USERS_GROUPS_FILE"; then
              echo "Added User: $USERNAME to Group: $GROUPNAME"
            else
              echo "User: $USERNAME already is in Group: $GROUPNAME"
              exit 1
            fi           
          else
            echo "User: $USERNAME does not exist"
            exit 1
          fi
          shift 2
          ;;
        --remove-from-group)
          if [ -z "$2" ]; then
            echo "Please provide a group name after '--remove-from-group' flag."
            exit 1
          fi
          GROUPNAME="$2"
          if does_the_user_exist "$USERNAME" "$USERS_FILE"; then
            if does_the_user_group_exist "$USERNAME;$GROUPNAME" "$USERS_GROUPS_FILE"; then
              sed -i "/\b$USERNAME;$GROUPNAME\b/d" $USERS_GROUPS_FILE
              echo "Removed User: $USERNAME from Group: $GROUPNAME"
            else
              echo "User: $USERNAME is not in Group: $GROUPNAME"
              exit 1
            fi            
          else
            echo "User: $USERNAME does not exist"
            exit 1
          fi
          shift 2
          ;;
        --change-password)
          if does_the_user_exist "$USERNAME" "$USERS_FILE"; then
            echo "Please enter your password: "
            read -s PASSWORD
            sed -i "/\b$USERNAME;*\b/d" $USERS_PASSWORDS_FILE
            echo "$USERNAME;$PASSWORD" >> $USERS_PASSWORDS_FILE
          else
            echo "User: $USERNAME does not exist"
            exit 1
          fi
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

exit 0

# ./user_management.sh
# ./user_management.sh --add-user Indigo
# ./user_management.sh --from-file ./users.csv
# ./user_management.sh --user Indigo --delete-user
# ./user_management.sh --user Indigo --add-to-group junior_developer
# ./user_management.sh --user Indigo --remove-from-group junior_developer
# ./user_management.sh --user Indigo --change-password
# ./user_management.sh --user Indigo --add-to-group senior_developer --change-password --remove-from-group junior_developer