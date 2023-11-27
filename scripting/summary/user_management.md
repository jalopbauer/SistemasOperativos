# User Management
## User
### Add user
```shell
useradd -m "$USER_NAME"
```
### Check if user exists
```shell
id "$USER_NAME" &>/dev/null
```
### Delete user
```shell
userdel -r "$USER_NAME"
```
### Change user password
```shell
passwd $USER_NAME
```
### Check if user is in group
```shell
groups $USER_NAME | grep -q $GROUP_NAME
```
### Add user to group
```shell 
gpasswd -a "$GROUP_NAME" "$USER_NAME"
```
### Delete user from group
```shell
gpasswd -d "$USER_NAME" "$GROUP_NAME"
```
## Group
### Check if group exists
```shell
grep -q "$GROUP_NAME" /etc/group
```
### Add group
```shell
groupadd $GROUP_NAME
```
### Delete group
```shell
groupdel $GROUP_NAME
```