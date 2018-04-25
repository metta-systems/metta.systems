+++
title = "Using Flyswatter with RPi3"
draft = true
+++
Setting up Flyswatter for RPi3

(blog post)

1. Pinout
* Check if u-boot has code to enable JTAG GPIO on rpi3 - some post [here](https://community.arm.com/tools/f/discussions/9770/raspberry-pi-3-dstream-jtag-debugging) mentions that it could.
(u-boot/arch/arm/dts/bcm283x.dtsi has mentions of jtag gpio pins, see also BCM2835_FSEL_ALT3 for possible ALT change constants)
2. Updating connectors
3. Patching openocd
* Daniel-k [openocd](https://github.com/daniel-k/openocd) and [rpi3-aarch64-jtag](https://github.com/daniel-k/rpi3-aarch64-jtag) should be used for controlling the RPi3.
* Try with his original armv8 branch first, then try my rebase.

---

idea:
Use RPi2 as JTAG for RPi3 (https://github.com/synthetos/PiOCD/wiki/Using-a-Raspberry-Pi-as-a-JTAG-Dongle)
Use RPi2 as JTAG http://www.stm32duino.com/viewtopic.php?t=940

---

Forum topic https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=150213

Howto https://sysprogs.com/VisualKernel/tutorials/raspberry/jtagsetup/

---

Note from https://github.com/dwelch67/raspberrypi/tree/master/armjtag

> The flyswatter breaks out the uart, but we cant use it with the raspberry pi because it is at RS232 levels and if you were to connect it to the raspberry pi you will likely damage one board or the other or both.

---

Some student's notes about [JTAG for RPi1](https://wiki.aalto.fi/download/attachments/84747235/rpi_jtag.pdf?version=3&modificationDate=1386972920322&api=v2)
