+++
title = "OSdev tooling"
[taxonomies]
tags = ["rust","osdev","vesper","tools"]
+++
Since my first attempt at OSdev in x86 assembly I've constantly strived to make my setup comfortable. With rust I finally achieved a nearly zero-configuration flow. There are still some tools to install but they are either a `cargo install just` away or entirely optional.

Developing an OS in Rust gives an opportunity to apply the benefits of the entire Rust ecosystem, so I've decided to maximally utilise what it has to offer.

<!-- more -->

See also: [Useful cargo commands](/blog/useful-cargo-commands), [Amos' Rust workflow](https://fasterthanli.me/articles/my-ideal-rust-workflow)

## Just

Just is just a make clone, quite simplified, with simpler and more predictable rules and.. written in rust. I use `just` as an entry point to the entire workflow. The [top level Justfile](https://github.com/metta-systems/vesper/blob/develop/Justfile) contains a number of targets to build, test, run in qemu, deploy to device, browse disassembly, generate and open docs. Most of these commands invoke either an external tool, or a subcommand of `cargo-make`.

## cargo-make

`cargo-make` is.. another make clone, but implemented entirely differently, very tightly integrated into cargo and rust infrastructure. For example, it uses `rustup` or `cargo` to install missing binary crates for the commands you invoke. It also includes a cross-platform scripting language which allows me to run [CI jobs on windows](https://github.com/metta-systems/vesper/actions/workflows/build.yml) without fear. Its hierarchical organization lends itself nicely to cargo workspace usage. It's "makefiles" are written in TOML, just like many other Rust project configuration files, and the syntax is more predictable and better documented than that of the GNU make. Definitely fewer underwater stones.

Together `just` and `cargo-make` give a flexible powerful environment which requires very little keystrokes.

## Hopper Disassembler

[Hopper](https://hopperapp.com) is a very nice disassembly tool, like IDA Pro but for macOS. I use it for many years to inspect the resulting assembly code and explore possible miscompilations. Disclaimer: it is a paid software. In my setup it's available via `just hopper` invocation.

## Running RaspberryPi emulation with all serial ports access

Last in this list, but very important step is being able to run QEMU emulation of my board and have handy access to all the control knobs from my terminal. I've used tmux setup made by [@andre-richter](https://github.com/andre-richter) previously, but recently tmux started failing citing some incompatibilities with fish, starship and general color terminals. Rather than trying to fix this powerful, but clearly overpowered for my needs tool, I decided to take a look at other available options and found `zellij`. Named after a [style of tilework](https://en.wikipedia.org/wiki/Zellij) popular in Morocco, this tool lets you define a terminal layout template and launch various scripts in those panes. With the help of zellij discord dwellers [@a-kenji](https://github.com/a-kenji) and [@imsnif](https://github.com/imsnif) I managed to put together a template that mimics the setup of my old tmux script, looks better and works _heaps_ better than that.

Now, combining the power of `just`, `cargo-make` and `zellij` together all you need in order to run qemu with the latest build of the kernel in a pretty serial console emulation is... just type `just`. Cargo make will install necessary rust toolchain, install zellij if it wasnt installed yet and launch $QEMU with necessary arguments. That's it!

It looks like this:

![zellij qemu runner](/images/zellij-qemu1.jpg)

And the layout file with all the necessary scripts is available [here](https://github.com/metta-systems/vesper/tree/improve-kernel-bringup/emulation).

That's it for today, please leave a comment with feedback - I'm doing this to improve my motivation and feedback helps. I hope to write more about tooling and the OS (and the osdev process) itself next month!
