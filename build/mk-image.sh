#!/bin/bash -e

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out
TOOLPATH=${LOCALPATH}/rkbin/tools
EXTLINUXPATH=${LOCALPATH}/build/extlinux
CHIP=""
TARGET=""
ROOTFS_PATH=""
BOARD=""

PATH=$PATH:$TOOLPATH

source $LOCALPATH/build/partitions.sh

usage() {
	echo -e "\nUsage: build/mk-image.sh -c rk3399 -t system -r rk-rootfs-build/linaro-rootfs.img \n"
	echo -e "       build/mk-image.sh -c rk3399 -t boot -b rockpi4b\n"
}
finish() {
	echo -e "\e[31m MAKE IMAGE FAILED.\e[0m"
	exit -1
}
trap finish ERR

OLD_OPTIND=$OPTIND
while getopts "c:t:r:b:h" flag; do
	case $flag in
		c)
			CHIP="$OPTARG"
			;;
		t)
			TARGET="$OPTARG"
			;;
		r)
			ROOTFS_PATH="$OPTARG"
			;;
		b)
			BOARD="$OPTARG"
			;;
	esac
done
OPTIND=$OLD_OPTIND

if [ ! -f "${EXTLINUXPATH}/${CHIP}.conf" ]; then
	CHIP="rk3288"
fi

if [ ! $CHIP ] && [ ! $TARGET ]; then
	usage
	exit
fi

if [[ "${CHIP}" == "rk3308" ]]; then
	source $LOCALPATH/build/rockpis-partitions.sh
fi

