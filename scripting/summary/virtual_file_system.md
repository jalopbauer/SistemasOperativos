# Virtual file system
## Create
```shell
dd if=/dev/zero of="$IMAGE_FILE" bs=1 count=0 seek="$SIZE"
```

## Format
```shell
mkfs.ext4 "$IMAGE_FILE"
```

## Mounting
### Mount
```shell
mount -o loop "$IMAGE_FILE" "$MOUNT_POINT"
```

#### Check if mounted
```shell
mountpoint -q "$MOUNT_POINT"
```

### Unmount
```shell
umount "$MOUNT_POINT"
```