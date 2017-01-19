---
date: 2013-12-28T15:15:00Z
title: "Progress report: Audio services, congestion control"
categories: [report, libsss, nat, voicebox, security]
---
### Progress report

It's been a while since last update, so I wanted to show a little bit of what's happening in the repositories.

#### NAT

NAT library has learned to read current router mappings and figuring out if it needs to add a mapping for itself. It also learned to not step on other instance's toes so I can successfully run two or more client apps from behind the same firewall.

#### VoiceBox

Voice services are now extracted into a separate library called VoiceBox. Voicebox provides a "processing chain" structure for capturing, compressing, sending, receiving, decompressing and playing back audio frames. It also provides a simple jitterbuffer to fight delivery inconsistencies.

Very simple capture chain looks like this:

    rtaudio_source->packetizer->opus_encode_sink->packet_sink

`rtaudio_source` is a hardware capture abstraction, implemented via RtAudio callback mechanism.
`packetizer` is a simple synchronisation class, providing glue between the two threads - one controlled by rtaudio hardware thread and one driven by the packet sink. It provides a synchronised queue for passing packets.
`opus_encode_sink` encodes audio packets coming in from packetizer using OPUS audio codec.
`packet_sink` sends packets via provided `sss::stream` instance.

This chain is fairly flexible, for example to provide audio data from a file you'd use a very simple setup driven by the packet_sink:

    file_read_sink->packet_sink

`file_read_sink` simply reads from a source file in a loop as long as packet_sink continues to request more packets. It's very simple to provide OPUS-encoded frames from a file, just plug in an encoder:

    file_read_sink->opus_encode_sink->packet_sink

The same way it works for the playback chain:

    packet_source->jitterbuffer->opus_decode_sink->rtaudio_sink

Here the `packet_source` receives packets from an `sss::stream` and puts it into the jitterbuffer.
`jitterbuffer` provides queueing, packet reordering, lost packet compensation and timing control. Just like packetizer in the capture chain it provides synchronisation between network-driven packet_source and audio hardware-driven rtaudio_sink threads.
`opus_decode_sink` decodes OPUS packets into raw audio buffer. It decodes "lost packets" as provided by the OPUS codec implementation when given an empty source buffer.
`rtaudio_sink` outputs the raw audio data via RtAudio driver.

The chain is also flexible, it's possible to transmit raw uncompressed audio or play directly from file into the output device (this is a nice way to implement for example ringtones):

    file_read_sink->rtaudio_sink

It will be possible to read or convert different types of files in the future, once more sources and sinks are implemented, as an example:

    file_read_sink->mp3_decode_sink->repacketizer->opus_encode_sink->file_write_sink

Repacketizer is necessary here because mp3 frame size may not match that of an OPUS encoder. Repacketizer does not need to implement synchronisation because the whole chain consists only of sinks.

As a general rule, synchronisation needs to be inserted in the point where sources transition to sinks. Currently there are only two classes where this happens - `packetizer` and `jitterbuffer`.

#### SSS

For libsss I've started the key negotiation changes to accomodate possible future support for NaCl library and extensible set of encryption and authentication primitives it's going to support.

Also, I have ported over the congestion control code from SST. It's raw and unmodified, so pretty ugly at the moment and in need of cleanup.
SSS is fairly complicated library and I'm working on adding more unit and functional tests before I continue to refactor it into better shape.

There are many corner cases and each must be documented and covered with at least one test before I can go on. The sorry state of not having enough tests is showing its ugly head now, even minor modifications to the code simply break ability to connect two streams.

This is the main development focus now.

#### DHT

On the research side, I've read some nice articles on the DHT system theory and implementation and now looking to make a separate routing layer based on Kademlia DHT routing. It, and the existing regserver support, are ought to be eventually merged into the main SSS library as stream extensions.

Problem here is that regservers are not necessarily known to us by their EIDs until we connect to them, and SSS streams require knowing the EID before connection. Maybe the old SST checksummed less-secure streams will be back just for the sole purpose of supporting these regserver connections in a better manner than currently possible.

Why not use existing regserver connections? Well, it's not secure, surprisingly - lots of the data is transferred in the clear. Especially the user information that is supposed to be protected is actually sent in plaintext UDP packets. The protocol does not support reliable communication, which is not good if we want the nodes to be able to find each other consistently. And last, but not least, the regserver connection uses another port which we also might need to map in the NAT and keep track of. Using SSS streams for regservers connection we will be able to do everything using only a single UDP port on the machine.

### Fin

That's the review of the past two months. There's also a pending article on personal device cluster management, which I'm still unable to finish, so for the time being I will direct you to an amazing thesis article by Bryan A. Ford, the main inspirator behind this project. [Here it is on the UIA site][1] (large PDF, see chapter 2. Naming).

Happy New Year! Be free.

  [1]: http://pdos.csail.mit.edu/papers/ford-phd-thesis.pdf "Bryan's thesis"

मेता
