+++
title = "Events interface"
[taxonomies]
categories = ["metta","ansa","distributed-architecture","events","synchronisation","fawn","nemesis","report"]
+++
I've ported events, sequencers and event-based communication primitives from Nemesis. It's a little bit messy at the moment (mostly because of mixing C and C++ concepts in one place), but I'm going to spend the autumn time on cleaning it up and finishing the dreaded `needs_boot.dot` dependencies to finally bootstrap some domains and perform communication between them. Obviously, the shortest term plan is timer interrupt, primitive kernel scheduler which activates domains and events to move domains between blocked and runnable queues.

There's some interesting theory behind using events as the main synchronization mechanism, described [here](http://research.microsoft.com/pubs/72910/UCAM-CL-TR-361.pdf) in more detail.

For the vacation time I've printed some ANSA documents, which define architectural specifications for distributed computation systems and is very invaluable source of information for designing such systems. The full list of available ANSA documents can be found [here](http://www.ansa.co.uk/ANSATech/ANSAhtml/). Good reading.
