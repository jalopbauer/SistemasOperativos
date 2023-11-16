# Encryption RSA
## Encrypt file
```shell
openssl rsautl -encrypt -pubin -inkey "$RECYPIENT_PUBLIC_KEY" -in "$INPUT_FILE" -out "$OUTPUT_FILE"
```
## Decrypt file
```shell
openssl rsautl -decrypt -inkey "$RECYPIENT_PRIVATE_KEY" -in "$INPUT_FILE" -out "$OUTPUT_FILE"
```
# Key generation
## Private keygen
```shell
openssl genpkey -algorithm RSA -out "$PRIVATE_KEY_FILE"
```
## Public keygen
```shell
openssl rsa -pubout -in "$PRIVATE_KEY_FILE" -out "$PUBLIC_KEY_FILE"
```