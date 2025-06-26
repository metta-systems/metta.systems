+++
title = "Rust on Sipeed Longan Nano board"
[taxonomies]
tags = ["rust","embedded"]
+++
My [Longan Nano board](https://www.seeedstudio.com/Sipeed-Longan-Nano-RISC-V-GD32VF103CBT6-Development-Board-p-4205.html) has arrived and I tried to run Rust on it. It's a great success and here's how.

Nano is a RISC-V microcontroller (GD32VF103) with impressive GPIO capabilities and connectivity - it has a serial, JTAG and USB Type-C ports plus numerous GPIO pins on breakout connectors. It is also very well documented: there are board schematics, CPU and Peripheral datasheets, and numerous programming examples.

<!-- more -->

I'm on OSX so your mileage may vary. I started from a blog post [here](https://pramode.net/2019/10/07/rust-on-riscv-board-sipeed-longan-nano/).

```sh
git clone https://github.com/pcein/rust-sipeed-longan-nano
```

I use {{ crate(name="cargo-xbuild") }} to build and {{ crate(name="cargo-binutils") }} to perform various object manipulation tasks, so install them first.

```sh
cargo install cargo-xbuild cargo-binutils
```

I added some handy changes to the source code [here](https://github.com/pcein/rust-sipeed-longan-nano/pull/1) - it is not yet merged as of time of this writing.

With these changes in hand you can simply build a debug version of the example using `make`.

Next step is to write it to the device. Nano supports DFU protocol of the USB standard which makes it almost easy. Almost, because you need to build a DFU util with Nano support first.

```sh
git clone git@github.com:riscv-mcu/gd32-dfu-utils.git
cd gd32-dfu-utils
./configure --prefix=/usr/local/opt/gd32-dfu-utils
make install
```

Now you have `/usr/local/opt/gd32-dfu-utils/bin/dfu-util` which you can use to flash your device.

Add the following to your Makefile to make it even easier:

```make
dfu: all
    /usr/local/opt/gd32-dfu-utils/bin/dfu-util -a 0 --dfuse-address 0x08000000:leave -D rust-sipeed-longan-nano.bin
```

Don't forget to use tabs to indent the make commands, otherwise make will complain.

Now actually flashing the device goes as simple as the following:

1. Plug your device using USB Type-C cable to your laptop.
2. Hold BOOT0 button on the device and press RESET0 button once - this will switch the device to DFU mode.
3. Run `make dfu` to download the firmware to the device.

You should see the green LED blinking.

Note that I did not use `riscv-gnu-toolchain` for building as it is generally not required - `cargo-binutils` can do everything by using the LLVM tools.

## JTAG debugger

Since I have a JLink I will write the configuration steps from JLink standpoint.

First of all, figure out the necessary wiring.

```
Func  | JLink Pin | Wire color | Target pin
------+-----------+------------+-----------
TCK   |     9     |   yellow   |   JTCK
TMS   |     7     |   brown    |   JTMS
TDI   |     5     |   green    |   JTDI
TDO   |    13     |   orange   |   JTDO
VTref |     1     |   white    |    3V3
GND   |     4     |   black    |    GND
```

You may choose your own wiring colors of course, I just settled for these and try to keep them consistent between boards.

The OpenOCD for macOS that is bundled with Nano did not work, so I went and built a new one from git.

```sh
git clone git@github.com:riscv-mcu/riscv-openocd.git
# This shall clone you a branch called nuclei-cjtag - check that it did
./configure --enable-jlink --prefix=/usr/local/opt/openocd-425828274-riscv --disable-doxygen-html
make install
```

The config file from bundled openocd is however working, so you can copy it from there. I will post it here to save you unnecessary downloads:

openocd_jlink.cfg:

```tcl
adapter_khz     1000
reset_config srst_only
adapter_nsrst_assert_width 100

interface jlink
jlink usb 0

transport select jtag

set _CHIPNAME riscv
jtag newtap $_CHIPNAME cpu -irlen 5 -expected-id 0x1000563d

set _TARGETNAME $_CHIPNAME.cpu
target create $_TARGETNAME riscv -chain-position $_TARGETNAME
$_TARGETNAME configure -work-area-phys 0x20000000 -work-area-size 20480 -work-area-backup 0


# Work-area is a space in RAM used for flash programming
if { [info exists WORKAREASIZE] } {
   set _WORKAREASIZE $WORKAREASIZE
} else {
   set _WORKAREASIZE 0x5000
}

# Allow overriding the Flash bank size
if { [info exists FLASH_SIZE] } {
    set _FLASH_SIZE $FLASH_SIZE
} else {
    # autodetect size
    set _FLASH_SIZE 0
}

# flash size will be probed
set _FLASHNAME $_CHIPNAME.flash

flash bank $_FLASHNAME gd32vf103 0x08000000 0 0 0 $_TARGETNAME
riscv set_reset_timeout_sec 1
init

halt
```

Place this file SOMEWHERE and add the following target to your Makefile:

```make
ocd:
    /usr/local/openocd-425828274-riscv/bin/openocd -f SOMEWHERE/openocd_jlink.cfg
```

With JLink connected to your machine, run `make ocd` to connect to the device.

```sh
$ make ocd
/usr/local/openocd-425828274-riscv/bin/openocd -f SOMEWHERE/openocd_jlink.cfg
Open On-Chip Debugger 0.10.0+dev-00918-g425828274 (2019-11-16-22:34)
Licensed under GNU GPL v2
For bug reports, read
    http://openocd.org/doc/doxygen/bugs.html
Info : J-Link V9 compiled Oct 25 2018 11:46:07
Info : Hardware version: 9.60
Info : VTarget = 3.259 V
Info : clock speed 1000 kHz
Info : JTAG tap: riscv.cpu tap/device found: 0x1e200a6d (mfg: 0x536 (Nuclei System Technology Co.,Ltd.), part: 0xe200, ver: 0x1)
Warn : JTAG tap: riscv.cpu       UNEXPECTED: 0x1e200a6d (mfg: 0x536 (Nuclei System Technology Co.,Ltd.), part: 0xe200, ver: 0x1)
Error: JTAG tap: riscv.cpu  expected 1 of 1: 0x1000563d (mfg: 0x31e (Andes Technology Corporation), part: 0x0005, ver: 0x1)
Info : JTAG tap: auto0.tap tap/device found: 0x790007a3 (mfg: 0x3d1 (GigaDevice Semiconductor (Beijing)), part: 0x9000, ver: 0x7)
Error: Trying to use configured scan chain anyway...
Warn : AUTO auto0.tap - use "jtag newtap auto0 tap -irlen 5 -expected-id 0x790007a3"
Warn : Bypassing JTAG setup events due to errors
Info : datacount=4 progbufsize=2
Info : Examined RISC-V core; found 1 harts
Info :  hart 0: XLEN=32, misa=0x40901105
Info : Listening on port 3333 for gdb connections
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
```

## GDB

I built GDB from the [riscv-gnu-toolchain](http://example.com) sources. While it can step through the instructions and show register contents, it for some reason couldn't properly work with disassembly and source code navigation. I will work more on getting it to work correctly and will update this post when done.

```sh
➤ make gdb
/usr/local/opt/gdb-c3eb407852-riscv/bin/riscv32-elf-gdb target/riscv32imac-unknown-none-elf/debug/rust-sipeed-longan-nano
GNU gdb (GDB) 8.3.0.20190516-git
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "--host=x86_64-apple-darwin19.0.0 --target=riscv32-elf".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from target/riscv32imac-unknown-none-elf/debug/rust-sipeed-longan-nano...
(gdb) l
1   #![feature(global_asm, asm)]
2   #![no_main]
3   #![no_std]
4
5   // LED's on PC13, PA1 and PA2
6   // We will use PA1 (green only)
7
8   const RCU_APB2EN: u32 = (0x4002_1000 + 0x18);
9
10  const GPIOA_CTL0: u32 = (0x4001_0800 + 0x0);
(gdb) target remote :3333
Remote debugging using :3333
0x000004fe in ?? ()
(gdb) n
Cannot find bounds of current function
(gdb) s
Cannot find bounds of current function
(gdb) disass
No function contains program counter for selected frame.
(gdb) info r
ra             0x4c6    0x4c6
sp             0x20007f30   0x20007f30
gp             0x0  0x0
tp             0x0  0x0
t0             0x0  0
t1             0x0  0
t2             0x0  0
fp             0x20007f60   0x20007f60
s1             0x0  0
a0             0x1  1
a1             0x120a4  73892
a2             0x0  0
a3             0x20007f84   536903556
a4             0x0  0
a5             0x0  0
a6             0x0  0
a7             0x0  0
s2             0x0  0
s3             0x0  0
s4             0x0  0
s5             0x0  0
s6             0x0  0
s7             0x0  0
s8             0x0  0
s9             0x0  0
s10            0x0  0
s11            0x0  0
t3             0x0  0
t4             0x0  0
t5             0x0  0
t6             0x0  0
pc             0x4fe    0x4fe
(gdb) nexti
0x00000500 in ?? ()
(gdb) nexti
0x00000504 in ?? ()
(gdb) nexti
0x00000508 in ?? ()
(gdb) nexti
0x00000d30 in ?? ()
(gdb) nexti
0x00000d32 in ?? ()
(gdb) nexti
0x00000d34 in ?? ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x00000fb2 in ?? ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x0000021a in ?? ()
(gdb) ^CQuit
(gdb) q
```

The OpenOCD side at the same time shows GDB connection:

```
Info : accepting 'gdb' connection on tcp/3333
Info : device id = 0x19060410
Info : flash_size_in_kb = 0x00000080
Info : flash size = 128kbytes
Info : dropped 'gdb' connection
```

## LLDB

Build instructions based on [sifive/riscv-llvm](https://github.com/sifive/riscv-llvm).

LLDB at this moment DOES NOT SUPPORT riscv, so it cannot be used.

## General GD32VF103 info

[longan-nano-gd32vf103](https://www.susa.net/wordpress/2019/10/longan-nano-gd32vf103/) has lots of information.
