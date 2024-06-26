+++
title = "Optimizations"
# Todo: delete
[taxonomies]
tags = ["metta","llvm","report"]
+++
The reason for not booting was simple - Clang, seeing that target is Pentium 4 and above, optimized some memmoves into SSE operations. Bochs didn't expect that.

Now everything boots up until exceptions, at which point I believe the `__builtin_longjmp` primitive fails. Debugging it.
