+++
title = "Building WASM with Rust"
[taxonomies]
categories = ["rust","wasm","web"]
+++
There are several options to build Rust into WebAssembly. `cargo-web` was the preferred way for `yew`, but nowadays yew also supports wasm-bindgen and this opens up some possibilities for javascript interop.

<!-- more -->

First, you will need to install some tools:

```sh
cargo install wasm-pack
yarn global add parcel
yarn add -D parcel-plugin-wasm.rs
```

Write some of the dependencies into Cargo.toml, use versions at least as specified here to enable wasm-bindgen support.

```toml
[dependencies]
yew = "0.7.0"
stdweb = "0.4.17"
console_error_panic_hook = "0.1.6"
log = "0.4.7"
wasm-bindgen = "^0.2"
web_logger = "0.2.0"

[lib]
crate-type = ["cdylib", "rlib"]   # IMPORTANT!
```

Add some helper lines to yarn config:

```json
"scripts": {
    "start": "parcel index.html",
    "build": "parcel build index.html"
  },
```

`yarn start` will do a hot-reloadable debug build of your code. It takes some time on first run to build rust code, so be patient. `yarn build` could be used to bundle a package.

Your index.html should load JS wrapper that runs webassembly script:

```html
<!DOCTYPE html>
<html>
<head>
    <script src="js/index.js"></script>
</head>
<body>
</body>
</html>
```

And the said wrapper is in js/index.js:

```js
import module from '../lib/Cargo.toml';
module.run();
```

I have my cdylib library for the web assembly code in the workspace under `lib` that's why the path looks like this. Adjust to your configuration. Remember to build a library crate, not a binary!

NOTE: To build something useful with yew you can start from this excellent tutorial in 3 parts: [Hunt the Wumpus](https://dev.to/deciduously/lets-build-a-rust-frontend-with-yew---part-1-3k2o), [Part 2](https://dev.to/deciduously/lets-build-a-rust-frontend-with-yew---part-2-1ech), [Part 3](https://dev.to/deciduously/lets-build-a-rust-frontend-with-yew---part-3-ch3).

Now just start it:

```sh
yarn start
```

Let's go!
