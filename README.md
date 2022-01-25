# Rockchip RK3568 Buildroot SDK

SDK of ROCK PI 3 A (RK3568)

## Build Step (Ubuntu 18.04 / 20.04)

> ### SET CROSS_COMPILE

  Place toolchain to `./prebuilts/gcc/linux-x86/aarch64/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu`

> ### Build u-boot :

  `./build/mk-uboot.sh rk3568-rock-3-a`

> ### Build kernel :

  `./build/mk-kernel.sh rk3568-rock-3-a`

> ### Make rootfs image :

  `./buildroot/make rockpi3a_defconfig`

  `./build/mk-image.sh -c rk3568 -t system -r out/rootfs.img`

       _<kbd>rootfs.img</kbd>  copy from `buildroot/output/images/rootfs.ext2`_
