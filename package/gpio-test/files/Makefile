# gpio-test/Makefile

obj-m += gpio-test.o

all:
	make -C $(KDIR) M=$(PWD) CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH) modules

clean:
	make -C $(KDIR) M=$(PWD) clean
