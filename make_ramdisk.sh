#!/bin/sh

cd ~/buildroot/configs
ln -sf ~/cssp_config/004.buildroot_config/spl_ramdisk_defconfig .

cd ~/buildroot/board/cssp/common
ln -sf ~/cssp_config/004.buildroot_config/busybox.ramdisk.config .

cd ~/buildroot
ln -sf ~/cssp_config/005.rootfs_overlay ./rootfs_overlay
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

echo ""
f_size=$(stat --format=%s "ramdisk.lzo")
echo "lzo file size: $f_size"

if [ $f_size -gt 3000000 ];
then
    mv ramdisk.lzo /mnt/c/tftp
    echo "make new ramdisk succeed."
    echo "New file:"
    ls -al /mnt/c/tftp/ramdisk.lzo
else
    rm ramdisk.lzo
    echo "[Error] make ramdisk.lzo failed..."
fi
echo ""

rm ramdisk
rm ./rootfs -rf
