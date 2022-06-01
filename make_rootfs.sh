#!/bin/sh

cd ~/buildroot/configs
ln -s ~/cssp_config/spl_rootfs_defconfig .

cd ..
rm rootfs_overlay
ln -s ~/cssp_config/rootfs_overlay .

make distclean
make spl_rootfs_defconfig
make all

echo ""
echo "New rootfs.tar.gz: "
ls -al output/images/rootfs.tar.gz
echo ""
cp output/images/rootfs.tar.gz /mnt/c/tftp
echo "copy rootfs.tar.gz to tftp root"
echo ""

