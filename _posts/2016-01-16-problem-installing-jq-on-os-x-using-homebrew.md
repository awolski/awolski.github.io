---
layout: post
title:  "Problem installing jq on OS X using Homebrew"
permalink: problem-installing-jq-on-os-x-using-homebrew
---

This is just a quick post for reference as I had issues installing [jq](https://stedolan.github.io/jq/) on my machine this evening.

```
$ brew install jq
==> Installing dependencies for jq: oniguruma
==> Installing jq dependency: oniguruma
==> Downloading https://homebrew.bintray.com/bottles/oniguruma-5.9.6.el_capitan.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring oniguruma-5.9.6.el_capitan.bottle.1.tar.gz
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink include/oniggnu.h
/usr/local/include is not writable.

You can try again using:
  brew link oniguruma
==> Summary
🍺  /usr/local/Cellar/oniguruma/5.9.6: 12 files, 1M
==> Installing jq
==> Downloading https://homebrew.bintray.com/bottles/jq-1.5.el_capitan.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring jq-1.5.el_capitan.bottle.1.tar.gz
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink include/jq.h
/usr/local/include is not writable.

You can try again using:
  brew link jq
==> Summary
🍺  /usr/local/Cellar/jq/1.5: 17 files, 953.3K
```
Following the suggestion, I tried to link jq:
```
$ brew link jq
Linking /usr/local/Cellar/jq/1.5...
Error: Could not symlink lib/libjq.1.dylib
/usr/local/lib is not writable.
```
No luck. So I made /usr/local/lib writeable by my user and then retried:
```
$ sudo chown -R $(whoami) /usr/local/lib
$ brew link jq
Linking /usr/local/Cellar/jq/1.5... 8 symlinks created
```
That seemed to have worked, but when I tried to run a jq command I hit more errors:
```
$ vault read -format=json secret/baz | jq -r .data.value
dyld: Library not loaded: /usr/local/lib/libonig.2.dylib
  Referenced from: /usr/local/bin/jq
  Reason: image not found
Trace/BPT trap: 5
```
So I tried removing jq and starting again:
```
$ brew remove jq
Uninstalling /usr/local/Cellar/jq/1.5... (17 files, 953.3K)
$ brew install jq
Error: You must `brew link oniguruma` before jq can be installed
```
Fine.
```
$ brew link oniguruma
Linking /usr/local/Cellar/oniguruma/5.9.6... 8 symlinks created
```
Third time lucky...
```
$ brew install jq
==> Downloading https://homebrew.bintray.com/bottles/jq-1.5.el_capitan.bottle.1.tar.gz
Already downloaded: /Library/Caches/Homebrew/jq-1.5.el_capitan.bottle.1.tar.gz
==> Pouring jq-1.5.el_capitan.bottle.1.tar.gz
🍺  /usr/local/Cellar/jq/1.5: 17 files, 953.3K
```
Woot. Fingers crossed...
```
$vault read -format=json secret/baz | jq -r .data.value
bar
```
Just in case you run into the same issue :-)