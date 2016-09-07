---
layout: post
title:  "Build scripts - don't modify my files!"
date:   2014-08-06 18:52:00 +0000
permalink: build-scripts-dont-modify-my-files
---

One of my pet hates when it comes to development is a build script or an IDE that modifies project/config files so that the project looks like it's modified in the IDE.

![Modified](/assets/img/2014-08-06-modified-scm-project.png)

When I check out a project from source control, whether it be Subversion, Git, Mercurial... whatever, until I physically open and edit a (not ignored) file in that project, I only want to see that little yellow cylinder looking thing.

![Unchanged](/assets/img/2014-08-06-unchanged-scm.png)

So here's a few **Don't**s to follow:

* *Don't* check in IDE generated files that might be modified by somebody else's specific IDE settings (and re-checked-in). I'm talking Eclipse .project, .classpath, and .settings/ for example.
* *Don't* let your build scripts modify source controlled files that someone may inadvertently check in with incorrect, build generated content.

And some **Do**s:

* *Do* use a plugin that generates IDE configuration files (.project, .classpath, .settings/ etc. in Eclipse). If you're using Maven + Eclipse, use [m2e](https://www.eclipse.org/m2e/). Gradle? Use the Gradle Eclipse/Intellij IDEA plugin.
* *Do* create new files with build specific properties you need to generate content for properties files
* *Do* mark all of the plugin generated files and folders as ignored in your subversion properties, .gitignore etc.

There's a [good answer](http://stackoverflow.com/a/337317/2309046) over on stackoverflow which discusses this topic which is definitely worth a read.
