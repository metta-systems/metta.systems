+++
title = "A historical moment"
# Todo: delete
[taxonomies]
categories = ["osdev","arm","startup"]
+++
``` console
OMAP3 beagleboard.org # mmcinit
OMAP3 beagleboard.org # fatload mmc 0 0x82000000 kernel.bin
reading kernel.bin
640 bytes read
OMAP3 beagleboard.org # go 0x8200024c
## Starting application at 0x8200024C ...
hello, world!
## Application terminated, rc = 0x0
```
