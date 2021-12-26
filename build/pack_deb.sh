#!/bin/bash -e

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
TOOLPATH=${LOCALPATH}/rkbin/tools
EXTLINUXPATH=${LOCALPATH}/build/extlinux
TARGET=${OUT}/debian/rockchip-firmware
CHIP=""
DEVICE=""
ROOTFS_PATH=""

source $LOCALPATH/build/partitions.sh

usage() {
	echo -e "\nUsage: build/pack-deb.sh -c rk3288 -d /dev/mmcblk0(mmc index in target device, not host) (-r rk-rootfs-build/linaro-rootfs.img)\n"
}
finish() {
	echo -e "\e[31m PACK DEB FAILED.\e[0m"
	exit -1
}
trap finish ERR

OLD_OPTIND=$OPTIND
while getopts "c:d:r:h" flag; do
	case $flag in
		c)
			CHIP="$OPTARG"
			;;
		d)
			DEVICE="$OPTARG"
			;;
		r)
			ROOTFS_PATH="$OPTARG"
			;;
	esac
done
OPTIND=$OLD_OPTIND

if [ ! $CHIP ] || [ ! $DEVICE ]; then
	usage
	exit
fi
if [ ! -f "${ROOTFS_PATH}" ]; then
	ROOTFS_PATH="build/pack_deb.sh" # fake
fi

mkdir -p ${TARGET}
cp -rf ${LOCALPATH}/build/debian/rockchip-firmware ${OUT}/debian/

########### u-boot #############
DIR=/usr/lib/u-boot-rockchip
if [ "$CHIP" == "rk3288" ] || [ "$CHIP" == "rk322x" ] || [ "$CHIP" == "rk3036" ]; then
	cat >${TARGET}/u-boot_install.sh <<EOF
dd if=${DIR}/idbloader.img of=${DEVICE} seek=${LOADER1_START}
sync
EOF
elif [ "$CHIP" == "rk3399" ] || [ "$CHIP" == "rk3328" ]; then
	cat >${TARGET}/u-boot_install.sh <<EOF
dd if=${DIR}/idbloader.img of=${DEVICE} seek=${LOADER1_START}
dd if=${DIR}/uboot.img of=${DEVICE} seek=${LOADER2_START}
dd if=${DIR}/trust.img of=${DEVICE} seek=${ATF_START}
sync
EOF
fi

########### kernel #############
DIR=/usr/lib/kernel-rockchip
cat >${TARGET}/kernel_install.sh <<EOF
dd if=${DIR}/boot.img of=${DEVICE} seek=${BOOT_START}
echo "delete kernel image to save space"
rm -f ${DIR}/boot.img 
sync
EOF

########### rootfs #############
sed -i -e "s:@ROOTFS@:${ROOTFS_PATH}:" ${TARGET}/Makefile

DIR=/usr/lib/rootfs-rockchip
cat >${TARGET}/rootfs_install.sh <<EOF
dd if=${DIR}/rootfs.img of=${DEVICE} seek=${ROOTFS_START}
echo "delete rootfs image to save space"
rm -f ${DIR}/rootfs.img
sync
EOF

########### build #############
cd ${TARGET}
dpkg-buildpackage -rfakeroot -b -uc -us
rm -rf ${TARGET}