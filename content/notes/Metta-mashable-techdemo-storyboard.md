+++
date = 2016-03-07T00:00:00+02:00
title = "Metta - mashable techdemo storyboard"
[taxonomies]
tags = ["metta"]
+++
Fire up console, we'll use two consoles for this demo - one will run the streaming video server, another will be our client. The

    $

prompt denotes a command line where you enter your commands.

<!-- more -->

## Server console

Start monger. Monger is interactive tool for exploring running services and installed interfaces and mashing them together.

Monger has two modes - textual and visual. We'll start by using textual mode and then switch to visual to hack up a video player UI.

In monger

    $ tree

will display a tree of all services registered in the monger's root namespace.

You may hover the mouse over tree element to read the autodoc documentation for each service and also see which interfaces it implements. You can explore the interfaces, try them out and otherwise experiment right away in the console.

We will need two services, one for accessing the video file to stream, and one for actually streaming it.

The file we can access via filesystem (this is quite obvious). The demo disk image comes bundled with a simple streaming video file called "daisy.mpg".


    $ file = Root.FileSystem.Open (Root.FileSystem.Find FILENAME="daisy.mpg"), StreamableVideoFile

This passage calls two operations on the filesystem interface - `Find`, which specifies attributes to find a file, and `Open`, which takes a found file and returns a typed interface to access it, in this case `StreamableVideoFile`.

StreamableVideoFile wraps in its interface most operations necessary for handling a video file streamed over the network. To actually serve this file we will need to instantiate a streaming service.

    $ friendly stream

This command lists all "user-friendly" interfaces which are somehow related to streaming. As usual, you may hover the mouse over returned items to read docs, go to more detailed specifications and click on the names to insert their full path references into the command line. We need the VideoStreamingService interface.

    $ instantiate VideoStreamingService

This commands will provide you with the various ways to obtain a running instance of video streaming service. If there's more than one way possible, you can usually pick any - it should work either way.

    $ server = Root.Modules.StreamingMod.CreateVideoStreamer
    $ server.StartStreaming file

These two lines create the streaming service and prepare it to serve the file once first client connects. Now leave this console for monitoring the log and fire up a new one, we'll use it to create a client application.

## Client console

To display the video we receive from the server we will need some sort of window. It would be nice to be able to drag, resize, and finally close this window. It would be very nice if we could play, pause, rewind and arbitrarily seek the video, too. Too much work? Not at all!

First, lets create client side of the video server connection.

    $ client = Root.Modules.StreamingMod.CreateVideoConsumer

For now there's nothing we want to change in the client.

We'll use visual mode of monger to design the UI. Enter visual mode.

    $ vi

Now in the interface tab, use quickfilter to find a video window (type **video window** into the quickfilter), drag it into the screen area.

In the property sheet edit videoSource property and pick the variable **client** we just created in previous step.

To make it movable and resizable, you'll need some window decorations (quickfilter **decoration**) - drag it onto the video window and voila, it becomes a real window.

Pick video controller (quickfilter **video controller**) and drop it onto the video window. Now you have the necessary controls.

Drop back into the textual mode. Click "Textual mode" in the interface.

Now for simplicity we won't be discovering the streaming server, instead, we will publish its reference from the server console.

Go to server console.

## Server console

    $ publish server Root.Example.VideoServer

Go back to client console and connect!

## Client console

    $ client.Connect Root.Example.VideoServer

Hurray, if you did everything correctly video starts playing right away! You can seek, pause, play and loop the video. For a nice view of how we (do not) handle errors go back to server console and stop streaming

    $ server.StopStreaming

## See also

[Scripting in Haiku](https://www.haiku-os.org/blog/humdinger/2017-11-05_scripting_the_gui_with_hey/)
