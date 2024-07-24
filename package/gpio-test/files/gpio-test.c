#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("MIT");

static int myinit(void)
{
    printk(KERN_INFO "hello world\n");
    return 0;
}

static void myexit(void)
{
    printk(KERN_INFO "goodbye cruel world\n");
}

module_init(myinit)
module_exit(myexit)
