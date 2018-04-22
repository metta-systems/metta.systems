title: Reboot to Rust - Part 2
categories:
    - rust
    - osdev
    - xargo
is_draft: true
---


`-X<- cut line -- below this line text is going to be pruned/moved elsewhere -- cut line -X<-`

Follow https://akappel.github.io/2017/11/07/rpi-crosstool.html

https://spin.atomicobject.com/2016/07/08/rust-embedded-project-example/#.V3-os-6qlZw.hackernews

https://github.com/dpc/titanos/blob/master/src/main.rs one of test kernels in Rust on ARM

### Knowledge bits

One more: https://wiki.osdev.org/Raspberry_Pi_Bare_Bones_Rust

One more: https://elinux.org/RaspberryPi_Osdev

General info on booting RPi3: https://github.com/dwelch67/raspberrypi/tree/master/boards/pi3/aarch64

[rust_on_msp](https://github.com/japaric/rust_on_msp/blob/master/src/main.rs) has some ideas on embedding assembly into Rust code.

[f3](https://github.com/japaric/f3/blob/master/.cargo/config) gave me ideas on how to specify linker scripts to lld via cargo.

[U-boot papers](https://www.suse.com/docrep/documents/a1f0ledpbe/UEFI%20on%20Top%20of%20U-Boot.pdf)

[Some info about RPi3 boot from u-boot](https://github.com/zeldin/u-boot-rpi3/issues/1)

#### Prerequisites

LLD in Rust: — move this elsewhere, lld is currently not very usable for general OSdev

* https://github.com/rust-lang/rust/issues/39915
* https://github.com/rust-lang/rust/pull/40018 `-Z linker-flavor`

The latter also describes steps to build baremetal apps with xargo and lld, quote:

The place where LLD shines is at linking Rust programs that don't depend on
system libraries. For example, here's how you would link a bare metal ARM
Cortex-M program:

```sh
$ xargo rustc --target thumbv7m-none-eabi -- -Z linker-flavor=ld -C linker=ld.lld -Z print-link-args
"ld.lld" \
  "-L" \
  "$XARGO_HOME/lib/rustlib/thumbv7m-none-eabi/lib" \
  "$PWD/target/thumbv7m-none-eabi/debug/deps/app-de1f86df314ad68c.0.o" \
  "-o" \
  "$PWD/target/thumbv7m-none-eabi/debug/deps/app-de1f86df314ad68c" \
  "--gc-sections" \
  "-L" \
  "$PWD/target/thumbv7m-none-eabi/debug/deps" \
  "-L" \
  "$PWD/target/debug/deps" \
  "-L" \
  "$XARGO_HOME/lib/rustlib/thumbv7m-none-eabi/lib" \
  "-Bstatic" \
  "-Bdynamic" \
  "$XARGO_HOME/lib/rustlib/thumbv7m-none-eabi/lib/libcore-11670d2bd4951fa7.rlib"

$ file target/thumbv7m-none-eabi/debug/app
app: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped, with debug_info
```

This doesn't require installing the `arm-none-eabi-gcc` toolchain.

Linker is located in `/usr/local/opt/llvm/bin/lld` in brewed llvm.

@todo try and get lld working for aarch64 linking?

Device tree data is in `arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dtb` in Linux source tree.

### Steps to build code for cross-target

#### 2. Add LLVM targets via rustup

* `rustup target add arm-unknown-linux-musleabihf aarch64-unknown-linux-musl`

We use musl because, [according to japaric](https://github.com/japaric/rust-cross#how-do-i-compile-a-fully-statically-linked-rust-binaries): "For targets of the form `*-*-linux-gnu*`, rustc always produces binaries **dynamically linked to glibc** and other libraries" and we want this to be statically linked.

#### 3. Et Voila! Build.

Using `xargo build --target aarch64-vesper-metta -v` command to build now. Lets see if this is enough to boot.
`xargo rustc --target aarch64-vesper-metta -- -Z linker-flavor=ld -C linker=/usr/local/opt/llvm/bin/ld.lld -Z print-link-arg` to use lld (enough?).

This builds a lib, but perhaps we'd prefer a binary?

#### 4. Link a bootable binary

Let's look it up how other projects do it. Seems that intermezzOS is falling back to makefiles and manual cross-compiler invocation - I don't think this is reasonable.

Solution: build dat kernel as a binary and use cargo to supply custom linker script.

NB: LLD does NOT support linker scripts fully enough in 7.0.0 to be usable for OSdev.

#### 5. RPi3 booting

https://wiki.sel4.systems/Hardware/Rpi3

due to `bootelf` (in u-boot) we don't really need any sophisticated objcopying, simply building an elf image should be enough for kernel.

Build u-boot

```sh
make HOSTCC=clang rpi_3_defconfig
make HOSTCC=clang CROSS_COMPILE=aarch64-unknown-linux-musl- CC=clang -j8
```

#### Writing kernel code - output something via GPIO for start

* [bcm2835 Hardware spec](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2835/BCM2835-ARM-Peripherals.pdf)
* [bcm2836 Register spec](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf)
* [VideoCore iV spec](https://docs.broadcom.com/docs-and-downloads/docs/support/videocore/VideoCoreIV-AG100-R.pdf)
* [VideoCore iV driver source code](https://docs.broadcom.com/docs-and-downloads/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz)
* [Baremetal init routines](https://github.com/brianwiddas/pi-baremetal)
* [Mailbox property interface: How VC communicates with ARM](https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface)
* [ACT LED control on RPi3](https://github.com/vanvught/rpidmx512/blob/master/lib-bcm2835/src/bcm2837_gpio_virt.c) found in [this SO answer](https://raspberrypi.stackexchange.com/a/44177). However, PWR LED is not controllable from software on RPi3 - see [schematics file](https://github.com/raspberrypi/documentation/blob/master/hardware/raspberrypi/schematics/Raspberry-Pi-3B-V1.2-Schematics.pdf) - it's soldered dead.
* [Mailbox interface pages in RPi wiki](https://github.com/raspberrypi/firmware/wiki/Accessing-mailboxes) - see nearby pages for framebuffer, etc.

Important bits:

> With the exception of the property tags mailbox channel, when passing memory addresses as the data part of a mailbox message, the addresses should be bus addresses as seen from the VC. These vary depending on whether the L2 cache is enabled. If it is, physical memory is mapped to start at 0x40000000 by the VC MMU; if L2 caching is disabled, physical memory is mapped to start at 0xC0000000 by the VC MMU. Returned addresses (both those returned in the data part of the mailbox response and any written into the buffer you passed) will also be as mapped by the VC MMU. In the exceptional case when you are using the property tags mailbox channel you should send and receive physical addresses (the same as you'd see from the ARM before enabling the MMU).

* [Example kernel that should work on RPi3](https://github.com/PeterLemon/RaspberryPi/blob/master/HelloWorld/CPU/kernel8.asm)
* Couple [other](https://github.com/BrianSidebotham/arm-tutorial-rpi/blob/master/part-5/armc-014/armc-014.c) [samples](https://github.com/dwelch67/raspberrypi/blob/master/video01/video01.c)
* [Forum thread](https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=155825) these were taken off of.

### Build qemu-rpi3

Clone github.com/bztsrc/qemu-raspi3 and switch to `patches` branch.
Clone github.com/qemu/qemu and apply latest patch from qemu-raspi3 repo.

`./configure --target-list=aarch64-softmmu --enable-debug --enable-modules --enable-tcg-interpreter --enable-debug-tcg --python=/usr/local/bin/python2.7 --prefix=/usr/local/opt/qemu-rpi3`
`make -j5`
`make install`

