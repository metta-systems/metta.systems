+++
title = "Type systems and introspection"
[taxonomies]
tags = ["metta","introspection"]
+++
Since I've decided to approach the system development from both low-level and high-level perspectives, one of the applications I have in mind for demo purposes is a little console tool which lets you activate various parts of the system, list available services and call operations on available interfaces.

Imagine a little tool that allows you to pick a video file, seek it to a particular time and play it frame by frame, then run face recognition on each frame and make a database of recognized faces. Being able to make such applications "mashup style" by just fiddling with text and pictures in the command line should enable people to create more and more interesting tools from the basic building blocks presented by the system.

This tool would need to inspect installed interfaces and types of the running components and be able to construct calls to these components directly from the command line. This requires introspection, or the ability to describe structure of objects in the system.

At the moment I'm working on the extension of meddler that allows to generate introspection data from the interface IDL. It is generally simple and then the next step would be to somehow register this information in the system when a new interface type is introduced. This is harder and requires some design effort. In the first approach of course only boot image is loaded, so registering types is very simple.

Next up is actual introspection interface - how to know what format a particular data type is and how to marshal/unmarshal it for the purpose of interchange and operations calls on interfaces.

See [this little script](@/notes/Metta-mashable-techdemo-storyboard.md) for the possible demo storyboard.
