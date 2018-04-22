published_date: 2013-03-21 00:00:00 +0300
title: File sharing design considerations
categories:
    - uvvy
    - file sharing
    - content distribution
---
Some issues that need tackling in design of file sharing (see [Brendan's post here](http://forum.osdev.org/viewtopic.php?p=220878#p220878)):

The issue of trust: right now, the file is only distributed across a range of devices you manually allow to access your data. This doesn't solve the problem per se, but just makes it easier to tackle for the initial implementation. The data and metadata could be encrypted with asymmetric schemes (private keys), but that doesn't give full security.

The issue of overhead: using automatic deduplication on a block level (if people share the same file using the same block size, chances are all the blocks will match up, and hence need to be stored only once. If there are minor modifications, then only some blocks would mismatch while other are perfectly in sync, and this means much less storage overhead).

Redundancy: This also gives possibility to spread out the file blocks to other nodes more evenly, with an encoding scheme allowing error correction file may be reconstructed even if some of its blocks are lost completely.

Plausible deniability: if your file is not stored in a single place as a single blob, it becomes much harder to prove you have it.

File metadata (name, attributes, custom labels) is also stored in a block, usually much smaller in size, which can be unencrypted to allow indexing, but could also be encrypted if you do not want to expose this metadata. In my design metadata is a key-value store with a lot of different attributes ranging from `UNIX_PATH=/bin/sh` to `DESCRIPTION[en]="Bourne Shell executable"` to `UNIX_PERMISSIONS=u=rwx,g=rx,o=rx` and so on. This format is not fixed, although it follows a certain schema/onthology. It allows "intelligent agents" or bots to crawl this data and enrich it with suggestions, links, e.g. a bot crawling an mp3 collection and suggesting proper tags - it could also find higher quality versions of the file, for example.

All this revolves around the ideas of DHTs, darknets, netsukuku and zeroconf. Still early on in the implementation to uncover all the details - they might change.

