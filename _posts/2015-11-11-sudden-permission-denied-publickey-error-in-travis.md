---
layout: post
title:  "Random 'Permission denied (publickey)' error in Travis"
date: 2017-01-02
---

This morning I hit a random issue in Travis (Pro), in that all of a sudden a build could not clone a GitHub repository:

```
Installing an SSH key from: default repository key
Key fingerprint: 5e:fd:38:1f:01:e2:f0:87:8e:77:91:e7:70:37:c0:14
3.68s

$ git clone --depth=50 --branch=my-branch git@github.com:my-organisation/my-repo.git my-organisation/my-repo
Cloning into 'my-organisation/my-repo'...
Warning: Permanently added the RSA host key for IP address '192.30.254.137' to the list of known hosts.
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights and the repository exists.
The command "eval git clone --depth=50 --branch=my-branch git@github.com:my-organisation/my-repo.git my-organisation/my-repo" failed. Retrying, 2 of 3.
```

I had no idea why this was occurring. As far as I knew nobody had changed any of the settings on GitHub. And all previous builds had succeeded (or failed for other, valid reasons).

I did a quick inspection and suspiciously there were no deploy keys:

![github-deploykey-empty](/assets/img/2015-11-11-no-deploy-keys.png)

Strange. I could have sworn Travis adds a deploy key when you sync a repository. I went to the Travis CI profile page and turned off the repository in question and then back on again.

![travis-git-repo-on](/assets/img/2015-11-11-repo-sync.png)

After doing so and kicking off the build again everything seemed back to normal. The build worked, and there was a deploy key in the GitHub repository settings.

![github-deploy-key](/assets/img/2015-11-11-deploy-key.png)

Weird.
