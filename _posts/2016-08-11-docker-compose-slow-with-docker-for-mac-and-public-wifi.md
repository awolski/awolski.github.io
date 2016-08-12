---
layout: post
title:  "Docker Compose slow on Docker for Mac and public wifi"
date:   2016-08-11 13:32:00 +0100
permalink: docker-compose-slow-with-docker-for-mac-and-public-wifi
---
On a recent visit to a Caffé Nero coffee shop, [docker-compose][docker-compose] commands were running **extremely** slowly. After an hour or so of restarting Docker, my Mac, and switching back an forth between [Docker for Mac][docker-for-mac] and [Docker Machine][docker-machine], I just gave up and headed home, pinning the issue on the then-still-beta Docker for Mac.

Today I encountered the same problem, in a different Caffé Nero and on a stable version of Docker for Mac. It couldn't be just a coincidence. A quick search brought me to [this][github-issue] GitHub issue, and in particular this answer:

> Hi guys,
`127.0.0.1 localunixsocket` to `etc/hosts` solved the issue for me

And sure enought, updating `/etc/hosts` to include `127.0.0.1 localunixsocket` fixed the issue immediately.

[docker-compose]: https://docs.docker.com/compose/reference/overview/
[docker-for-mac]: https://docs.docker.com/engine/installation/mac/#/docker-for-mac
[docker-machine]: https://docs.docker.com/machine/
[github-issue]: https://github.com/docker/compose/issues/3419
