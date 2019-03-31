+++
date = 2009-12-30
title = "About"
template = "notes.html"
[taxonomies]
categories = ["exocortex","metta"]
+++
### What I'm working on and why

My biggest project so far is Metta - a humane, social and multimedia OS. While multimedia and social are pretty much all over the place, humane part is still unexplored widely.

Bits and pieces are appearing in different systems from different vendors, but they still haven't integrated enough.

 - A user interface that helps and optimizes workflows, rather than gets in the way.
 - A scalable system that works across all your devices - laptops, smartphones, TVs - without the need to explicitly manage every single file, address book record or configuration setting.
 - An environment that doesn't only passively executes your direct commands, but a living federation of agents working on your behalf to bring you the best and most interesting things you wouldn't even find yourself - something much more useful than idly browsing through 9gag.
 - Something that could become your actual exocortex device, after some sufficient advances in neural interfacing development.

This is a huge undertaking and given that neither Apple nor Microsoft is near achieving it yet, chances are I won't make it alone either. But I have to try anyway.

### Ongoing Projects

One side - the low-level platform, which supports secure, distributed, federated, peer-to-peer systems - is being developed at [metta](https://github.com/metta-systems/metta). It supports an entirely different programming paradigm of component-based composable system, where interfaces between components make it possible to remote parts of the system without ever changing the application itself; and introspection facilities allow to build mashable applications out of existing components without ever needing anything else. A fast, portable, peer-to-peer foundation platform.

Another side - the user-space interaction and social facilities - developed at [uvvy](https://github.com/metta-systems/uvvy). Uvvy is a tool for fully decentralized communications - grab data you like and store it forever, share data with your friends, start chats, voice or video calls, form groups by interest, transparently keep all your notes between all of your devices; all based on a simple ideas of
[UIA](http://pdos.csail.mit.edu/uia/). It is still in its infancy and only base transport protocol is done, work is now going on on overlay routing network. This project is no less ambitious, but better progress is being made here, since it is a simple application ran on regular off-the-shelf operating systems.

### Grabbing the data

The grabber comes from Latin saying "Omnia mea mecum porto" - grab, snapshot things I need and forever keep them available to me. This is one of the current research topics in the humane part. How much data do I need? Where do I need it? How my life changes if I always can find what I need, wherever I am?

Final target is to have a bunch of clients for desktop and mobile platforms (Win, Mac, Linux, Android, iOS) as well as own operating system implementation (Metta) running together.

### Components

There are building blocks in form of underlying substrate libraries ([libsupport](https://github.com/berkus/libsupport) for miscellaneous utilities, [libkrypto](https://github.com/berkus/libkrypto) for cryptographics primitives, [libssu](https://github.com/berkus/libssu) for encrypted multiplexed re-routable streams,
[librouting](https://github.com/berkus/librouting) for routing those streams regardless of peers locations and availability). They could also be used separately to support _your_ applications.

### Support or contact

Ping [@berkus](https://github.com/berkus) if you have any questions or ideas.

Be free!

मेता
