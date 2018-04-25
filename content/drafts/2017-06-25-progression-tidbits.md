+++
title = "Progression Tidbits"
draft = true
+++
# Reevaluate goals and start anew

- pick microkernel design to have mechanisms but no policies
- pick genode for building blocks
- set goals plan using sel4 and genode components, plus rumprun to run device drivers?

> it even has its own name in Urdu: Watta Satta, which means give and take.
> - http://www.thenational.ae/world/south-asia/pakistani-man-exchanges-daughter-13-for-a-second-wife


# February 2017

Progress:

- u-boot with bootelf command built from github sources (beagleboard/u-boot) with CONFIG_CMD_ELF=y added
- build beagle_debug_xml sel4test image
  - com port output not working?
      + disable output buffering...
      + disable XML output

- JTAG Flyswatter arrived

# Important minicom config lines:

```
pu port             /dev/tty.usbserial-FS000000B
pu rtscts           No
pu xonxoff          No
pu localecho        No
```

# How to start openocd:

```
# Free up ftdi device
sudo kextunload -b com.apple.driver.AppleUSBFTDI
# Run Open-OCD
sudo openocd -f interface/ftdi/flyswatter.cfg -f board/ti_beagleboard.cfg -c init -c "reset init"
```

How to run both serial and jtag at the same time:

https://kernelnomicon.org/?p=33

https://developer.apple.com/library/content/releasenotes/MacOSX/WhatsNewInOSX/Articles/MacOSX10_9.html#//apple_ref/doc/uid/TP40013207-CH100

> Kernel extensions signed using the newer signing tools are incompatible with OS X v10.7.5 and earlier. If you are producing a kernel extension that must support versions of the operating system prior to version 10.8, you must install an unsigned copy in /System/Library/Extensions, in addition to any signed copy in /Library/Extensions. Versions of OS X prior to version 10.9 will ignore the signed copy in /Library/Extensions. If the user upgrades to OS X v10.9 or later, the user’s system will prefer the signed copy in /Library/Extensions.

After editing the Info.plist use `csrutil disable` to allow loading unsigned kexts.

- sel4test started:

# Since elf is built to START from ${loadaddr}, load it somewhere else:
mmc rescan
fatload mmc 0 0x80300000 sel4
bootelf 0x80300000


....
200/200 tests passed.
All is well in the universe.

# Nitpicks

Secure verified code, my ass!

```
src/kernel/thread.c:125:13: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
    if ((!!(!seL4_Fault_get_seL4_FaultType(sender->tcbFault) != seL4_Fault_NullFault))) {
```

- compile things with clang

0. clang -S -mllvm --x86-asm-syntax=intel helloworld.c

1. need to configure target triple for cross-compiling, see http://clang.llvm.org/docs/CrossCompilation.html

For beagleboard it's `-target armv7a-unknown-none-elf -mcpu=cortex-a8`

- completed seL4 build with clang, some patches in clang-build branch
  - one nitpick is insane asm files mangling by the default makefile...

- now need to test it on the board! - need to build sel4test for that (also via clang?)

# July 2017

Updating seL4 to release 6.0.0 with SMP support on ARM.

## TODO

- make out-of-sourcedir builds

right now pollutes source dir with build artifacts
