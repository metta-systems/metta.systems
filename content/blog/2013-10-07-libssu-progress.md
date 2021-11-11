+++
title = "libSSS progress"
[taxonomies]
categories = ["metta","uvvy","structured-secure-streams","report"]
+++
[Structured Secure Streams](https://github.com/berkus/libsss) library is getting in shape. With C++11 and Boost it's relatively simple to write even without the tremendous help of Qt. Although I had to write some helpers which are factored into a separate library - grab [arsenal](https://github.com/berkus/libarsenal) if you want - some nice things there are `byte_array`, `settings_provider`, binary literals, `hash_combine`, `make_unique`, `contains()` predicate, base32 encoder-decoder and [opaque big/little endian integer](https://github.com/berkus/libarsenal/blob/master/include/arsenal/opaque_endian.h) types.

For example:

``` cpp
big_uint32_t magic = 0xabbadead;
// magic will store data in network byte order in memory,
// and convert it as necessary for operations. You don't
// have to think about it at all.

int bin_literal = 1010101_b;
int flags = 00001_b | 10100_b;
int masked = bin_literal & 01110_b;

byte_array data{'h','e','l','l','o'};
auto hell = data.left(4);

// And so on...
```

But enough about support libs, one of the major milestones is the ability to set up an encrypted connection between two endpoints. This works reliably in the simulator, which is another good feature. In the simulator you can define link properties, such as packet propagation delay, loss rate between 0.0 and 1.0, set up host network of arbitrary complexity. It currently requires manual set up of every link between the hosts, but I hope to simplify that a bit using some network configuration helpers.

With an encrypted connecting set up, streams are firing off events on receive or substream activation. There's still a lot to do, for example proper MTU configuration, congestion control, reliable delivery timeouts and lots of small fixes, but I plan now to switch to porting the userspace applications to use SSS streams and then flesh out the issues with a bunch of unit and integration tests.

First target is opus-streaming app from uvvy. It's a simple audio-chat application and switching it to SSS streams serves two purposes - I want to see how well SSS can handle real-time traffic and part two, I haven't polished unreliable datagram sending too much, and this is what opus-stream uses, so it will serve as a field test.
