---
layout: post
title:  "Upgrade Docker on Travis CI"
permalink: upgrade-docker-on-travis-ci
---

If you need to make use of Docker's latest and greatest features — like [build time arguments](http://docs.docker.com/engine/reference/builder/#arg) — in your travis-ci builds, you can easily do so by upgrading the default docker-engine version travis-ci's build environment. Read on to find out how...

I recently created a Dockerfile using Docker's new `ARG` instruction - which is awesome by the way. But when I went to setup a travis-ci build I discovered the travis build environment still uses docker-engine 1.8.2, so I was getting this:

```
Step 2 : ENV REFRESHED_AT 2015-11-22
 ---> Running in 4541847869ed
 ---> 7ad06199892e
Removing intermediate container 4541847869ed
Step 3 : ARG 
Unknown instruction: ARG
```

It turns out it is really quite straightforward to upgrade to the latest version of docker engine, 1.9.1 in my case. Simply add these lines to your `.travis.yml` file:

```
before_install:
  - sudo apt-get update
  - sudo apt-get install docker-engine
```

The output from the build after adding the above lines should contain this:

```
$ sudo apt-get install docker-engine
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be upgraded:
  docker-engine
1 upgraded, 0 newly installed, 0 to remove and 102 not upgraded.
Need to get 7,486 kB of archives.
After this operation, 9,517 kB of additional disk space will be used.
Fetched 7,486 kB in 0s (9,949 kB/s)
(Reading database ... 135346 files and directories currently installed.)
Preparing to unpack .../docker-engine_1.9.1-0~trusty_amd64.deb ...
docker stop/waiting
Unpacking docker-engine (1.9.1-0~trusty) over (1.8.2-0~trusty) ...
Processing triggers for ureadahead (0.100.0-16) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
Not building database; man-db/auto-update is not 'true'.
Setting up docker-engine (1.9.1-0~trusty) ...
Installing new version of config file /etc/init.d/docker ...
Installing new version of config file /etc/bash_completion.d/docker ...
docker start/running, process 3264
```

**A word of note**: Heed travis-ci's recommendation to [avoid apt-get upgrade](https://docs.travis-ci.com/user/installing-dependencies/#A-word-on-apt-get-upgrade):

> We recommend you avoid running apt-get upgrade, as it will upgrade every single package for which apt-get can find a newer version. As we install quite a few packages by default, this could end up downloading and installing up to 500MB of packages.
>
> This extends your build time quite significantly, so we generally recommend you avoid using it in your builds.
>
> If you need to upgrade a very specific package, you can run a normal ‘apt-get install’, which will install the latest version available.

I tried `apt-get upgrade` initially and the difference in build time is significant, as it would be when you're upgrading every single package in the build environment. In my case it was almost double (build #9 in the image below) compared to when I switched to `apt-get install`.

![apt-get upgrade vs install](/content/images/2015/11/Screen-Shot-2015-11-27-at-10-04-37.png)

