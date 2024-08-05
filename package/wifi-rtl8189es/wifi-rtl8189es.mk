WIFI_RTL8189ES_SITE_METHOD = git
WIFI_RTL8189ES_SITE = https://github.com/jwrdegoede/rtl8189es_linux.git
WIFI_RTL8189ES_VERSION = $(shell git ls-remote $(WIFI_RTL8189ES_SITE) master | head -1 | cut -f1)

WIFI_RTL8189ES_LICENSE = GPL-2.0

WIFI_RTL8189ES_MODULE_MAKE_OPTS = \
	KSRC=$(LINUX_DIR) \
	KVER=$(LINUX_VERSION_PROBED) \
	CONFIG_RTL8189ES=m

define WIFI_RTL8189ES_LINUX_CONFIG_FIXUPS
		$(call KCONFIG_ENABLE_OPT,CONFIG_WLAN)
		$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
		$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS_EXT)
		$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_CORE)
		$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_PROC)
		$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_PRIV)
		$(call KCONFIG_SET_OPT,CONFIG_CFG80211,y)
		$(call KCONFIG_SET_OPT,CONFIG_MAC80211,y)
		$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_MINSTREL)
		$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_MINSTREL_HT)
		$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_DEFAULT_MINSTREL)
		$(call KCONFIG_SET_OPT,CONFIG_MAC80211_RC_DEFAULT,"minstrel_ht")
endef

$(eval $(kernel-module))
$(eval $(generic-package))
