title: Porting to Cobalt
published_date: "2018-04-25 15:41:50 +0000"
categories:
    - blog
    - rust
is_draft: false
---
Decision to port the blog to rust-based Cobalt.rs generator instead of hugo came rather easily, I'm quite fond of rust ecosystem now, and this porting excercise proved me right.

My first try was to run cobalt conversion directly from the insides of my hugo blog directory. This rained endless stream of errors and demotivated me, so I postponed the conversion, fearing it will be too hard.

In my second attempt I decided to do it more controllably, initialized a new directory using `cobalt init` and started porting my theme.

Hugo setup used a variation of [Hyde-X](https://github.com/zyro/hyde-x), turns out there is no theme support in Cobalt yet, but since I do not plan on switching the theme I decided to port it directly. I moved the css, fonts, and images files from the theme, copied header, footer and sidebar templates to `_includes` and adjusted them for Liquid template engine used by Cobalt. This was fairly straightforward.

I then started dropping in some of my blog posts and trying to render them properly. I ran into a few problems.

1. Hugo templates are much more advanced than the simple Liquid templating. They are also much better documented. I did not find how to check for variable existence in Liquid, for instance, my simple attempts just failed with "key not found" errors.
2. Things like `ReadingTime` were missing. I went and implemented it in Cobalt binary but then a kind soul on [gitter](https://gitter.im/cobalt-org/cobalt.rs) showed me the [non-intrusive way](https://github.com/booyaa/booyaa.github.io/blob/source/_includes/post.liquid#L11), which I turned into a [simple include](https://github.com/metta-systems/metta.systems/blob/master/_includes/reading_time.liquid) and can use it with a [couple lines of extra code](https://github.com/metta-systems/metta.systems/blob/master/_layouts/post.liquid#L2-L3) in templates. This is where Hugo's Shortcodes might've been handy.
3. The frontmatter was for some reason delimited using only one `---` at the end, not a pair of such delimiters - this is hardly a big problem, but caused some frustration and I lost frontmatter syntax highlighting in Sublime. I suspect there isn't really a technical reason to do it like this - cobalt's jekyll importer can parse standard frontmatter just fine.

The old Hugo theme also had a bunch of additional parameters in its config. I moved these all into the [data file](http://cobalt-org.github.io/docs/data.html) called params.toml - it's basically the same format as in hugo, it was really nice to be able to just create a data file and have access to it from templates.

I had to turn off cobalt's syntax highlighting in favor of hljs, since cobalt did not have the `zenburn` theme I needed. While porting I did a few more minor styling fixes.

Overall the process was nice. Of course, proper support for overridable themes and much more detailed documentation is necessary to let users create more sophisticated websites.

One major piece left out is the category pages generation, I will need to address it some time later.

The whole history of changes can be seen [here](https://github.com/metta-systems/metta.systems/compare/bcb2c1afec40b85c11f9a6979072117f8c0b6c6d...776a3c23b38123acec348475af3c9b4ff88f6ee2).

मेता
