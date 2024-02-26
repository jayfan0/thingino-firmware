################################################################################
#
# altobeam atbm60xx wifi driver
#
################################################################################

ATBM60XX_SITE_METHOD = git
ATBM60XX_SITE = https://github.com/openipc/atbm_60xx
ATBM60XX_VERSION = $(shell git ls-remote $(ATBM60XX_SITE) HEAD | head -1 | cut -f1)

ATBM60XX_LICENSE = GPL-2.0

define ATBM60XX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/share/atbm60xx_conf
	$(INSTALL) -m 644 -t $(TARGET_DIR)/usr/share/atbm60xx_conf $(ATBM60XX_PKGDIR)/files/*.txt
endef

ATBM60XX_MODULE_MAKE_OPTS = KSRC=$(LINUX_DIR)

ifeq ($(BR2_PACKAGE_ATBM60XX_MODEL_6012B),y)
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_SDIO_BUS=n
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_USB_BUS=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM603x=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM6012B_COMB=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_MODULE_NAME="atbm6012b"
else ifeq ($(BR2_PACKAGE_ATBM60XX_MODEL_6031),y)
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_USB_BUS=n 
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_SDIO_BUS=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM603x=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_MODULE_NAME="atbm6031"
else ifeq ($(BR2_PACKAGE_ATBM60XX_MODEL_6032),y)
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_USB_BUS=y 
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_SDIO_BUS=n
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM603x=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_MODULE_NAME="atbm6032"
else ifeq ($(BR2_PACKAGE_ATBM60XX_MODEL_6041),y)
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_USB_BUS=n 
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_SDIO_BUS=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM6041=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_MODULE_NAME="atbm6041"
endif
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_MENUCONFIG=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_WIRELESS=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_USE_FIRMWARE_H=y
ATBM60XX_MODULE_MAKE_OPTS += CONFIG_ATBM_WEXT=y

$(eval $(kernel-module))
$(eval $(generic-package))
