# SPDX-License-Identifier: GPL-2.0

CONFIG_MXM_WIFIEX_MLAN := m
CONFIG_MXM_WIFIEX_MOAL := m

#EXTRA_CFLAGS += -Wunused-but-set-variable
#EXTRA_CFLAGS += -Wmissing-prototypes
#EXTRA_CFLAGS += -Wold-style-definition
#EXTRA_CFLAGS += -Wtype-limits
#EXTRA_CFLAGS += -Wsuggest-attribute=format
#EXTRA_CFLAGS += -Wmissing-include-dirs
#EXTRA_CFLAGS += -Wshadow
#EXTRA_CFLAGS += -Wsign-compare
#EXTRA_CFLAGS += -Wunused-macros
#EXTRA_CFLAGS += -Wmissing-field-initializers
#EXTRA_CFLAGS += -Wstringop-truncation
#EXTRA_CFLAGS += -Wmisleading-indentation
#EXTRA_CFLAGS += -Wunused-const-variable

#############################################################################
# Configuration Options
#############################################################################
# Multi-chipsets
CONFIG_SD8887 = n
CONFIG_SD8897 = n
CONFIG_USB8897 = n
CONFIG_PCIE8897 = n
CONFIG_SD8977 = n
CONFIG_SD8978 = y
CONFIG_USB8978 = n
CONFIG_SD8997 = y
CONFIG_USB8997 = n
CONFIG_PCIE8997 = y
CONFIG_SD8987 = y
CONFIG_SD9097 = n
CONFIG_SD9177 = n
CONFIG_SD8801 = n
CONFIG_USB8801 = n
CONFIG_USB9097 = n
CONFIG_PCIE9097 = n
CONFIG_SD9098 = n
CONFIG_USB9098 = n
CONFIG_PCIE9098 = y


# Debug Option
# DEBUG LEVEL n/1/2:
# n: NO DEBUG
# 1: Only PRINTM(MMSG,...), PRINTM(MFATAL,...), ...
# 2: All PRINTM()
CONFIG_DEBUG = 1

# Enable STA mode support
CONFIG_STA_SUPPORT = y

# Enable uAP mode support
CONFIG_UAP_SUPPORT = y

# Enable WIFIDIRECT support
CONFIG_WIFI_DIRECT_SUPPORT = y

# Re-association in driver
CONFIG_REASSOCIATION = y

# Manufacturing firmware support
CONFIG_MFG_CMD_SUPPORT=y

# OpenWrt support
CONFIG_OPENWRT_SUPPORT = n

# Big-endian platform
CONFIG_BIG_ENDIAN = n

ifeq ($(CONFIG_DRV_EMBEDDED_SUPPLICANT), y)
CONFIG_EMBEDDED_SUPP_AUTH = y
else
ifeq ($(CONFIG_DRV_EMBEDDED_AUTHENTICATOR), y)
CONFIG_EMBEDDED_SUPP_AUTH = y
endif
endif

#ifdef SDIO_MMC
# SDIO suspend/resume
CONFIG_SDIO_SUSPEND_RESUME = y
#endif

# DFS testing support
CONFIG_DFS_TESTING_SUPPORT = y

# Use static link for app build
# export CONFIG_STATIC_LINK=y
CONFIG_ANDROID_KERNEL = n

# 32bit app over 64bit kernel support
CONFIG_USERSPACE_32BIT_OVER_KERNEL_64BIT = n

#############################################################################
# Select Platform Tools
#############################################################################

# MODEXT = ko
# ccflags-y += -I$(PWD)/mlan
EXTRA_CFLAGS += -DLINUX

CONFIG_IMX_SUPPORT = n
ifeq ($(CONFIG_IMX_SUPPORT), y)
EXTRA_CFLAGS += -DIMX_SUPPORT
endif

#############################################################################
# Compiler Flags
#############################################################################

EXTRA_CFLAGS += -DFPNUM='"92"'

ifeq ($(CONFIG_DEBUG), 1)
EXTRA_CFLAGS += -DDEBUG_LEVEL1
endif

ifeq ($(CONFIG_DEBUG), 2)
EXTRA_CFLAGS += -DDEBUG_LEVEL1
EXTRA_CFLAGS += -DDEBUG_LEVEL2
#DBG=	-dbg
endif

