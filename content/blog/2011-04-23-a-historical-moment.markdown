---
date: 2011-04-23T00:00:00Z
draft: false
title: A historical moment
tags: [osdev, arm, startup]
---

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
