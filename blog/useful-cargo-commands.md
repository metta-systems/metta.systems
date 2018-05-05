title: Useful cargo commands
categories:
  - rust
  - tools
  - cargo-xargo
published_date: "2018-04-30 23:51:59 +0000"
is_draft: false
---
Some additional cargo commands exist to provide unprecedented level of support and extensibility to regular cargo. Here's a list of commands I use (will be updated over time, last update 2018-05-01):

[cargo-edit](https://github.com/killercup/cargo-edit) -  `cargo add`, `cargo rm`, `cargo upgrade` Cargo.toml dependencies.

[cargo-watch](https://github.com/passcod/cargo-watch) - add a `cargo watch` command to monitor and rebuild source in case of changes.

[cargo-bloat](https://github.com/RazrFalcon/cargo-bloat) - find out what takes most of the space in your executable.

[cargo-asm](https://github.com/gnzlbg/cargo-asm) - see the assembly (with `cargo asm`) or llvm-ir (with `cargo llvm-ir`) generated for Rust code.

[cargo-clippy](https://github.com/rust-lang-nursery/rust-clippy) - over 300 lints to make your Rust code tidy.

[cargo-expand](https://github.com/dtolnay/cargo-expand) - show result of macro expansion and #[derive] expansion.

[cargo-fmt](https://github.com/rust-lang-nursery/rustfmt) - format Rust code, applies rustfmt to entire crate.

[cargo-graph](https://github.com/kbknapp/cargo-graph) - create GraphViz DOT files and dependency graphs.

[cargo-update](https://github.com/nabijaczleweli/cargo-update) - add `cargo install-update` command to upgrade already installed binaries.

[cargo-src](https://github.com/nrc/cargo-src) - detailed rust source code browser with semantic details.

[cargo-testify](https://github.com/greyblake/cargo-testify) - show popup notifications about testing results.

[cargo-tree](https://github.com/sfackler/cargo-tree) - visualise crate dependencies as a tree.

[cargo-vendor](https://github.com/alexcrichton/cargo-vendor) - vendor dependencies into a local directory.

[cargo-web](https://github.com/koute/cargo-web) - automatically build and run web projects (use with [parcel](https://github.com/koute/parcel-plugin-cargo-web) for amazing results).

