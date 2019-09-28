+++
title = "Clanged now"
# Todo: delete
[taxonomies]
categories = ["metta","cross-compiling","llvm"]
+++
Anyway, I've done doing the craziest port of recent times - at the same time GCC to Clang _and_ from waf 1.5 to 1.6.

Quite a bit of quirks to work around.

waf has changed a lot internally, and from occasional backtraces I still see that I'm using compatibility mode somewhere. Oh well, one day when I'm bored…

Clang is also full of quirks. First, I had to build a cross-gcc for it anyway, because otherwise it totally refuses to link or assemble anything. Second, the freestanding standard C headers are not quite finished it seems - stdint.h for example spits out about 20-30 warnings about redefined macros, so I had to disable `-Werror` for now just to get it to compile. Third, the generated code, obviously, doesn't run. I got only first couple functions of kickstart bootloader to work in bochs, after that it just GPFs. Now if it keeps raining tomorrow like today, I'll certainly will go and look what happens there, otherwise it might have to wait until next weekend (actually, in two weeks).

