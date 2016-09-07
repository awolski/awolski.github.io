---
layout: post
title:  "MD5 Checksums"
date:   2014-03-19 23:00:00 +0000
permalink: md5-checksums
---

Tonight I downloaded and installed [JDK8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) on my Macbook. I'm keen to get started playing around with the some of new features, in particular Lambdas and the [Streams API](http://download.java.net/jdk8/docs/api/java/util/stream/Stream.html); I really think these will streamline some of my code without having to incorporate Groovy (or similar) to get similar features, and then having to mess about with different compilers and Maven/Gradle plugins.

I digress...

Tonight, for the first time ever, I verified the MD5 checksum of a file I downloaded. Now I know that's not breaking news, but it struck me as... weird? shocking?... that in the 15+ years I've been pulling stuff off the world wide web, I've never before tonight thought (or been bothered) to check that what I'm downloading is what I think it is.

I wonder how many people do this these days, or even know how to? And seriously, how useful is it? It certainly isn't much of a security measure. I mean, if someone wanted to replace the file on the server with something malicious, they could certainly replace the checksum value too.

As a side point, message-digest hashing does have some pretty nifty uses. As an example, Liquibase stores the checksum of a changeset in the database, so that it can deal with occurrences where a changeset is modified after it has already been run:

>When Liquibase reaches a changeSet, it computes a check sum and stores it in the “databasechangelog”. The value of storing the check sum is so that Liquibase can know if someone changed the changes in the changeSet since it was run. If the changeSet was changed since it was run, Liquibase will exit the migration with an error because it cannot know what was changed and the database may be in a state different than what the changeLog is expecting.

Nice.

For the record, to verify your downloads against the checksum on the server you're downloading from (if there is one), it's really easy. Open up a terminal on Mac (or Linux) and type:

<pre><code>$ md5 jdk-8-macosx-x64.dmg
MD5 (jdk-8-macosx-x64.dmg) = 9cd6a6cfc3c1cbfc16483b3e0841d9bc</code></pre>

This example uses the [MD5 algorithm](http://en.wikipedia.org/wiki/MD5). Turns out the hash is the same as the one for my distribution on the Java SE 8 Binaries Checksum page, so my installation should be okay. Phew!
