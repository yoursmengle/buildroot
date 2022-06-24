#!/bin/sh

make distclean
./make_ramdisk.sh
echo ***************************************
echo ramdisk built succeed
echo ***************************************

make distclean
./make_rootfs.sh
echo ***************************************
echo rootfs built succeed
echo ***************************************
m
