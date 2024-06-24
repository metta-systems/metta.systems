+++
title = "Useful cargo commands"
[taxonomies]
categories = ["rust","tools","cargo"]
+++
Some additional cargo commands exist to provide unprecedented level of support and extensibility to regular cargo. Here's a list of commands I use (will be updated over time, last update 2024-05-21):

<!-- more -->

## Commands that run via `cargo`

Sorted alphabetically:

[cargo-aoc](https://github.com/gobanos/cargo-aoc) - Advent of Code helper.

[cargo-asm](https://github.com/gnzlbg/cargo-asm) - see the assembly (with `cargo asm`) or llvm-ir (with `cargo llvm-ir`) generated for Rust code.

[cargo-audit](https://github.com/rustsec/rustsec) - audit Cargo.lock for security vulnerabilities.

[cargo-binutils](https://github.com/rust-embedded/cargo-binutils) - proxy for LLVM tools like llvm-nm, llvm-objdump and llvm-size. Beware of nasty LLVM bugs like [this one](https://github.com/llvm/llvm-project/issues/58407).

[cargo-bloat](https://github.com/RazrFalcon/cargo-bloat) - find out what takes most of the space in your executable.

[cargo-bundle](https://github.com/burtonageo/cargo-bundle) - create OS-specific app bundles from rust binaries.

[cargo-cache](https://github.com/matthiaskrgr/cargo-cache) - manage and clean cargo cache.

[cargo-clippy](https://github.com/rust-lang-nursery/rust-clippy) - over 300 lints to make your Rust code tidy.

[cargo-deny](https://github.com/embarkstudios/cargo-deny) - manage large dependency graphs, check licenses, security advisories or outright ban certain packages.

[cargo-dfu](https://github.com/dfu-rs/cargo-dfu) - flash embedded firmware using DFU.

[cargo-edit](https://github.com/killercup/cargo-edit) -  `cargo add`, `cargo rm`, and `cargo upgrade` Cargo.toml dependencies.

[cargo-expand](https://github.com/dtolnay/cargo-expand) - show result of macro expansion and #[derive] expansion.

[cargo-fix](https://github.com/rust-lang-nursery/rustfix) - automatically apply fix-it suggestions from rustc and clippy to entire project. For better effect, run `cargo clean` first, then `cargo fix --clippy`.

[cargo-fmt](https://github.com/rust-lang-nursery/rustfmt) - format Rust code, applies rustfmt to entire crate.

[cargo-fuzz](https://github.com/rust-fuzz/cargo-fuzz) - use libFuzzer to fuzz your code easily.

[cargo-geiger](https://github.com/anderejd/cargo-geiger) - count number of `unsafe` operations in crate and its dependencies.

[cargo-generate](https://github.com/ashleygwilliams/cargo-generate) - generate cargo project from a given template.

[cargo-graph](https://github.com/kbknapp/cargo-graph) - create GraphViz DOT files and dependency graphs.

[cargo-insta](https://github.com/mitsuhiko/insta) - snapshot testing using [insta](https://insta.rs/).

[cargo-make](https://github.com/sagiegurari/cargo-make) - a decent replacement for make.

[cargo-outdated](https://github.com/kbknapp/cargo-outdated) - display out-of-date dependencies.

[cargo-play](https://github.com/fanzeyi/cargo-play) - instant playground. Run your code from single .rs file like if it was a full rust project.

[cargo-release](https://github.com/sunng87/cargo-release) - for when you're ready to share your crate with the world, automates mundane release tasks - bumping versions, tagging repo, updating docs, etc.

[cargo-src](https://github.com/nrc/cargo-src) - detailed rust source code browser with semantic details.

[cargo-sweep](https://github.com/holmgr/cargo-sweep) - clean unused build files.

[cargo-testify](https://github.com/greyblake/cargo-testify) - show popup notifications about testing results.

[cargo-tree](https://github.com/sfackler/cargo-tree) - visualise crate dependencies as a tree.

[cargo-update](https://github.com/nabijaczleweli/cargo-update) - add `cargo install-update` command to upgrade already installed binaries.

[cargo-vendor](https://github.com/alexcrichton/cargo-vendor) - vendor dependencies into a local directory.

[cargo-watch](https://github.com/passcod/cargo-watch) - add a `cargo watch` command to monitor and rebuild source in case of changes.

[cargo-web](https://github.com/koute/cargo-web) - automatically build and run web projects (use with [parcel](https://github.com/koute/parcel-plugin-cargo-web) for amazing results).

## Standalone commands

Sorted alphabetically:

[aarch64-esr-decoder](https://github.com/google/aarch64-esr-decoder) - decode aarch64 Exception Syndrome Register values quickly.

<!-- [bandwhich]() - -->

[bat](https://github.com/sharkdp/bat) - cat with wings. Replace your cat command with a nicer one by doing "alias cat bat".

<!-- [bingrep]() -

[biodiff]() -

[bootimage]() -

[broot]() -

[cc-cli]() -

[clog-cli]() -

[cocogitto]() -

[commit-emoji]() -

[convco]() -

[dirstat-rs]() -

[dts_viewer]() -

[du-dust]() -

[dua-cli]() -

[elfcat]() -

[exa]() -

[fd-find]() -

[fdtdump]() -

[flamegraph]() -

[git-cliff]() -

[git-work]() -

[grcov]() -

[hck]() -

[hexdmp]() -

[hx]() -

[hyperfine]() -

[jilu]() - -->

[just](https://github.com/casey/just) - a quick and easy tool runner, useful for automating repeated tasks.

<!-- [kibi]() -

[koji]() -

[kokai]() -

[licensor]() -

[miniserve]() -

[probe-rs]() - прошивка МК

[procs]() -

[release-plz]() -

[remote_serial]() -

[resin]() -

[ripgrep]() -

[ruplacer]() -

[rustfilt]() -

[srgn]() -

[starship]() -

[svgbob_cli]() -

[tokei]() -

[trippy]() -

[trunk]() -

[ugdb]() - -->

[version-sync](https://github.com/mgeisler/version-sync) - keep your version number in documentation and elsewhere in sync with version specified in Cargo.toml

<!-- [wasm-pack]() -

[xd]() -

[ytop]() -

[zellij]() - -->
