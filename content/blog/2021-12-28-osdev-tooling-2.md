+++
title = "OSdev tooling continued"
[taxonomies]
tags = ["rust","osdev","vesper","tools"]
+++
This month I spent honing the tooling story. Partially it was driven by the desire to Rewrite All the Things in Rust, and partially by my attempt to integrate all the tooling in a convenient for me way to do things.

Along the way I've done some refactoring and added support for Raspberry Pi 4-specific code.

<!-- more -->

## Chainloading

Almost entire December I spent working on a chainloader - a piece of software that, once written to an SD card will boot the Raspberry Pi board, set up a serial connection with the host machine and load the latest version of the kernel from it. This removes the need for writing new kernels onto the SD card, which gets really annoying after you do it first ten times. It also shortens the debug cycle - you only need to cycle power on the board after you've built yourself an updated kernel version.

I called the chainloader `chainboot`. `Chainofcommand` is the name of the host-side application which listens for the commands from the board serial port and uploads new kernel to the board.

Chainboot is based on the [UART chainloader](https://github.com/rust-embedded/rust-raspberrypi-OS-tutorials/tree/master/06_uart_chainloader) example by Andre Richter, and chainofcommand is largely influenced by the raspbootin's [raspbootcom](https://github.com/mrvn/raspbootin/tree/master/raspbootcom).

Andre's chainloader example uses a miniterm.rb - Ruby-based app, which works less then ideal on my current macOS, the typical invocation looking like:

```
❯ ruby miniterm.rb
Could not find gem 'colorize' in any of the gem sources listed in your Gemfile.
Run `bundle install` to install missing gems.

rust-raspi3-OS-tutorials/common/serial on  master [$?] via 💎 v2.6.8
❯ bundle install
Failed to execute process '/usr/local/bin/bundle'. Reason:
The file '/usr/local/bin/bundle' specified the interpreter '/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby', which is not an executable command.
```

Yes, that's a `ruby 2.6` asking for non-existing `ruby 2.3` while `ruby 3.0` is actually installed via homebrew. And I have zero desire to work on fixing that.

chainofcommand is a pure Rust binary implementing a similar chainloading protocol. New feature I've added is the kernel checksum calculation using `seahash` crate (which has a `no_std` implementation, used on the board side).

## Nucleus code refactoring

Adding a chainloader required some shared code between the regular kernel and the loader. I've extracted the shared implementations into the "machine" crate, which is now consumed by the binaries for the nucleus (the nanokernel) and chainboot (the chainloader).

Since QEMU does not support raspi4 I've had to split support code into two sections and gated them via cargo features - at first I wanted to go with more complicated board + chipset configuration option, but it seems passing `--cfg` parameters to rustc from cargo is not that easy to set up and it lacks flexibility (I would need to rewrite the `.cargo/config.toml` each time with a set of selected cfg options), so I've settled with much simpler gate features named `rpi3` and `rpi4`. The hardware build defaults to rpi4 and the QEMU build automatically chooses rpi3, very convenient.

In the chainloader boot code I've attempted to do the same trick that I did with nucleus and boot entirely in Rust without a single line of assembly. Unfortunately, that didn't work, because chainloader needs to relocate itself from the address it was loaded to. That is tricky to pull off with the way that Rust (and C for that matter) work with linker symbols. In assembly file these addresses are directly patched by the linker, in Rust it goes through additional relocatable indirection and makes it impossible to access this data correctly.

So I had to settle for pure assembly implementation, however I've improved upon the version that Andre did. I now calculate and pass up the maximum allowed kernel size, and Rust code checks this size before loading a new kernel. It thus protects itself from being accidentally overwritten.

I've also improved the code layout organization - compared to the [original](https://github.com/rust-embedded/rust-raspberrypi-OS-tutorials/blob/master/06_uart_chainloader/src/bsp/raspberrypi/link.ld#L30) I've set linker address for the relocation code (the one written in assembly) to [exactly match the load address](https://github.com/metta-systems/vesper/blob/feature/chainboot/bin/chainboot/src/link.ld#L50-L65) 0x80000, so it does not technically need to be position-independent and I might with a few tricks and assumptions actually make it work in pure Rust without assembly in the end.

While doing all his I accidentally broke my serial port implementation, so this New Year's eve I'll be spending bisecting my branches to find where exactly it broke. Happy New Year!

Update 2022-01-04: Fixed and [it's alive](https://gist.github.com/berkus/2b35cee48fc88e1abfd56e21e94a3002)!
