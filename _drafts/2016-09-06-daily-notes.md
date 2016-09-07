---
layout: post
title:  "Tuesday 6th September 2016"
date:   2016-09-06 10:57:00 +0000
permalink: 2016-09-06-daily-notes
---

In preparation for a technical call about clustering/failover issues with the VA today, I'm familiarising myself with some documentation we have. The first I read is [VSA VistA.js Availability & Performance Approach][failover-availability-approach]. The second [Failover Implementation Details][failover-implementation-details].

Here's how I spent my day:

Today I've been through all the documentation on clustering and failover I could get my hands on. I also looked into how the AWS environment is configured. I then set about running and using cluster mode in the docker environment.

I changed the start command for the vistajs process in supervisord.conf:
```
command = node --debug node_modules/vsa-server/bin/vsa-server startCluster --workers=3
```

And mounted the change as a volume into each of the vista profile containers:

```yaml
vista-profile:
    image: apexdatasolutions/vistajs:${VJS_TAG}
    environment:
      profile: vista
    volumes:
      - "./build/vistajs/supervisor/supervisord.conf:/etc/supervisord.conf"
```

On startup I could clearly see the workers being created in the logs.

I then tailed each of the worker logs for baypines, and made requests via the api browser. I could clearly see round robin scheduling working with the logs being updated in sequence.

I haven't hit any issues with hangs, slow logins, or anything Roy suggests.

### Assumptions

* We're using ECP for data syncronization between hosts?

### Thoughts & Tidbits

Write a blog post about how to shut down completely each day and start back up quickly. For Chrome, I don't want to open a specific setup of pages as per chrome://settings/startup... what if I'm not working that day? I just want a blank page. But another way to do it is to have a Bookmarks folder with your startup pages in it, click open all, select all tabs and choose to pin tabs.

[failover-availability-approach]: https://docs.google.com/document/d/1B8dYOK4IZTyhOlXHHL03RDjnMsuIxy8dwnkrjV8yZXw/edit
[failover-implementation-details]: https://docs.google.com/document/d/1FOe7ZBzD7AVQ6ZDSHc0MRiGueui4BIo7qs0Ej8YT-yE/edit
[chrome-startup]: chrome://settings/startup
[chrome-pinned-tabs]: https://www.reddit.com/r/chrome/comments/3wv7nv/help_open_folder_of_bookmarks_in_pinned_tabs/cxzfxn0
