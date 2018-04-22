published_date: 2012-05-11 00:00:00 +0300
title: Sending network packets
categories:
    - osdev
    - network
---
A little sidetrack into the world of PCI probing and NE2000 network card emulation.

Wanted to have a taste of sending and receiving network packets inside my little OS, so I went and implemented PCI scanning (extremely simple) and NE2000 card driver (fairly simple too, their doc is quite good although misses some crucial points).

So, after some fiddling I was able to send a packet and receive it through the bochs virtual network card. I've then connected bochs to the host network card and stared at network packets for a while. Cool stuff.

Here's the screen dump of the sent and then received broadcast packet.

``` console
IRQ11 enabled.
Finished initializing NE2000 with MAC b0:c4:20:00:00:00.
Received irq: 0x0000000b
Packet transmitted.
Packet received.
Received packet with status 33 of length 68, next packet at 82

0x004f0064  ff ff ff ff ff ff 28 cf  da 00 99 f5 00 10 48 65  ......(.......He
0x004f0074  6c 6c 6f 20 6e 65 74 20  77 6f 72 6c 64 21 00 00  llo net world!..
0x004f0094  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
```
