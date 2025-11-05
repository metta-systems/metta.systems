+++
title = "Replace app icon automatically"
[taxonomies]
tags = ["howto","tools"]
+++
Want to have your own custom app icon in the dock, but it always gets replaced by an app update?

Inspired by the talks to replace Warp.app icon (in [multiple](https://github.com/warpdotdev/Warp/issues/2703) [issues](https://github.com/warpdotdev/Warp/issues/5418) [on GH](https://github.com/warpdotdev/Warp/issues/5408)), I've made a simple tool to automatically replace the icon after the app update.

Update: In the new versions of macOS/Warp it is done more [easily](https://github.com/warpdotdev/Warp/issues/5408#issuecomment-2963756207). I've updated the script to reflect this new approach.

<!-- more -->

Using [this helpful article by Mayeu](https://mayeu.me/post/how-to-trigger-any-action-when-a-file-or-folder-changes-on-macos-on-the-cheap/) one can make a very simple agent watching for changes in the app icon file and replace it back.

The agent article above gives all the necessary background, here I'll just provide the actual script and agent configuration.

To allow watching multiple apps separately, split the functionality into the setter script and one or more watcher scripts.

Create a script [`~/Tools/app-icon-replace.sh`](https://github.com/berkus/my-system-config/blob/main/Tools/app-icon-replace.sh):

```sh
#!/bin/sh
APP=$1
ICON=$2
FILE_ORIG=/Applications/${APP}.app/Contents/PlugIns/WarpDockTilePlugin.docktileplugin/Contents/Resources/${APP}.png
FILE_REPL=~/Tools/icons/${ICON}.png

ORIG=$(shasum $FILE_ORIG | cut -d ' ' -f 1)
REPL=$(shasum $FILE_REPL | cut -d ' ' -f 1)

if [[ "$ORIG" != "$REPL" ]]; then
    sleep 5
    cp -f $FILE_REPL $FILE_ORIG
    killall Dock

    echo "$(date): ${APP} icon changed, updated" >> ~/Tools/${APP}-watcher.log
fi
```

Create a script [`~/Tools/warp-watcher.sh`](https://github.com/berkus/my-system-config/blob/main/Tools/warp-watcher.sh):

```sh
#!/bin/sh
sh ~/Tools/app-icon-replace.sh Warp classic_1984_mac
```

Don't forget to `chmod +x ~/Tools/warp-watcher.sh`!

We perform a check for an actual file change in this script, because otherwise fsevents will be signaling
file change every time we copy the file over, resulting in an infinite loop, even if the file didn't actually change.

And make a plist file configuring the agent in [`~/Library/LaunchAgents/org.myuser.warp-watcher.plist`](https://github.com/berkus/my-system-config/blob/main/Library/LaunchAgents/systems.metta.warp-watcher.plist):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>Label</key>
        <string>org.myuser.warp-watcher</string>
        <key>ProgramArguments</key>
        <array>
                <string>/Users/you/Tools/warp-watcher.sh</string>
        </array>
        <key>WatchPaths</key>
        <array>
                <string>/Applications/Warp.app/Contents/Resources/Warp.icns</string>
        </array>
</dict>
</plist>
```

We set up watcher to monitor for changes in the Warp's icon file - when it changes,
the script will replace the icon back. This usually happens when the app updates
itself, so before it launches again, the script will have a chance to fix the icon.

You can adopt it for any other application, just replace the paths in the script and plist file.

Launch the agent using `launchctl load ~/Library/LaunchAgents/org.myuser.warp-watcher.plist` and you're done.

PS. You can find some really nice terminal icons [here](https://github.com/dhanishgajjar/terminal-icons).
