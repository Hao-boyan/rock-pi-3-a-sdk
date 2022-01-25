# Rockchip RK3568 Buildroot SDK

SDK of ROCK PI 3 A (RK3568)

## Build Step

> ### SET CROSS_COMPILE

  `prebuilts/gcc/linux-x86/aarch64/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu`

> ### Build u-boot :

  `./build/mk-uboot.sh rk3568-rock-3-a`

> ### Build kernel :

  `./build/mk-kernel.sh rk3568-rock-3-a`

> ### Make rootfs image :

  `build/mk-image.sh -c rk3568 -t system -r out/rootfs.img`
  
      <kbd>rootfs.img</kbd> copy from buildroot/output/images
