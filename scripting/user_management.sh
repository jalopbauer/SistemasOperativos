#!/bin/sh
# ./user_management.sh
# ./user_management.sh --add-user Indigo
# ./user_management.sh --from-file ./users.csv
# ./user_management.sh --user Indigo --delete-user
# ./user_management.sh --user Indigo --add-to-group junior_developer
# ./user_management.sh --user Indigo --remove-from-group junior_developer
# ./user_management.sh --user Indigo --change-password                                                                             
# ./user_management.sh --user Indigo --add-to-group senior_developer --change-password --remove-from-group junior_developer      
if [ -z "$1" ]; then
  echo "Invalid "
  exit 1
fi                      
case "$1" in
  --add-user)
    if [ -z "$2" ]; then
      echo "Please provide a username after '--add-user' flag."
      exit 1
    fi
    NEW_USERNAME="$2"
    echo "Adding $NEW_USERNAME"
    shift 2
    ;;
  --from-file)
    if [ -z "$2" ]; then
      echo "Please provide a file path after '--from-file' flag."
      exit 1
    fi
    FILE="$2"
    echo "Processing users from file: $FILE"
    # Add your logic for processing users from the file here
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
          echo "delete user"
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
          # Add your logic for removing a user from a group here
          shift 2
          ;;
        --change-password)
          echo "Changing password for user: $USERNAME"
          # Add your logic for changing a user's password here
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