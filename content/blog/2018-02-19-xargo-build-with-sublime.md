+++
date = 2018-02-19T21:29:58+02:00
title = "Xargo Build with Sublime"
[taxonomies]
categories = ["rust","cargo-xargo","sublime-text","osdev"]
+++
### How to build your xargo package in Sublime

Imagine you have a special OSdev project in Rust that you want to build from within Sublime Text. So you fire up the editor, choose the `Tools`>`Build System`>`New Build System…` and write a little simple configuration file:

``` json
{
    "shell_cmd": "xargo run --target aarch64-vesper-metta",
    "keyfiles": ["Xargo.toml"],
    "working_dir": "$project_path/vesper",
    "env": {
        "RUST_TARGET_PATH": "$project_path/vesper/targets/"
    },
    "quiet": false
}
```

You save it and hit Cmd+B.

<!-- more -->

You get rather strange message:

``` text
error: Error loading target specification: Could not find specification for target "aarch64-vesper-metta"
```

— Wait, but I've specified the env variable!, you yell at the editor.

Only to find out that sublime variables are not expanded in the `env` block.



Well. Fire up `Package Control` and `Install Package` named `EnvironmentSettings`. Now do some initial setup: in Package Settings set up User settings for the installed package and initialize it to this:

```json
{
    "print_output": true,
    "set_sublime_variables": true,
    "sublime_variables_prefix": "",
    "sublime_variables_capitalized": false
}
```

Now after you restart sublime or select `Apply Project Configuration` in Package Settings for EnvironmentSettings plugin you will be able to use your buildsystem correctly! Just press Cmd+B and enjoy.

The `env` block from the build system configuration is now using `$project_path` as a real environment variable set by EnvironmentSettings plugin.
