+++
title = "Bootstrapping node problem"
[taxonomies]
categories = ["routing","peer-to-peer"]
+++
### The problem

Absolutely every network needs a way to find a node's peers, for establishing connections, propagating updates and maintaining network integrity this is essential.

Overlay networks based on DHT or similar mechanisms ([Kademlia][1], [Chord][2]) use peer nodes to figure this information out. Usually in such network you have a node ID, 128 or 160 bits in length, which uniquely identifies the node and node's position in routing tables. Based on this ID you simply look up the IP address. But wait, look it up from where?

<!-- more -->

Turns out to be able to find any peer's IP address you already need to be connected to the overlay network. Or have some other way of figuring out at least one, first, bootstrapping IP address of a node inside that network.

![Dr. Martens boots](/images/Dr_Martens.jpg)

Finding the first node to connect to is hard. There are services which try to use your IP as your fingerprint, for example [cjdns][3]. But they work only for ipv6 - which incidentally has a pretty big number of bits in the address, making it close to a unique 128-bit ID. And it works as long as your IP does not change. This might become true in some distant future, when the legacy of ipv4 no longer haunts us. But in today's internets you're most likely to change IP many times a day especially if you're using a mobile device or working behind a NAT.

Lets review the possible ways to find a bootstrap node.

### Hardcoded bootstrap IP

The most primitive technology, employed by many p2p applications is to hardcode several well-known addresses of bootstrap nodes into each application/appliance.

It was employed by the early Skype software, for example. By integrating a "supernode list" of IP addresses into the executable file it achieved a "magical" effect of Skype always working even if the internet connectivity was apparently lacking. Usually it was due to a misconfigured DNS resolver which direct IP connections by Skype didn't use.

While simple, this approach is very inflexible at least because data embedded in the executable would require an issue of a new version should any of the IP addresses change, be blocked or go down permanently. Skype battled this by using redundancy, having hundreds of listed supernodes and firing connections to multiple of the IPs at once and hoping at least some of them would respond. Hardcoding can be avoided by having the IP list in some sort of configuration file, distributed separately and possibly updated by the user.

Uvvy would support this way of obtaining boostrap node addresses at least while the number of nodes in the network is too small to guarantee reliable search of nodes using other methods.

### DNS records

Resolving addresses of bootstrap nodes using DNS is not very different from direct IP addresses, but is more flexible. You can give some names, possibly auto-generated, and look them up using DNS. By defining, changing, or intercepting DNS requests at network level you can flexibly control node IP resolution without altering the software or users being aware of the changes.

In Uvvy this method is equally supported by simply using domain names instead of IP addresses. Lookup for A and AAAA records is performed to obtain both ipv4 and ipv6 addresses.

### Bonjour records

A node inside a local network may use Bonjour/Zeroconf queries for a special resource type to find compatible nodes and connect to them.

This approach allows entirely LAN operation of the p2p overlay network as a bonus. The nodes need not contact any outside servers, routers or resolvers.

### Collaborative routers (UPNP, HTTP, DNS)

Routers that support the p2p network may disseminate information they have collected during their operation about any other network nodes upon request of newly joining nodes.

The routers could expose this functionality through different interfaces. Simplest is probably to set up specific DNS records for some bootstrap node names known to the client.

Router may also be set up to answer specific HTTP requests about known nodes. This is a firmware detail and depends on how firmware authors decide to support this feature.

Also UPNP protocol may be extended to query this information from a compatible router or any other participating UPNP device in the household.

Finally, the router may itself be a bootstrap node. While this requires some firmware changes, it also makes router a good stationary node with ability to set up rendezvous for many other nodes. The only step necessary to figure out the router bootstrap is to find the network gateway.

### Broadcasting for a reply

Broadcasts are kind of a last way out. Broadcasts negatively affect network performance, are often blocked by the routers and do not cross networks easily.

A node may attempt to broadcast some kind of request for peer nodes to the available interfaces and hope for the best, but there are no guarantees how soon a reply would appear, if any.

Netsukuku's [QSPN][4] protocol uses Tracer Packet flood to discover other nodes in the network and update the routing information. Netsukuku aims at stable, long-running nodes in the network and is not very suitable for mobile users, but it can be well applied to the Collaborative routers above, by allowing a network of routers to carry out router-to-router tracer packet floods and use them to update the overlay network topology for mobile clients.

While Netsukuku documentation doesn't mention TP broadcasted over the network, they can very well be, otherwise we enter the bootstrapping node problem again. Nodes already in the network can use combination of broadcasting with direct sending to already known nodes. Since nodes do not retransmit tracer packets which do not contain any new paths (so-called "uninteresting" packets) the flood will eventually cease.

To prevent DDoSing the packets are cryptographically signed and verified by the peers upon reception.

### Ant colony

[Ant colony optimization](http://en.wikipedia.org/wiki/Ant_colony_optimization) algorithm for path finding in the p2p network. Similar to broadcasting, but used to gather more efficient routes in an anonymous or pseudonymous network, where locations of recipients are not at all discoverable.

### Conclusion

A number of techniques reviewed here should be sufficient to let client software find bootstrap nodes without painful configuration. In case all automatic ways fail there's still a fallback through user-defined connection points.

I would rather like to hear your ideas for other methods not covered here. Post in the comments, write on twitter, github, friendfeed or email. There must be some novel methods I haven't heard of.

  [1]: http://en.wikipedia.org/wiki/Kademlia "Kademlia"
  [2]: http://en.wikipedia.org/wiki/Chord_(peer-to-peer) "Chord"
  [3]: https://github.com/cjdelisle/cjdns "cjdns"
  [4]: http://netsukuku.freaknet.org/doc/main_doc/qspn.pdf "QSPN"

मेता
