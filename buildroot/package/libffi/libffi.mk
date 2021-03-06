################################################################################
#
# libffi
#
################################################################################

LIBFFI_VERSION = 3.3
LIBFFI_SITE = $(call github,libffi,libffi,v$(LIBFFI_VERSION))
LIBFFI_CPE_ID_UPDATE = rc0
LIBFFI_LICENSE = MIT
LIBFFI_LICENSE_FILES = LICENSE
LIBFFI_CPE_ID_VENDOR = libffi_project
LIBFFI_INSTALL_STAGING = YES
LIBFFI_AUTORECONF = YES

$(eval $(autotools-package))
$(eval $(host-autotools-package))
