# Rockchip RK3568 Buildroot SDK

SDK of ROCK PI 3 A (RK3568)

## Build Step

> ### Build u-boot :

  `./build/mk-uboot.sh rk3568-rock-3-a`

> ### Build kernel :

  `./build/mk-kernel.sh rk3568-rock-3-a`

> ### Make rootfs image :

  `build/mk-image.sh -c rk3568 -t system -r out/rootfs.img`
