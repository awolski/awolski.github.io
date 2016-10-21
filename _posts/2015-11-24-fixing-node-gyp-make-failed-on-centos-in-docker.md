---
layout: post
title:  "Fixing node-gyp make failed on centos in Docker"
---

I've had this issue pop up time and time again, so I wanted to document it so that I won't forget in the future. The error below occurs when executing `RUN npm install sinopia` in a Dockerfile FROM centos:6.6 (no doubt this isn't specific to Docker).

<pre>node-gyp configure build
<span style='color:red;'>gyp WARN EACCES user "undefined" does not have permission to access the dev dir "/root/.node-gyp/0.12.7"
gyp WARN EACCES attempting to reinstall using temporary dev dir "/usr/local/node/lib/node_modules/sinopia/node_modules/fs-ext/.node-gyp"</span>
make: Entering directory `/usr/local/node/lib/node_modules/sinopia/node_modules/fs-ext/build'
  CXX(target) Release/obj.target/fs-ext/fs-ext.o
<span style='color:red;'>make: g++: Command not found
make: *** [Release/obj.target/fs-ext/fs-ext.o] Error 127</span>
make: Leaving directory `/usr/local/node/lib/node_modules/sinopia/node_modules/fs-ext/build'
<span style='color:red;'>gyp ERR! build error
gyp ERR! stack Error: `make` failed with exit code: 2
gyp ERR! stack     at ChildProcess.onExit (/usr/local/node/lib/node_modules/npm/node_modules/node-gyp/lib/build.js:269:23)
gyp ERR! stack     at ChildProcess.emit (events.js:110:17)
gyp ERR! stack     at Process.ChildProcess._handle.onexit (child_process.js:1074:12)
gyp ERR! System Linux 4.1.12-boot2docker
gyp ERR! command "node" "/usr/local/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js" "configure" "build"
gyp ERR! cwd /usr/local/node/lib/node_modules/sinopia/node_modules/fs-ext
gyp ERR! node -v v0.12.7
gyp ERR! node-gyp -v v2.0.1
gyp ERR! not ok
npm WARN optional dep failed, continuing crypt3@0.1.8</span>
</pre>

The error seems obvious at first glance; g++ is not installed. But adding that as one of the packages I install at the top of the Dockerfile had no effect whatsoever.

<pre>
RUN yum upgrade -y && yum install -y <strong>g++</strong> tar
</pre>

I trawled loads of GitHub issues and StackOverflow pages with similar problems. Some indicated it was a Node 0.12 issue, so I tried 4.2.1, but the error persisted. Because the sinopia seems to install and run correctly despite the error I almost gave up on trying to fix it. But I just hate seeing those errors in my build... I had to crack it.

Then I stumbled [this GitHub issue](https://github.com/Automattic/node-canvas/issues/625) that gave me hope:

> No, on Centos 7, there is no g++ package in repos. However, I've installed gcc-c++ and the problem is solved

<pre>
RUN yum upgrade -y && yum install -y <strong>gcc-c++</strong> tar
</pre>

Problem solved.