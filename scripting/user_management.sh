#!/bin/sh    
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

is_string_included_in_file() {
  if [ -z "$(grep "$1" "$2")" ]; then
    return 1 # User already exists
  else
    return 0 # User does not exist
  fi
}

does_the_user_exist() {
  return $(is_string_included_in_file $1 $2)
}

does_the_user_group_exist() {
  return $(is_string_included_in_file $1 $2)
}

add_user_group() {
  if does_the_user_group_exist "$1;$2" "$3"; then
    return 1
  else
    echo "$1;$2" >> $3
    return 0
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
      while read LINE; do
        IFS=';' read -ra FLAGS_AND_PARAMS <<< "$LINE"
        FLAGS_AND_PARAMS[1]="--${FLAGS_AND_PARAMS[1]}"
        ./user_management.sh --user ${FLAGS_AND_PARAMS[*]}
      done <$FILE
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
            echo "Deleting User: $USERNAME"
            sed -i "/\b$USERNAME\b/d" $USERS_FILE
          else
            echo "User: $USERNAME does not exist"
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