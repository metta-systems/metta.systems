+++
date = 2012-07-16T00:00:00+03:00
title = "Graphic dependency resolution"
[taxonomies]
categories = ["metta","tools","issue-tracking"]
+++
I needed to quickly check how much of Nemesis support has to be ported over before I can start launching some basic domains.

I used a simple shell one-liner to extract NEEDS dependencies from the interface files. It's easy to do in Nemesis because of explicit NEEDS clause in each interface (would be nice to add this functionality to meddler, it also has the dependency information available).

Here's the shell one-liner:

``` shell
echo "digraph {"; find . -name *.if -exec grep -H NEEDS {} \; | grep -v "\-\-" | 
  sed s/ *NEEDS //g | sed s@^\./@@ | sed s/\.if// | awk -F: {print $1, "->", $2}; echo "}"
```

This generated a huge [graphic](/images/needs_full.png) with all dependencies, which I then filtered a bit by removing unreferenced entities and culling iteration after iteration.

The resulting graphic is much smaller and additionally has a hand-crafted legend (green - leaf nodes, yellow - direct dependencies of DomainMgr and VP, my two interfaces of interest). This shows I need to work on about 10-12 interface implementations to be able to run domains.

![](/images/needs_boot.png)

And my ticket tracker of choice, bugs-everywhere now has an entry 7df/0fe 'Generate dot files with dependency information in meddler'. Time to sleep.
