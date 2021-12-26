all:
	
install:
	install -d -m 755 $(DESTDIR)/usr/lib/u-boot-rockchip/
	install -D -m 644 ../../../out/u-boot/* $(DESTDIR)/usr/lib/u-boot-rockchip/
	install -D -m 644 u-boot_install.sh $(DESTDIR)/usr/lib/u-boot-rockchip/install.sh

	install -d -m 755 $(DESTDIR)/usr/lib/kernel-rockchip/
	install -D -m 644 ../../../out/boot.img $(DESTDIR)/usr/lib/kernel-rockchip/boot.img
	install -D -m 644 kernel_install.sh $(DESTDIR)/usr/lib/kernel-rockchip/install.sh

	install -d -m 755 $(DESTDIR)/usr/lib/rootfs-rockchip/
	install -D -m 644 ../../../@ROOTFS@ $(DESTDIR)/usr/lib/rootfs-rockchip/rootfs.img
	install -D -m 644 rootfs_install.sh $(DESTDIR)/usr/lib/rootfs-rockchip/install.sh

.PHONY: install
