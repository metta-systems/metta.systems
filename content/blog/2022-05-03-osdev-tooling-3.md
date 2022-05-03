+++
title = "OSdev tooling finished"
[taxonomies]
categories = ["rust","osdev","vesper","tools"]
+++
January through May I was on and off on the project, fixing chainofcommand to work with the chain loading, in particular fighting the UNIX console and the TTY operations. Now the entire thing works, finished and merged into the main `develop`ment branch. After that I started prodding the MMU setup and DTB (DeviceTree) parsing.

<!-- more -->

## Chainloading

The chainloader can not only boot the kernel now, but it also includes basic checks like calculating and comparing the kernel checksum, waiting for the serial port to become available, and a "daemon" mode where you only need to build a new kernel binary and cycle power of the Raspberry Pi to start a new kernel. Very smooth!

![](/images/chainboot.jpg)

The chainofcommand implementation has finally been settled as a Tokio-based async application. Rust async story is still not great as it required mucking around with a number of channels and less than ideal overall architecture.

Here's the structure diagram of all the necessary piping I had to implement:

![](/images/chainofcommand_serial.png)

I wanted to try my hand at some Tokio code, but I believe another approach would look much more pleasant, just compare this to the [Actix-based serial implementation in wterm](https://github.com/dotcypress/wterm/blob/master/src/bridge.rs).

## Other tools

Using cargo-make lets install helper tools as part of the build, so I added `rustfilt` dependency to my `nm` command. Now `just nm` would not simply dump all of the kernel symbols, but sort them by start address and demangle names to proper Rust qualified identifiers.

```
000000000009390c t core::slice::index::slice_start_index_len_fail_rt
000000000009395c t core::slice::index::slice_end_index_len_fail
0000000000093964 t core::slice::index::slice_end_index_len_fail_rt
00000000000939b4 t core::slice::index::slice_index_order_fail
00000000000939bc t core::slice::index::slice_index_order_fail_rt
0000000000093a0c t <core::num::error::TryFromIntError as core::fmt::Debug>::fmt
0000000000093b4c t machine::platform::rpi3::mailbox::MailboxOps::call
0000000000093dbc t <machine::platform::rpi3::mailbox::PreparedMailbox<_> as core::fmt::Debug>::fmt
0000000000093f04 t <machine::platform::rpi3::mailbox::MailboxError as core::fmt::Display>::fmt
```

## Road ahead

Now that I can quickly iterate on a real board by simply finishing the build and power cycling the RasPi, I started to work on a real MMU story. The MMU already initializes and I'm implementing proper memory allocators - I need to allocate correct memory type for operating the Mailboxes. Another point of interest is parsing the DeviceTree to properly allocate board resources without hardcoding their addresses.
