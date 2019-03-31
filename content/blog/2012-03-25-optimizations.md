+++
date = 2012-03-25T00:00:00+03:00
title = "Optimizations"
[taxonomies]
categories = ["metta","llvm","cpu-arch"]
+++
The reason for not booting was simple - Clang, seeing that target is Pentium 4 and above, optimized some memmoves into SSE operations. Bochs didn't expect that.

Now everything boots up until exceptions, at which point I believe the `__builtin_longjmp` primitive fails. Debugging it.
