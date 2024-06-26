+++
title = "Reboot to Rust"
[taxonomies]
tags = ["rust","osdev","cargo"]
+++
### Fast forward four years...

And the landscape is changed again. The idea to write a secure robust kernel and then build a secure robust operating system on it is still there. However, there are new tools, technologies as well as new [hazards](https://spectreattack.com/).

One of the new tools is Rust language. The tenets of Rust are speed, safety and [fearless concurrency](https://doc.rust-lang.org/book/second-edition/ch16-00-concurrency.html). This makes it nearly ideal language for writing new secure software, including kernels. Robigalia project is also looking towards [semi-automatic assurance of Rust-based software](https://robigalia.org/blog/2016/11/15/verfication.html) by leveraging the MIR intermediate representation as containing the semantic information about the program, which we can reason about. Looking forward to seeing what this brings, meanwhile I set out to write an equivalent of seL4 kernel in Rust for 64-bit systems.

I've intentionally dropped support for 32-bit systems at the moment, it should be possible to retrofit 32-bit support into the kernel APIs - they will just become either slower or more limited. Just don't focus on these now.

So the primary targets are `x86_64` and `aarch64`. And I'm going to start by collecting the Embedded Rust community knowledge and using it to build a baremetal Rust "kernel" that could speak to some UART device, starting with Raspberry Pi 3 board - since I have that one and have JTAG debugger for it.

Let's go.

<!-- more -->

### Hardware

RPi3 by default does not have LED controls, so our next targets could be talking to mini-UART connected through the GPIO pins and talking to VideoCore IV processor and outputting data directly on screen.

They sound like very different things in terms of effort but in reality in both cases we just need to read and write some addresses of memory.

### Software

Steve Klabnik has written an indispensable helper for everybody doing OSdev in rust - [IntermezzOS](http://intermezzos.github.io/).

Philipp Oppermann did awesome series of deep, detailed and very well explained articles on getting an x86_64 OS kernel going in Rust - [read his OSdev blog](https://os.phil-opp.com/).

Jorge Aparicio has done a tremendous job supporting Rust on the embedded platforms, various microcontrollers etc. [His repositories](https://github.com/japaric/) are an endless source of inspiration.

### Prerequisites

To build the kernel we will need to configure rust for cross-compilation and also create some helper binaries - we will need LD and, at a later stage, objcopy for our target system.

#### Building cross-binutils

So, lets grab [binutils](https://www.gnu.org/software/binutils/)

```sh
git clone git://sourceware.org/git/binutils-gdb.git
```

Configure it to produce the right binaries:

```sh
cd binutils-gdb/_build_
../configure --target aarch64-unknown-linux-musl --disable-gold
make -j4
cp binutils/objcopy bin/aarch64-unknown-linux-musl-objcopy
cp ld/ld-new bin/aarch64-unknown-linux-musl-ld
```

Put the path to this `bin/` directory into your PATH so we can later find these tools.

[This repo by japaric](https://github.com/japaric/rust-cross) contains detailed instructions on setting up Rust for cross-compiling. Refer to it if something doesn't work or you're just curious.

#### Install and select nightly compiler.

From intermezzOS tutorial: `rustup override set nightly` in the project directory.

#### Define targets

You need to declare a target in order to build binaries for it. Rust makes it really simple by providing a way to declare your own targets based on built-in ones.

japaric has a description and useful links on these in the [Compiling the sysroot for a custom target](https://github.com/japaric/xargo#compiling-the-sysroot-for-a-custom-target) chapter for Xargo. He also describes how to properly generate one:

```sh
rustc -Z unstable-options --print target-spec-json \
    --target aarch64-unknown-linux-musl \
    | tee targets/aarch64-vesper-metta.json
```

`targets/` directory currently contains these definitions (but they are ought to be in a separate repo similar to robigalia's `sel4-targets`).

`set -x RUST_TARGET_PATH (pwd)/targets/` before running xargo.

See [here](https://github.com/japaric/rust-cross#the-target-triple) for a nice description of the target triples. `aarch64-unknown-metta` (or `aarch64-none-metta`) should be ok for start. [Here](http://intermezzos.github.io/book/first-edition/setup.html) explains that it probably should be `aarch64-unknown-none` for bare metal. And the userspace would be `aarch64-vesper-metta`.

intermezzOS tutorial handles this bit down the road in the [First Rust chapter](http://intermezzos.github.io/book/first-edition/creating-our-first-crate.html).

PhilOS also mentions it [here](https://os.phil-opp.com/set-up-rust/#target-specifications).

