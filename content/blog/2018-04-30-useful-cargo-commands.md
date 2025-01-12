+++
title = "Useful cargo commands"
[taxonomies]
tags = ["rust","tools","cargo"]
+++
Some additional cargo commands exist to provide unprecedented level of support and extensibility
to regular cargo. Here's a list of commands I use (will be updated over time, last update 2025-01-12):

<!-- more -->

## Commands that run via `cargo`

Sorted alphabetically:

{% crate(name="cargo-aoc", gh="gobanos/cargo-aoc") %} - Advent of Code helper.{% end %}

{% crate(name="cargo-audit", gh="rustsec/rustsec") %} - audit Cargo.lock for security vulnerabilities.{% end %}

{% crate(name="cargo-binutils", gh="rust-embedded/cargo-binutils") %} - proxy for LLVM tools like llvm-nm, llvm-objdump and llvm-size. Beware of nasty LLVM bugs like [this one](https://github.com/llvm/llvm-project/issues/58407).{% end %}

{% crate(name="cargo-bloat", gh="RazrFalcon/cargo-bloat") %} - find out what takes most of the space in your executable.{% end %}

{% crate(name="cargo-bundle", gh="burtonageo/cargo-bundle") %} - create OS-specific app bundles from rust binaries.{% end %}

{% crate(name="cargo-cache", gh="matthiaskrgr/cargo-cache") %} - manage and clean cargo cache.{% end %}

{% crate(name="cargo-clippy", gh="rust-lang-nursery/rust-clippy") %} - over 300 lints to make your Rust code tidy.{% end %}

{% crate(name="cargo-deny", gh="embarkstudios/cargo-deny") %} - manage large dependency graphs, check licenses, security advisories or outright ban certain packages.{% end %}

{% crate(name="cargo-dfu", gh="dfu-rs/cargo-dfu") %} - flash embedded firmware using DFU.{% end %}

{% crate(name="cargo-edit", gh="killercup/cargo-edit") %} - `cargo add`, `cargo rm`, and `cargo upgrade` Cargo.toml dependencies.{% end %}

{% crate(name="cargo-expand", gh="dtolnay/cargo-expand") %} - show result of macro expansion and `#[derive]` expansion.{% end %}

{% crate(name="cargo-fix", gh="rust-lang-nursery/rustfix") %} - automatically apply fix-it suggestions from rustc and clippy to entire project. For better effect, run `cargo clean` first, then `cargo fix --clippy`.{% end %}

{% crate(name="cargo-fmt", gh="rust-lang-nursery/rustfmt") %} - format Rust code, applies rustfmt to entire crate.{% end %}

{% crate(name="cargo-fuzz", gh="rust-fuzz/cargo-fuzz") %} - use libFuzzer to fuzz your code easily.{% end %}

{% crate(name="cargo-geiger", gh="anderejd/cargo-geiger") %} - count number of `unsafe` operations in crate and its dependencies.{% end %}

{% crate(name="cargo-generate", gh="ashleygwilliams/cargo-generate") %} - generate cargo project from a given template.{% end %}

{% crate(name="cargo-graph", gh="kbknapp/cargo-graph") %} - create GraphViz DOT files and dependency graphs.{% end %}

{% crate(name="cargo-insta", gh="mitsuhiko/insta") %} - snapshot testing using [insta](https://insta.rs/).{% end %}

{% crate(name="cargo-make", gh="sagiegurari/cargo-make") %} - a decent replacement for make.{% end %}

{% crate(name="cargo-outdated", gh="kbknapp/cargo-outdated") %} - display out-of-date dependencies.{% end %}

{% crate(name="cargo-play", gh="fanzeyi/cargo-play") %} - instant playground. Run your code from single .rs file like if it was a full rust project.{% end %}

{% crate(name="cargo-release", gh="sunng87/cargo-release") %} - for when you're ready to share your crate with the world, automates mundane release tasks - bumping versions, tagging repo, updating docs, etc.{% end %}

{% crate(name="cargo-show-asm", gh="pacak/cargo-show-asm") %} - see the assembly (with `cargo asm --asm`) or llvm-ir (with `cargo asm --llvm` or `--llvm-input`) generated for Rust code. This is an updated version
of the unmaintained `cargo-asm` crate. Install with `cargo install --locked --all-features cargo-show-asm`.{% end %}

{% crate(name="cargo-src", gh="nrc/cargo-src") %} - detailed rust source code browser with semantic details.{% end %}

{% crate(name="cargo-sweep", gh="holmgr/cargo-sweep") %} - clean unused build files.{% end %}

{% crate(name="cargo-testify", gh="greyblake/cargo-testify") %} - show popup notifications about testing results.{% end %}

{% crate(name="cargo-tree", gh="sfackler/cargo-tree") %} - visualise crate dependencies as a tree.{% end %}

{% crate(name="cargo-update", gh="nabijaczleweli/cargo-update") %} - add `cargo install-update` command to upgrade already installed binaries.{% end %}

{% crate(name="cargo-vendor", gh="alexcrichton/cargo-vendor") %} - vendor dependencies into a local directory.{% end %}

{% crate(name="cargo-watch", gh="passcod/cargo-watch") %} - add a `cargo watch` command to monitor and rebuild source in case of changes.{% end %}

{% crate(name="cargo-web", gh="koute/cargo-web") %} - automatically build and run web projects (use with [parcel](https://github.com/koute/parcel-plugin-cargo-web) for amazing results).{% end %}

## Standalone commands

Sorted alphabetically:

{% crate(name="aarch64-esr-decoder", gh="google/aarch64-esr-decoder") %} - decode aarch64 Exception Syndrome Register values quickly.{% end %}

{% crate(name="bandwhich", gh="imsnif/bandwhich") %} - a CLI network monitor.{% end %}

{% crate(name="bat", gh="sharkdp/bat") %} - cat with wings. Replace your cat command with a nicer one by doing "alias cat bat".{% end %}

{% crate(name="bingrep", gh="m4b/bingrep") %} - cross-platform binary parser and colorizer. See binary file headers in a nice way.{% end %}

{% crate(name="biodiff", gh="8051enthusiast/biodiff") %} - compare binary files using sequence alignment. Makes it easier to see diffs in files that are aaaalmost the same.{% end %}

{% crate(name="bootimage", gh="rust-osdev/bootimage") %} - create a bootable OS image from a kernel binary. Integrates with cargo.{% end %}

{% crate(name="broot", gh="canop/broot") %} - a CLI file manager with nice tree navigation.{% end %}

{% crate(name="cc-cli", gh="sousandrei/cc-cli") %} - git hook for conventional commits - "git commit" and pick details using a CLI.{% end %}

{% crate(name="clog-cli", gh="clog-tool/clog-cli") %} - conventional commits changelog generator. Old.{% end %}

{% crate(name="cocogitto", gh="cocogitto/cocogitto") %} - conventional commits swiss army knife. Does everything.{% end %}

{% crate(name="commit-emoji", gh="berkus/commit-emoji") %} - git hook to add emoji to your conventional commits. Disclosure: This is my crate.{% end %}

{% crate(name="convco", gh="convco/convco") %} - conventional commits tooling, similar to cocogitto.{% end %}

{% crate(name="dirstat-rs", gh="scullionw/dirstat-rs") %} - graphical (CLI) directory tree size statistics. Really nice and fast.{% end %}

{% crate(name="dts_viewer", gh="yodaldevoid/dts_viewer") %} - a CLI viewer for device tree files (DTS, source).{% end %}

{% crate(name="du-dust", gh="bootandy/dust") %} - graphical (CLI) disk usage statistics. Pretty and fast.{% end %}

{% crate(name="dua-cli", gh="byron/dua-cli") %} - Disk Usage Analyzer. Graphical (CLI) disk usage statistics.{% end %}

{% crate(name="elfcat", gh="ruslashev/elfcat") %} - generates a cross-referenced HTML file with contents of an input ELF binary.{% end %}

{% crate(name="erdtree", gh="solidiquis/erdtree") %} - a nicely looking file tree. Be sure to set up one of [Nerd Fonts](https://nerdfonts.com) in your terminal.{% end %}

{% crate(name="eza", gh="eza-community/eza") %} - a modern `ls` replacement. Do `alias ls eza`.{% end %}

{% crate(name="fd-find", gh="sharkdp/fd") %} - super fast and simple alternative to `find`. Do `alias find fd` for your interactive sessions (the CLI is not compatible with find so keep the scripts happy).{% end %}

{% crate(name="fdtdump", gh="rs-embedded/fdtdump") %} - dump device tree files (DTB, compiled).{% end %}

<!-- [flamegraph]() -

[git-cliff]() -

[git-work]() -

[grcov]() -

[hck]() -

[hexdmp]() -

[hx]() -

[hyperfine]() -

[jilu]() - -->

{% crate(name="just", gh="casey/just") %} - a quick and easy tool runner, useful for automating repeated tasks.{% end %}

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

{% crate(name="version-sync", gh="mgeisler/version-sync") %} - keep your version number in documentation and elsewhere in sync with version specified in Cargo.toml{% end %}

<!-- [wasm-pack]() -

[xd]() -

[ytop]() -

[zellij]() - -->
