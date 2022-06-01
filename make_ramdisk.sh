#!/bin/sh

cd ~/buildroot/configs
ln -s ~/cssp_config/spl_ramdisk_defconfig .

cd ..
rm rootfs_overlay
ln -s ~/cssp_config/rootfs_overlay .

make distclean
make spl_ramdisk_defconfig
make all

echo ""
echo "New rootfs.tar: "
ls -al output/images/rootfs.tar
echo ""

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
echo ""
echo "make new ramdisk succeed."
echo "New file:"
ls -al /mnt/c/tftp/ramdisk.lzo
echo ""



