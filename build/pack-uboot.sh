#!/bin/bash

usage() {
    echo "====USAGE: pack-uboot.sh -b <board>===="
    echo "pack-uboot.sh -b rockpropx30"
}

while getopts "b:h" flag; do
    case $flag in
        b)
            export TARGET_BOARD="$OPTARG"
            ;;
    esac
done

if [ ! $TARGET_BOARD ]; then
    usage
    exit
fi

CMD=`realpath $0`
BUILD_DIR=`dirname $CMD`
ROCKCHIP_BSP_DIR=$(realpath $BUILD_DIR/..)
PACKAGES_DIR=$ROCKCHIP_BSP_DIR/out/packages
[ ! -d "$PACKAGES_DIR" ] && mkdir $PACKAGES_DIR
UBOOT_DIR=$ROCKCHIP_BSP_DIR/u-boot

cd $UBOOT_DIR
make ubootrelease > ./ubootrelease.tmp
sed -i 's/"//g' ./ubootrelease.tmp
export LATEST_UBOOT_VERSION=$(cat ./ubootrelease.tmp | cut -d " " -f 1)
echo "LATEST_UBOOT_VERSION = $LATEST_UBOOT_VERSION"
export RELEASE_VERSION=$LATEST_UBOOT_VERSION
rm ./ubootrelease.tmp

cd ${PACKAGES_DIR} && make -f ${BUILD_DIR}/uboot-package.mk rk-ubootimg-package
