+++
date = 2025-10-05
title = "Resumé"
description = "Resumé page"
render = true
in_search_index = false
template = "resume-with-toc.html"
+++
# Brief

* Name: **Berkus Karchebnyi**
* Current position: **Principal Software Engineer, Microsoft M365 Core**
* Seeking position: **(Principal) Rust Software Engineer, Rust Technology Lead**
* Email: [berkus+jobs@madfire.net](mailto:berkus+jobs@madfire.net)

# Skills

* Strong **collaborative leadership** (good at organizing people and keeping them involved).
* Strong **technical documentation and communication** ("write it down", ELI5).
* Excellent knowledge of **Rust** ([own projects](https://github.com/berkus)), over 8 years programming experience, including no_std environments.
* Also a member of [Rust Embedded WG](https://github.com/rust-embedded).
* Excellent knowledge of **C++** (templates, exceptions, standard library, bughunting), over 20 years programming experience.
* Experienced in various **infrastructure** tools (source control systems - **Git**, **Pijul**, **jj**; scripting in **Ruby**, **Python**, **shells**; build pipelines - **GitHub**, **CircleCI**, **Jenkins**).
* Experienced software localiser to other languages (Russian/English).
* Some experience in SwiftUI.
* Some experience in Android development, mostly Java- and JNI-based.

# Previous jobs

## Microsoft [microsoft.com](https://www.microsoft.com/)

**Principal Software Engineer**
*June 2024 &mdash; Present time.*

Developing a suite of SDKs to accelerate migration of core C# services to Rust. My focus areas include open-telemetry and C# interop areas. Working on the [interoptopus](https://github.com/ralfbiedert/interoptopus) project in OSS to improve C#-Rust interop.

## Twilio [twilio.com](https://www.twilio.com/)

**Principal Software Engineer, Engineering Team Lead**
*April 2016 &mdash; May 2024.*

Initially maintained an Android Chat SDK, improving JNI layer and fixing bugs. Grew to lead the Conversations SDK team, which included Android, iOS and JavaScript developers producing corresponding platform SDKs.

Led C++ libraries upgrade for SDKs, and led migration from C++ to native implementations (Swift and Kotlin). One of the Kotlin native SDKs has been published to OSS - [twilio-sync-sdk](https://github.com/twilio/twilio-sync-sdk).

Led the effort to document the largely undocumented body of SDK code and converted it into "specs first" approach, which then let the SDK team parallelise writing three platform implementations.

## Exquance [exquance.com](https://www.exquance.com/)

**Co-founder, CTO, developer.**
*June 2012 &mdash; April 2016.*

Managed teams of outsource developers, set up CI/CD infrastructure, developed iOS (UIKit) and Windows (WPF, Visual Basic) applications.

Implemented a mandatory CI pipeline for all components of the software, speeding up the development cycle and removing the "works on my machine" development approach.

## Skype [skype.com](https://www.skype.com/)

**Software Engineer.**
*November 2004 &mdash; April 2013.*

Worked on Linux version of Skype UI using Qt library. Then worked on Linux audio support for Skype on consumer electronics devices (TVs, MIDs, etc).

Implemented from the grounds up full audio stack support in Linux Skype UI, including ALSA, PulseAudio, and OSS4. Integrated with pre-existing audio library infrastructure. Implemented Android audio support using OpenCORE.

## Infinet Wireless, Inc. [infinet.ru](https://www.infinet.ru/)

**Software Engineer.**
*June 2004 &mdash; July 2004.*

<details>
    <summary>Read more</summary>
Implemented wireless router monitoring interface using native Infinet libraries and Qt.<br/>
<br/>
Implemented Qt3 version of monitoring software. Integrated with existing framework libraries.
</details>
<br/>

## IA Neftegaz.RU [neftegaz.ru](https://www.neftegaz.ru/)

**Web Developer.**
*July 2003 &mdash; May 2004.*

<details>
    <summary>Read more</summary>
Maintained a large Oil &amp; Gas industry portal web site acting as both a web-programmer (writing PHP and Ruby code) and as a server administrator. I wrote a speed-optimized website statistics analyzer in Ruby. I also did a big upgrade by installing a new Linux system with fresh software and greatly optimized it for speed.<br/>
<br/>
By carefully analyzing logfiles my system was able to achieve better performance and nicer site visitors log detail level than the previous implementation.<br/>
</details>
<br/>

## Visual Mechanics [vismech.ru](https://www.rusprofile.ru/id/4230162)

**Web Developer.**
*September 2001 &mdash; July 2003.*

<details>
    <summary>Read more</summary>
Coded PHP for a lot of websites including several web shops. I also took part in a big web-based document flow software project.<br/>
<br/>
Implemented web shop framework in PHP, which was used for several further projects. Created a <a href="https://github.com/berkus/negine">visual table constructor</a> tool for a website backoffice.<br/>
</details>
<br/>

## AG Courier [zauralmedia.ru](https://spravkaru.info/kurgan/company/kurer)

**Systems administrator, Developer.**
*June 2000 &mdash; July 2001.*

<details>
    <summary>Read more</summary>
Maintained a small network of <a href="https://en.wikipedia.org/wiki/Non-linear_editing#DV">non-linear video editing</a> PC stations. I also wrote software for internal use.<br/>
<br/>
<ul>
<li>Designed and implemented a small CRM tool in PHP.</li>
<li>Reverse-engineered binary storage format used by the broadcasting hardware.</li>
<li>Designed and implemented a news ticker (crawl) text input editor application for TV broadcasting in C++. The editor allows a human operator to enter multiple entries, enable and disable them based on a given schedule, and generate dumps for a set of calendar dates in a format supported by the video broadcasting hardware. It was used to organize and simplify maintenance of crawling texts by keeping an archive, automatically expiring entries, allowing quick search and replace within an archive. Usability (UX in particular) was of utmost concern during design phase - operator has to enter as many as 500 entries in one run, hence things like keyboard shortcuts, dictionary-based autocompletion, quick search and replace were implemented. The system was implemented using Borland C++ Builder.</li>
</ul>
</details>
<br/>

# Open Source Software projects

## Metta OS [metta.systems](https://metta.systems/)

**Author, overall design, Rust and asm programming.**

Metta is a novel operating system for creative nomads with hi-tech devices and ubiquitous Internet access. I'm exploring the future of Human-Machine interaction using augmented reality, associative data storage, data ownership, publishing and filtering facilities.

## Vesper <i class="lni lni-github"></i>[metta-systems/vesper](https://github.com/metta-systems/vesper)

**Author, overall design, Rust and asm programming.**

Vesper is a single-address-space nanokernel for Metta. I am exploring a way to make minimalistic kernel where policy decisions will be mostly outside the privileged core while still performing decently. This is also an exercise in low-level no_std Rust.

## aarch64-cpu <i class="lni lni-github"></i>[rust-embedded/aarch64-cpu](https://github.com/rust-embedded/aarch64-cpu)

Co-maintaining ARM cpu crate as part of Rust Embedded WG. The crate provides essential low-level ARM abstractions for embedded systems and is widely used in the Rust Embedded ecosystem (55 official dependent crates on crates.io).

## Interoptopus <i class="lni lni-github"></i>[ralfbiedert/interoptopus](https://github.com/ralfbiedert/interoptopus)

Contributing support for C#-Rust ffi interop, implemented `Wire<T>` serialization format to support passing more complex types through the ffi boundary.

## Criterion <i class="lni lni-github"></i>[criterion-rs/criterion.rs](https://github.com/criterion-rs/criterion.rs/)

Revitalizing criterion through community efforts after it has been in neglect for a long while. Started a new org with the intent of allowing wider community contributions.

## GG <i class="lni lni-github"></i>[metta-systems/gg](https://github.com/metta-systems/gg)

Contributing to GG (a GUI for Jujutsu VCS) by consolidating and staging multiple community PRs in repository while @gulbanana is busy or away. This is mostly a testing playground, with the hope that PRs get merged back into the main repository over time.

## Pijul <i class="lni lni-pijul"></i>[nest:pijul/pijul](https://nest.pijul.com/pijul/pijul)

Contributing to a powerful distributed VCS based on theory of patches. I work on improving the user experience, command-line interface and adding a GUI.

## Amarok [amarok.kde.org](https://amarok.kde.org/)

**C++ programming, co-author.**

Amarok is the KDE audio player. I have joined the team at version 0.6. I took part in localization effort, visual and user interaction design, system architecture design. I am no longer an active part of the development team.

## Akregator <i class="lni lni-github"></i>[KDE/akregator](https://github.com/KDE/akregator/)

**Author, overall design, C++ programming.**

A KDE RSS aggregator. I wrote Akregator in the time KDE had no RSS aggregator software. Akregator is highly appreciated by many users. It has earned [Application of the Month](https://web.archive.org/web/20070608163325/https://dot.kde.org/1105456661/) status in January 2005 ([interview](https://web.archive.org/web/20050306090912/http://www.kde.org.uk/apps/akregator/interview.html)). It is now included in main KDE packages. I am no longer an active part of the development team, the version of Akregator you see on github is a new rewrite without my contributions (over 20 years have passed).

# Hobbies

I am interested in competitive multiplayer games (ARC Raiders ftw!), 3D printing and embedded electronics and software.
