# User Management
## User
### Check if user exists
```bash
id "$username" &>/dev/null
```
### Delete user
```bash
userdel -r "$username"
```
### Delete user password
```shell
passwd $username
```
## Group
### Check if group exists
```bash
grep -q "$groupname" /etc/group
```
### Add user to group
```bash 
usermod -aG "$groupname" "$username"
```
### Delete user from group
```bash
gpasswd -d "$username" "$groupname"
```