ifeq ($(CONFIG_64BIT), y)
EXTRA_CFLAGS += -DMLAN_64BIT
endif

ifeq ($(CONFIG_STA_SUPPORT), y)
EXTRA_CFLAGS += -DSTA_SUPPORT
ifeq ($(CONFIG_REASSOCIATION), y)
EXTRA_CFLAGS += -DREASSOCIATION
endif
else
CONFIG_WIFI_DIRECT_SUPPORT = n
CONFIG_STA_WEXT = n
CONFIG_STA_CFG80211 = n
endif

ifeq ($(CONFIG_UAP_SUPPORT), y)
EXTRA_CFLAGS += -DUAP_SUPPORT
else
CONFIG_WIFI_DIRECT_SUPPORT = n
CONFIG_UAP_WEXT = n
CONFIG_UAP_CFG80211 = n
endif

ifeq ($(CONFIG_WIFI_DIRECT_SUPPORT), y)
EXTRA_CFLAGS += -DWIFI_DIRECT_SUPPORT
endif

ifeq ($(CONFIG_MFG_CMD_SUPPORT), y)
EXTRA_CFLAGS += -DMFG_CMD_SUPPORT
endif

ifeq ($(CONFIG_BIG_ENDIAN), y)
EXTRA_CFLAGS += -DBIG_ENDIAN_SUPPORT
endif

ifeq ($(CONFIG_USERSPACE_32BIT_OVER_KERNEL_64BIT), y)
EXTRA_CFLAGS += -DUSERSPACE_32BIT_OVER_KERNEL_64BIT
endif

#ifdef SDIO_MMC
ifeq ($(CONFIG_SDIO_SUSPEND_RESUME) , y)
EXTRA_CFLAGS += -DSDIO_SUSPEND_RESUME
endif
#endif

ifeq ($(CONFIG_DFS_TESTING_SUPPORT), y)
EXTRA_CFLAGS += -DDFS_TESTING_SUPPORT
endif

ifeq ($(CONFIG_ANDROID_KERNEL), y)
EXTRA_CFLAGS += -DANDROID_KERNEL
endif

ifeq ($(CONFIG_OPENWRT_SUPPORT), y)
EXTRA_CFLAGS += -DOPENWRT
endif

ifeq ($(CONFIG_T50), y)
EXTRA_CFLAGS += -DT50
EXTRA_CFLAGS += -DT40
EXTRA_CFLAGS += -DT3T
endif

