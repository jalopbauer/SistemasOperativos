#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Error: Permission denied. You must run this script as root."
    exit 1
fi

if [ -z "$1" ]; then
  echo "Invalid running without any parameters"
  exit 1
fi

exit_if_variable_not_set() {
  if [ -z "$2" ]; then
    echo "$1"
    exit 1
  fi
}

exit_if_user_name_variable_not_set () {
  exit_if_variable_not_set "Please provide a user name after '--add-user' flag." $1
}


exit_if_group_name_variable_not_set () {
  exit_if_variable_not_set "Please provide a group name after '--add-to-group' flag." $1
}

exit_if_user_exists() {
  if id "$1" &>/dev/null; then
    echo "Username: $1 already exists"
    exit 1
  fi
}

exit_if_user_does_not_exist() {
  if ! id "$1" &>/dev/null; then
    echo "Username: $1 does not exist"
    exit 1
  fi
}

exit_if_group_exists() {
  if grep -q "$1" /etc/group; then
    echo "Group: $1 does not exist"
    exit 1
  fi
}

exit_if_group_does_not_exist() {
  if ! grep -q "$1" /etc/group; then
    echo "Group: $1 does not exist"
    exit 1
  fi
}

case "$1" in
  --add-user)
    user_name="$2"
    exit_if_user_name_variable_not_set  $user_name
    exit_if_user_exists $user_name
    useradd -m "$user_name"
    ;;
  --user)
    user_name="$2"
    exit_if_user_name_variable_not_set $user_name
    exit_if_user_does_not_exist $user_name
    shift 2
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --delete-user)
          userdel -r $user_name
          shift 1
          ;;
        --add-to-group)
          group_name="$2"
          exit_if_group_name_variable_not_set $group_name
          exit_if_group_does_not_exist $group_name
          gpasswd -a "$user_name" "$group_name"
          shift 2
          ;;
        --remove-from-group)
          group_name="$2"
          exit_if_group_name_variable_not_set $group_name
          exit_if_group_does_not_exist $group_name
          gpasswd -d "$user_name" "$group_name"
          shift 2
          ;;
        --change-password)
          passwd $user_name
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

#sudo ./user_management.sh
#
#sudo ./user_management.sh --add-user
#sudo ./user_management.sh --add-user $USERNAME
#sudo ./user_management.sh --add-user Indigo
#
#sudo ./user_management.sh --user
#
#sudo groupadd junior_developer
#sudo ./user_management.sh --user Indigo --add-to-group
#sudo ./user_management.sh --user Indigo --add-to-group group_that_does_not_exist
#sudo ./user_management.sh --user Indigo --add-to-group junior_developer
#
#sudo ./user_management.sh --user Indigo --remove-from-group
#sudo ./user_management.sh --user Indigo --remove-from-group group_that_does_not_exist
#sudo ./user_management.sh --user Indigo --remove-from-group junior_developer
#
#sudo ./user_management.sh --user Indigo --change-password
#
#sudo ./user_management.sh --user Indigo --add-to-group senior_developer --change-password --remove-from-group junior_developer
#
#sudo ./user_management.sh --user Indigo --delete-user

## Clear all from before
#sudo ./user_management.sh --user Indigo --remove-from-group senior_developer
