.PHONY: rk-ubootimg-package
rk-ubootimg-package:
	mkdir -p $(CURDIR)/../rk-ubootimg-package/root/usr/lib/u-boot-${TARGET_BOARD}
	cp -av $(CURDIR)/../u-boot/* $(CURDIR)/../rk-ubootimg-package/root/usr/lib/u-boot-${TARGET_BOARD}
	fpm -s dir -t deb -n $(TARGET_BOARD)-rk-ubootimg -v $(RELEASE_VERSION) \
		-p $(TARGET_BOARD)-rk-ubootimg_$(RELEASE_VERSION)_all.deb \
		--deb-priority optional --category admin \
		--force \
		--depends debsums \
		--depends mtd-utils \
		--deb-field "Multi-Arch: foreign" \
		--deb-field "Replaces: $(TARGET_BOARD)-rk-ubootimg" \
		--deb-field "Conflicts: $(TARGET_BOARD)-rk-ubootimg" \
		--deb-field "Provides: $(TARGET_BOARD)-rk-ubootimg" \
		--url https://github.com/radxa/u-boot \
		--description "$(TARGET_BOARD) u-boot package" \
		--license "GPL-2+" \
		-m "Radxa <dev@radxa.com>" \
		--vendor "Radxa" \
		-a all \
		$(CURDIR)/../rk-ubootimg-package/root/=/
