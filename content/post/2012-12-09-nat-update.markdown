---
date: 2012-12-09T00:00:00Z
title: NAT update
categories: [metta, upnp, nat traversal, nat, hole punching]
---
Turns out the problem was on the server side setup. After moving the server to Amazon EC2 cloud and setting up UDP firewall rules punching started working. At least that takes some burden off my shoulders. The regserver connection is not very robust, that should probably be modified to force-reconnect the session once you open the search window again.

UPnP has interesting effect on Thomson TG784 - all UDP DNS traffic ceases on other machines, rendering name resolution unusable, unless I force it to use TCP. Not yet sure if this is result of my incorrect use of it or this is by design in Thomson. Skype and uTorrent seem to punch holes just fine, so it should be me. For now I just turned UPnP off in the released code and will experiment with it more.

**update:** As of Jan 2014 NAT access is working properly.