ifeq ($(CONFIG_SD8887), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8887
endif
ifeq ($(CONFIG_SD8897), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8897
endif
ifeq ($(CONFIG_SD8977), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8977
endif
ifeq ($(CONFIG_SD8978), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8978
endif
ifeq ($(CONFIG_SD8997), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8997
endif
ifeq ($(CONFIG_SD8987), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8987
endif
ifeq ($(CONFIG_SD9097), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD9097
endif
ifeq ($(CONFIG_SD9177), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD9177
endif
ifeq ($(CONFIG_SD8801), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD8801
endif
ifeq ($(CONFIG_SD9098), y)
CONFIG_SDIO = y
EXTRA_CFLAGS += -DSD9098
endif
ifeq ($(CONFIG_USB8801), y)
CONFIG_MUSB = y
EXTRA_CFLAGS += -DUSB8801
endif
ifeq ($(CONFIG_USB8897), y)
CONFIG_MUSB = y
EXTRA_CFLAGS += -DUSB8897
endif
ifeq ($(CONFIG_USB8997), y)
CONFIG_MUSB = y
EXTRA_CFLAGS += -DUSB8997
endif
ifeq ($(CONFIG_USB8978), y)
CONFIG_MUSB = y
EXTRA_CFLAGS += -DUSB8978
endif
ifeq ($(CONFIG_USB9097), y)
CONFIG_MUSB = y
EXTRA_CFLAGS += -DUSB9097
endif
ifeq ($(CONFIG_USB9098), y)
CONFIG_MUSB = y
EXTRA_CFLAGS += -DUSB9098
endif
ifeq ($(CONFIG_PCIE8897), y)
CONFIG_PCIE = y
EXTRA_CFLAGS += -DPCIE8897
endif
ifeq ($(CONFIG_PCIE8997), y)
CONFIG_PCIE = y
EXTRA_CFLAGS += -DPCIE8997
endif
ifeq ($(CONFIG_PCIE9097), y)
CONFIG_PCIE = y
EXTRA_CFLAGS += -DPCIE9097
endif
ifeq ($(CONFIG_PCIE9098), y)
CONFIG_PCIE = y
EXTRA_CFLAGS += -DPCIE9098
endif
ifeq ($(CONFIG_SDIO), y)
EXTRA_CFLAGS += -DSDIO
EXTRA_CFLAGS += -DSDIO_MMC
endif
ifeq ($(CONFIG_MUSB), y)
EXTRA_CFLAGS += -DUSB
endif
ifeq ($(CONFIG_PCIE), y)
EXTRA_CFLAGS += -DPCIE
endif

ifeq ($(CONFIG_MAC80211_SUPPORT), y)
EXTRA_CFLAGS += -DMAC80211_SUPPORT
endif
ifeq ($(CONFIG_MAC80211_SUPPORT_UAP), y)
EXTRA_CFLAGS += -DMAC80211_SUPPORT_UAP
endif
ifeq ($(CONFIG_MAC80211_SUPPORT_MESH), y)
EXTRA_CFLAGS += -DMAC80211_SUPPORT_MESH
endif

#############################################################################
# Make Targets
#############################################################################

ifeq ($(CONFIG_WIRELESS_EXT), y)
ifeq ($(CONFIG_WEXT_PRIV), y)
# Enable WEXT for STA
CONFIG_STA_WEXT = y
# Enable WEXT for uAP
CONFIG_UAP_WEXT = y
else
# Disable WEXT for STA
CONFIG_STA_WEXT = n
# Disable WEXT for uAP
CONFIG_UAP_WEXT = n
endif
endif

# Enable CFG80211 for STA
ifeq ($(CONFIG_CFG80211), y)
CONFIG_STA_CFG80211 = y
else
ifeq ($(CONFIG_CFG80211), m)
CONFIG_STA_CFG80211 = y
else
CONFIG_STA_CFG80211 = n
endif
endif

# OpenWrt
ifeq ($(CONFIG_OPENWRT_SUPPORT), y)
ifeq ($(CPTCFG_CFG80211), y)
CONFIG_STA_CFG80211 = y
else
ifeq ($(CPTCFG_CFG80211), m)
CONFIG_STA_CFG80211 = y
else
CONFIG_STA_CFG80211 = n
endif
endif
endif

# Enable CFG80211 for uAP
ifeq ($(CONFIG_CFG80211), y)
CONFIG_UAP_CFG80211 = y
else
ifeq ($(CONFIG_CFG80211), m)
CONFIG_UAP_CFG80211 = y
else
CONFIG_UAP_CFG80211 = n
endif
endif

# OpenWrt
ifeq ($(CONFIG_OPENWRT_SUPPORT), y)
ifeq ($(CPTCFG_CFG80211), y)
CONFIG_STA_CFG80211 = y
else
ifeq ($(CPTCFG_CFG80211), m)
CONFIG_STA_CFG80211 = y
else
CONFIG_STA_CFG80211 = n
endif
endif
endif

ifneq ($(CONFIG_STA_SUPPORT), y)
CONFIG_WIFI_DIRECT_SUPPORT = n
CONFIG_STA_WEXT = n
CONFIG_STA_CFG80211 = n
endif

ifneq ($(CONFIG_UAP_SUPPORT), y)
CONFIG_WIFI_DIRECT_SUPPORT = n
CONFIG_UAP_WEXT = n
CONFIG_UAP_CFG80211= n
endif

ifeq ($(CONFIG_STA_SUPPORT), y)
ifeq ($(CONFIG_STA_WEXT), y)
EXTRA_CFLAGS += -DSTA_WEXT
endif
ifeq ($(CONFIG_STA_CFG80211), y)
EXTRA_CFLAGS += -DSTA_CFG80211
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT), y)
ifeq ($(CONFIG_UAP_WEXT), y)
EXTRA_CFLAGS += -DUAP_WEXT
endif
ifeq ($(CONFIG_UAP_CFG80211), y)
EXTRA_CFLAGS += -DUAP_CFG80211
endif
endif

MOALOBJS =	mlinux/moal_main.o \
		mlinux/moal_ioctl.o \
		mlinux/moal_shim.o \
		mlinux/moal_eth_ioctl.o \
		mlinux/moal_init.o

MLANOBJS =	mlan/mlan_shim.o mlan/mlan_init.o \
		mlan/mlan_txrx.o \
		mlan/mlan_cmdevt.o mlan/mlan_misc.o \
		mlan/mlan_cfp.o \
		mlan/mlan_module.o

MLANOBJS += mlan/mlan_wmm.o
ifeq ($(CONFIG_MUSB), y)
MLANOBJS += mlan/mlan_usb.o
endif
ifeq ($(CONFIG_SDIO), y)
MLANOBJS += mlan/mlan_sdio.o
endif
ifeq ($(CONFIG_PCIE), y)
MLANOBJS += mlan/mlan_pcie.o
endif
MLANOBJS += mlan/mlan_11n_aggr.o
MLANOBJS += mlan/mlan_11n_rxreorder.o
MLANOBJS += mlan/mlan_11n.o
MLANOBJS += mlan/mlan_11ac.o
MLANOBJS += mlan/mlan_11ax.o
MLANOBJS += mlan/mlan_11d.o
MLANOBJS += mlan/mlan_11h.o
ifeq ($(CONFIG_STA_SUPPORT), y)
MLANOBJS += mlan/mlan_meas.o
MLANOBJS += mlan/mlan_scan.o \
			mlan/mlan_sta_ioctl.o \
			mlan/mlan_sta_rx.o \
			mlan/mlan_sta_tx.o \
			mlan/mlan_sta_event.o \
			mlan/mlan_sta_cmd.o \
			mlan/mlan_sta_cmdresp.o \
			mlan/mlan_join.o
ifeq ($(CONFIG_STA_WEXT), y)
MOALOBJS += mlinux/moal_priv.o \
            mlinux/moal_wext.o
endif
endif
ifeq ($(CONFIG_UAP_SUPPORT), y)
MLANOBJS += mlan/mlan_uap_ioctl.o
MLANOBJS += mlan/mlan_uap_cmdevent.o
MLANOBJS += mlan/mlan_uap_txrx.o
MOALOBJS += mlinux/moal_uap.o
ifeq ($(CONFIG_UAP_WEXT), y)
MOALOBJS += mlinux/moal_uap_priv.o
MOALOBJS += mlinux/moal_uap_wext.o
endif
endif
ifeq ($(CONFIG_STA_CFG80211), y)
MOALOBJS += mlinux/moal_cfg80211.o
MOALOBJS += mlinux/moal_cfg80211_util.o
MOALOBJS += mlinux/moal_sta_cfg80211.o
endif
ifeq ($(CONFIG_UAP_CFG80211), y)
MOALOBJS += mlinux/moal_cfg80211.o
MOALOBJS += mlinux/moal_cfg80211_util.o
MOALOBJS += mlinux/moal_uap_cfg80211.o
endif

ifdef CONFIG_PROC_FS
MOALOBJS += mlinux/moal_proc.o
MOALOBJS += mlinux/moal_debug.o
endif

ifeq ($(CONFIG_MAC80211_SUPPORT), y)
MOALOBJS += mlinux/moal_mac80211.o
MLANOBJS += mlan/mlan_mac80211.o
endif

obj-${CONFIG_MXM_WIFIEX_MLAN} := mlan.o
mlan-objs := $(MLANOBJS)

ifeq ($(CONFIG_MUSB), y)
MOALOBJS += mlinux/moal_usb.o
endif
ifeq ($(CONFIG_SDIO), y)
MOALOBJS += mlinux/moal_sdio_mmc.o
endif
ifeq ($(CONFIG_PCIE), y)
MOALOBJS += mlinux/moal_pcie.o
endif

obj-${CONFIG_MXM_WIFIEX_MOAL} += moal.o
moal-objs := $(MOALOBJS)


.PHONY: clean

clean:
	find . -name '*.o*' -exec rm -f {} \;
	rm -rf *.o *.ko *.mod.c *~ .*.cmd *.o.cmd .*.o.cmd *.mod \
	Module.symvers modules.order modules.builtin built-in.a

