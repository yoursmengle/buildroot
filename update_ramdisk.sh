#!/bin/sh

cd ~/buildroot
make all

ls -al output/images/rootfs.tar
mkdir rootfs
cd rootfs
cp ~/buildroot/output/images/rootfs.tar .
tar xvf rootfs.tar
chmod +x ./etc/init.d/rcS
rm rootfs.tar
cd ..
genext2fs -b 32768 -N 30000 -d rootfs ramdisk
lzop -9 ramdisk
mv ramdisk.lzo /mnt/c/tftp
rm ramdisk
rm ./rootfs -rf
ls -al /mnt/c/tftp/ramdisk.lzo


