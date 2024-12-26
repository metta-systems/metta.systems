+++
title = "NAT update"
[taxonomies]
tags = ["uvvy","network","report"]
+++
Turns out the problem was on the server side setup. After moving the server to Amazon EC2 cloud and setting up UDP firewall rules punching started working. At least that takes some burden off my shoulders. The regserver connection is not very robust, that should probably be modified to force-reconnect the session once you open the search window again.

Using UPnP has interesting effect on Thomson TG784 router - all UDP DNS traffic ceases on other machines, rendering name resolution unusable, unless I force it to use TCP. Not yet sure if this is result of my incorrect use of it or this is by design in Thomson. Skype and uTorrent seem to punch holes just fine, so it should be me. For now I just turned UPnP off in the released code and will experiment with it more.

**update:** As of Jan 2014 NAT access is working properly.
