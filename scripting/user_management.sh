#!/bin/sh
# Flags without parameters
# ./user_management.sh --add-user username
# ./user_management.sh --user username --delete-user
# ./user_management.sh --user username --add-to-group groupname
# ./user_management.sh --user username --remove-from-group groupname
# ./user_management.sh --user username --change-password # this should prompt to input a password without printing it to the terminal
# ./user_management.sh --user username --add-to-group groupname --change-password  --remove-from-group groupname2 # these can be concatenated
# ./user_management.sh --from-file ./users.csv
while [[ $# -gt 0 ]]; do
    case "$1" in
        --add-user)
            echo "Adding a user."
            # Add your logic for adding a user here
            ;;
        --user)
            if [ -z "$2" ]; then
                echo "Please provide a username after '--user' flag."
                exit 1
            fi
            USERNAME="$2"
            shift 2
            case "$1" in
                --delete-user)
                    echo "Deleting user: $USERNAME"
                    # Add your logic for deleting a user here
                    ;;
                --add-to-group)
                    if [ -z "$2" ]; then
                        echo "Please provide a group name after '--add-to-group' flag."
                        exit 1
                    fi
                    GROUPNAME="$2"
                    echo "Adding $USERNAME to group: $GROUPNAME"
                    # Add your logic for adding a user to a group here
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
                    ;;
                *)
                    echo "Invalid option after '--user' flag: $1"
                    exit 1
                    ;;
            esac
            ;;
        --from-file)
            if [ -z "$2" ]; then
                echo "Please provide a file path after '--from-file' flag."
                exit 1
            fi
            file="$2"
            echo "Processing users from file: $file"
            # Add your logic for processing users from the file here
            shift 2
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
done

