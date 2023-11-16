# General

## if

### Checks if file exists
```shell
-f "$FILE"
```

### Check if not run as sudo
```shell
"$EUID" -ne 0
```

### Variable not set
```shell
-z "$VARIABLE"
```

### Is string in file
```shell
grep -q "$STRING_LOOKING_FOR" "$FILE"
```

### Is directory empty
```shell
-z "$(ls -A "$1")"
```

### Checks if directory exists
```shell
-d "$DIRECTORY"
```

### Checks if the named argument exists
```shell
-e $NAMED_ARGUMENT
```

### Matches string to RegEx
```shell
"$STRING" =~ $REGEX
```

## while

### Loop over flags
```shell
while [[ $# -gt 0 ]]; do
  $FLAG=$1
  shift
done
```

### Loop over a file destructuring its columns
```shell
while IFS="$DIVIDER" read -r COLUMN_ONE COLUMN_TWO COLUMN_THREE; do
    
done < "$FILE"
```

## case

### example
```shell
case "$STRING_TO_MATCH" in
  matchStringOne)
    # What you want to do
    ;;
  matchStringTwo)
    # What you want to do
    ;;
  *)
    # Doesnt match
    ;;
```

## File manipulation
### Add to end of file
```shell
echo "$STRING_TO_BE_ADDED" >> "$FILE"
```
### Delete matching strings
```shell
sed -i "/^$STRING_TO_BE_REMOVED\$/d" "$FILE"
```