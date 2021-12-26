The build and update image usage as follows:
Which config needed for us, pls refer to build/board_configs.sh or
http://opensource.rock-chips.com/wiki_Board_Config

##Fox example the rk3288-evb Usage:

build kernel image:  (output : boot.img and out/kernel)

	build/mk-kernel.sh rk3288-evb
    
build u-boot image:  (output : out/u-boot)

	build/mk-uboot.sh rk3288-evb
    
build rootfs image:

	follow readme in rk-rootfs-build

build one system image:  (output : system.img)

	build/mk-image.sh -c rk3288 -t system -r rk-rootfs-build/linaro-rootfs.img

update image: 

	eMMC: build/flash_tool.sh   -c rk3288 -p system  -i  out/system.img
	sdcard: build/flash_tool.sh -c rk3288  -d /dev/sdb -p system  -i  out/system.img 
	rockusb: build/flash_tool.sh -p system  -i  out/system.img 

### Debian package

To pack the firmware in the deb package:  (output : out/debian)

	build/pack_deb.sh -c rk3288 -d /dev/mmcblk0(mmc index in target device, not host) (-r rk-rootfs-build/linaro-rootfs.img)

Tthe debs could be installed in the board by the following command.   

	sudo dpkg -i u-boot-rockchip_1.0_all.deb
	sudo dpkg -i kernel-rockchip_1.0_all.deb

### Tips
* You must boot into [maskrom](http://opensource.rock-chips.com/wiki_Rockusb#Maskrom_mode) to flash the eMMC. Booting into [rkusb](http://opensource.rock-chips.com/wiki_Rockusb#Miniloader_Rockusb.C2.A0mode) mode will not work.
  * An easy way to enter maskrom is by erasing the eMMC and rebooting.
* Provide the chip name for `-c` parameters, _not_ the board name! (e.g. rk3288 instead of rk3288-evb).
