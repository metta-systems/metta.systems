+++
date = 2099-01-01
draft = true
[taxonomies]
category = ["notes"]
+++
In Kademlia each node and each key has a 160 bit id. A key in Kademlia is the hash value of a data object (for example a file). The value corresponding to a key is a pointer to the host that has stored the data object. Specifically, a value consists of the IP-address and the port number where the host storing the data object can be contacted.
The distance between two ids is defined as their bitwise XOR. That is, if x and y are two ids, then d(x,y) = x ⊕ y. Note the following properties of XOR: d(x,x) = 0, d(x,y) > 0 if x ̸= y, ∀x, y : d(x, y) = d(y, x) (thus, d is symmetric) and the triangle propery: d(x, y) + d(y, z) ≥ d(x, z). The symmetry of the distance is an important advantage of the XOR-metric. It enables Kademlia to learn contact information from ordinary queries it receives. Furthermore, XOR is unidirectional. That is, for a given distance ∆ and an id x, there exists exactly one id y sucht that d(x, y) = ∆. This property ensures that lookups for a certain id converge all along the same path, regardless of the originating node. Kademlia profits from this property through caching of values along the path to the hosting node. Lookups for an id are then likely to hit a cached entry.

(from ftp://ftp.tik.ee.ethz.ch/pub/students/2006-So/SA-2006-19.pdf 2.1)
