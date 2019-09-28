+++
title = "sjlj and exception handling"
# Todo: delete
[taxonomies]
categories = ["metta","osdev","llvm","exceptions"]
+++
Of course, the clang's implementation of `setjmp` is very generic and uses quite an abstraction of program state, which makes it hardly suitable for the ad-hoc local exception support I'm using. Since my requirements for setjmp were quite simple (just give me back my damn registers and stack frame), I went and implemented a very custom-tailored versions `__sjljeh_setjmp` and `__sjljeh_longjmp` which do just what I need.

With [that stuff](https://github.com/berkus/metta/blob/master/src/runtime/setjmp.s) out of the way, my entire boot sequence now works and I can finally fiddle with more interesting stuff. Type system and introspection, here we go.
