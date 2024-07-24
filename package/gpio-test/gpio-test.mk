GPIO_TEST_SITE_METHOD = local
GPIO_TEST_SITE = $(GPIO_TEST_PKGDIR)/files

# Define the name of the kernel module
GPIO_TEST_MODULE_NAME = gpio-test

# Path to the kernel source directory and make options
GPIO_TEST_MAKE_OPTS = \
	KDIR=$(LINUX_DIR) \
	ARCH=$(KERNEL_ARCH) \
	CROSS_COMPILE=$(TARGET_CROSS)

# Build commands to compile the kernel module
define GPIO_TEST_BUILD_CMDS
	$(MAKE) -C $(LINUX_DIR) M=$(GPIO_TEST_PKGDIR)/files $(GPIO_TEST_MAKE_OPTS) modules
endef

# Install the kernel module into the target directory
define GPIO_TEST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(GPIO_TEST_PKGDIR)/files/$(GPIO_TEST_MODULE_NAME).ko \
		$(TARGET_DIR)/lib/modules/$(LINUX_VERSION)$(LINUX_CONFIG_LOCALVERSION)/$(GPIO_TEST_MODULE_NAME).ko
endef

define GPIO_TEST_LINUX_CONFIG_FIXUPS
	# Enable any required kernel options here
endef

$(eval $(kernel-module))
$(eval $(generic-package))
