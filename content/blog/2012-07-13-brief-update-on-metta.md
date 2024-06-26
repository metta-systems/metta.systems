+++
title = "Brief update on Metta"
[taxonomies]
tags = ["metta","llvm","report"]
+++
I've been working on toolchain building script, now at least on Macs it's possible to build a standalone toolchain for building Metta and you can download it and try to build it yourself. All necessary details are descibed on [SourceCheckout wiki page](https://github.com/berkus/metta/blob/master/README.md). There is followup work to remove dependency on binutils and gcc (gcc will probably go first, then once lld is mature enough I could get rid of ld/gold).

Another update is about type system. The operations on type system are implemented now, I can successfully register type information and query it - some examples of that are in the recently released iso image `R925`. Next up is fixing some of naming context operations so I can actually create and operate hierarchical naming contexts.
