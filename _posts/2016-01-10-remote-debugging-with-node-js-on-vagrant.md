---
layout: post
title:  "Remote debugging with Node.js on Vagrant"
permalink: remote-debugging-with-node-js-on-vagrant
---

I recently worked out worked out how to remote debug from my Macbook Pro to a Node.js server running on a CentOS 6.6 VirtualBox VM created by Vagrant. No more development tools like WebStorm on a VM as I can now use them from my Mac.

### Background

I created a Vagrant environment a while back for one of the applications I'm working on that makes it easy for non-technical colleagues to spin up an environment for testing and documentation. I've always wanted to be able to use the Vagrant box during development so that I don't have to install X different databases and programming language SDKs on my Macbook; but I never managed get remote debugging working. I've always just created a VM and installed all my development tools onto it, so everything is 'local' inside the VM. 

But really what I want is to use the WebStorm, Intellij etc. from my Mac, and have the applications I'm working  on, especially complex stacks like this particular one, spun up on Vagrant or Docker. After all, I have my terminal, development tools and utilities set up just the way I like them on my Macbook.

### How To Video

There's a great video on how this all works here:

<iframe width="560" height="315" src="https://www.youtube.com/embed/XY1RyOvFXEw" frameborder="0" allowfullscreen></iframe>

### Process

From within the Vagrant virtual machine:

Install node-inspector:

```
$ npm install -g node-inspector
```

Start the server with the --debug flag:

```
$ node --debug path/to/node/app start &
[1] 1990
[vagrant@localhost]$ Debugger listening on port 5858
```

Start node-inspector:

```
$ node-inspector
Node Inspector v0.12.5
Visit http://127.0.0.1:8080/?ws=127.0.0.1:8080&port=5858 to start debugging.
```

Then from your host machine, in my case my Macbook Pro, open the url that node-inspector spat out (http://127.0.0.1:8080/?ws=127.0.0.1:8080&port=5858):

![](/assets/img/2016-01-10-node-inspector.png)

Et voila, you've got a debug tool very similar to Chrome Dev Tools debugger for your remote Node application.