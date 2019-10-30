#!/usr/bin/env bash

rm outputFS.bin
# Create 10MB output filesystem
dd if=/dev/zero of=outputFS.bin count=10240 bs=1024
# Create partition table and a full-disk partition
sfdisk outputFS.bin < outputFS.sfdisk
# Mount in loop so we can create a filesystem on it
LODEVICE="$(sudo losetup --find --show -P outputFS.bin)"
# Create filesystem
sudo mkfs.exfat ${LODEVICE}p1
# Overwrite MBR of output filesystem with stage 1 bootloader.
dd if=stage1.bin of=outputFS.bin count=440 iflag=count_bytes conv=notrunc
dd if=stage1.bin of=outputFS.bin seek=510 skip=510 count=2 iflag=count_bytes,skip_bytes oflag=seek_bytes conv=notrunc
sudo losetup -d $LODEVICE
