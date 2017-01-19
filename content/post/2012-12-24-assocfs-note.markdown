---
date: 2012-12-24
title: assocfs note
categories: [metta, assocfs, content addressable storage, git model, non-hierarchical filesystem]
---
While I'm still dabbling with fixing some SSS issues here and there I thought I'd post an old excerpt from assocfs design document.

This is something that I'm doing with my assocfs.

It's a non-hierarchical filesystem - in other words, associative filesystem. It's basically a huge graph database. Every object is addressed by its hash (content addressable, like git), knowing the hash you can find it on disk. For more conventional searches (for those who does not know or does not care about the hash) there is metadata - attributes, drawn from an ontology and associated with a particular hashed blob.

This gives a few interesting properties:

 * Same blobs will end up in the same space, giving you a for-free deduplication.
 * Implementing versioning support is a breeze - changing the blob changes the hash, so it will end up in some other location.
 * Some other things you may easily imagine.

It also has some problems:

 * No root directory, but a huge attribute list instead. This requires some efficient search and filtering algorithms as well as on-disk and in-memory compression of these indexes. Imagine 1,000,000 "files" each with about 50 attributes. Millions and millions of attributes which you have to search through.

Luckily, databases are a very well established field and building an efficient storage and retrieval on this basis is possible.

As a user you basically perform searches on attribute sets using something like humane representation of relational algebra. Blobs can have more conventional names, specified with extra attributes, for example: `UNIX_PATH=/bin/bash` `UNIX_PATH=/usr/bin/bash` allows single piece of code to be addressed by UNIX programs as both `/bin/bash` and `/usr/bin/bash`, without needing any symlinks.

You can assign absolutely any kind of attributes to blobs, the actual rules for assigning are specified in the ontology dictionary, which is part of the filesystem and grows together with it (e.g. installed programs may add attribute types to blobs). Security labels are also assigned to blobs that way.

Attributes "orient" blobs in filesystem space - without attributes the blobs are practically invisible, unless you happen to know their hash exactly. They also form a kind of semantic net between blobs giving a lot of information about their semantical meaning to the user and other subsystems.

Since recalculating hashes for entire huge files would be troublesome, the files are split up in smaller chunks, which are hashed independently and collected into a "record" object, similar to a git tree. Changing one chunk therefore requires rehashing only two much smaller objects, rather than entire huge file.

Changes to the filesystem may be recorded into a "change" object, similar to a git commit, which may be cryptographically signed and used for securely syncing filesystem changes between nodes.