generate_boot_image() {
	BOOT=${OUT}/boot.img
	rm -rf ${BOOT}

	echo -e "\e[36m Generate Boot image start\e[0m"

	if [[ "${CHIP}" == "rk3308" ]]; then
		# 100MB
		mkfs.vfat -n "boot" -S 512 -C ${BOOT} $((100 * 1024))
	else
		# 500Mb
		mkfs.vfat -n "boot" -S 512 -C ${BOOT} $((500 * 1024))
	fi

	mmd -i ${BOOT} ::/extlinux
	if [ "${BOARD}" == "rockpi4a" ] || [ "${BOARD}" == "rockpi4b" ] ||  [ "${BOARD}" == "rockpis" ] ; then
		mmd -i ${BOOT} ::/overlays
	fi

	mcopy -i ${BOOT} -s ${EXTLINUXPATH}/${CHIP}.conf ::/extlinux/extlinux.conf
	mcopy -i ${BOOT} -s ${OUT}/kernel/* ::

	echo -e "\e[36m Generate Boot image : ${BOOT} success! \e[0m"
}

generate_system_image() {
	if [ ! -f "${OUT}/boot.img" ]; then
		echo -e "\e[31m CAN'T FIND BOOT IMAGE \e[0m"
		usage
		exit
	fi

	if [ ! -f "${ROOTFS_PATH}" ]; then
		echo -e "\e[31m CAN'T FIND ROOTFS IMAGE \e[0m"
		usage
		exit
	fi

	SYSTEM=${OUT}/system.img
	rm -rf ${SYSTEM}

	echo "Generate System image : ${SYSTEM} !"

	# last dd rootfs will extend gpt image to fit the size,
	# but this will overrite the backup table of GPT
	# will cause corruption error for GPT
	IMG_ROOTFS_SIZE=$(stat -L --format="%s" ${ROOTFS_PATH})
	GPTIMG_MIN_SIZE=$(expr $IMG_ROOTFS_SIZE + \( ${LOADER1_SIZE} + ${RESERVED1_SIZE} + ${RESERVED2_SIZE} + ${LOADER2_SIZE} + ${ATF_SIZE} + ${BOOT_SIZE} + 35 \) \* 512)
	GPT_IMAGE_SIZE=$(expr $GPTIMG_MIN_SIZE \/ 1024 \/ 1024 + 2)

	dd if=/dev/zero of=${SYSTEM} bs=1M count=0 seek=$GPT_IMAGE_SIZE

	if [ "$BOARD" == "rockpi4" ]; then
		parted -s ${SYSTEM} mklabel gpt
		parted -s ${SYSTEM} unit s mkpart loader1 ${LOADER1_START} $(expr ${RESERVED1_START} - 1)
		# parted -s ${SYSTEM} unit s mkpart reserved1 ${RESERVED1_START} $(expr ${RESERVED2_START} - 1)
		# parted -s ${SYSTEM} unit s mkpart reserved2 ${RESERVED2_START} $(expr ${LOADER2_START} - 1)
		parted -s ${SYSTEM} unit s mkpart loader2 ${LOADER2_START} $(expr ${ATF_START} - 1)
		parted -s ${SYSTEM} unit s mkpart trust ${ATF_START} $(expr ${BOOT_START} - 1)
		parted -s ${SYSTEM} unit s mkpart boot ${BOOT_START} $(expr ${ROOTFS_START} - 1)
		parted -s ${SYSTEM} set 4 boot on
		parted -s ${SYSTEM} -- unit s mkpart rootfs ${ROOTFS_START} -34s
	else
		parted -s ${SYSTEM} mklabel gpt
		parted -s ${SYSTEM} unit s mkpart boot ${BOOT_START} $(expr ${ROOTFS_START} - 1)
		parted -s ${SYSTEM} set 1 boot on
		parted -s ${SYSTEM} -- unit s mkpart rootfs ${ROOTFS_START} -34s
	fi

	if [ "$CHIP" == "rk3328" ] || [ "$CHIP" == "rk3399" ] || [ "$CHIP" == "rk3399pro" ]; then
		ROOT_UUID="B921B045-1DF0-41C3-AF44-4C6F280D3FAE"
	elif [ "$CHIP" == "rk3308" ] || [ "$CHIP" == "px30" ] || [ "$CHIP" == "rk3566" ] || [ "$CHIP" == "rk3568" ]; then
		ROOT_UUID="614e0000-0000-4b53-8000-1d28000054a9"
	else
		ROOT_UUID="69DAD710-2CE4-4E3C-B16C-21A1D49ABED3"
	fi

	if [ "$BOARD" == "rockpi4" ]; then
		gdisk ${SYSTEM} <<EOF
x
c
5
${ROOT_UUID}
w
y
EOF
	else
		gdisk ${SYSTEM} <<EOF
x
c
2
${ROOT_UUID}
w
y
EOF
	fi

	# burn u-boot
	case ${CHIP} in
	rk322x | rk3036 )
		dd if=${OUT}/u-boot/idbloader.img of=${SYSTEM} seek=${LOADER1_START} conv=notrunc
		;;
	px30 | rk3288 | rk3308 | rk3328 | rk3399 | rk3399pro )
		dd if=${OUT}/u-boot/idbloader.img of=${SYSTEM} seek=${LOADER1_START} conv=notrunc
		dd if=${OUT}/u-boot/uboot.img of=${SYSTEM} seek=${LOADER2_START} conv=notrunc
		dd if=${OUT}/u-boot/trust.img of=${SYSTEM} seek=${ATF_START} conv=notrunc
		;;
	rk3566 | rk3568 )
		dd if=${OUT}/u-boot/idbloader.img of=${SYSTEM} seek=${LOADER1_START} conv=notrunc
		dd if=${OUT}/u-boot/u-boot.itb of=${SYSTEM} seek=${LOADER2_START} conv=notrunc
		;;
	*)
		;;
	esac

	# burn boot image
	dd if=${OUT}/boot.img of=${SYSTEM} conv=notrunc seek=${BOOT_START}

	# burn rootfs image
	dd if=${ROOTFS_PATH} of=${SYSTEM} conv=notrunc,fsync seek=${ROOTFS_START}
}

if [ "$TARGET" = "boot" ]; then
	generate_boot_image
elif [ "$TARGET" == "system" ]; then
	generate_system_image
fi
