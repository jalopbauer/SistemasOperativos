# File management

## Setting permissions

### Numeric method

```shell
chmod [user permissions][group permissions][other_permissions] [path]
```

[* permissions] = 7 | 5 | 3 | 4 | 2 | 1

4: Read

2: Write

1: Execute


### Alphanumeric Method

```shell
chmod u=[user permissions], g=[group permissions], o=[other permissions] [path]
```

[* permissions] combination of r|w|x

## Modifying permissions

### Alphanumeric Method
```shell
chmod [user type][method][permission] [path]
```
[user type] : u | g | o

u: user

g: group

o: everyone else

[method] : + | - | =

+: add

-: remove

=: copy

[permission] : r | w | x

r: read

w: write

x: execute


## Recursively set and modify permissions
```shell
chmod -R [permissions] [path]
```
