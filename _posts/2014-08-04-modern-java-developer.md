---
layout: post
title:  "Modern Java developer"
date:   2014-08-04 20:00:00 +0100
permalink: modern-java-developer
---

I was reading through my Feedly feed a couple of days ago and came across [this article](http://jaxenter.com/the-in-tools-ten-technologies-you-should-know-about-50852.html), a repost of Zero Turnaround's [10 Kick Ass Technologies Modern Developers Love](http://zeroturnaround.com/rebellabs/10-kick-ass-technologies-modern-developers-love/). I was pleasantly surprised as I read through the list that I know and frequently use the majority of them:

1. **Confluence** - We use Confluence for ~~all~~ most of the technical documentation at my company; in fact, I wrote an internal blog post a few days ago. It's a nice, intuitive application, and really easy to use. It still feels like it's got a lot of work to go into it - that it's not as polished as JIRA - but the it's by far the best online document management tool I've used.

2. **Git** - As a developer, if you haven't heard about or used Git by now... where the hell have you been? I use Git for my personal projects, and have been pushing to get it at the my company for quite a while now (we still use SVN - Linus Torvalds gives his [opinion about SVN here](https://www.youtube.com/watch?v=4XpnKHJAok8)). I'm by no means a Git expert, but I'm learning more and more all the time. And I can without hesitation vouch for Git's power.

3. **Gradle** - I'm still in between Maven and Gradle when it comes to build tools and dependency resolution on my own projects. I'm really familiar with Maven. I don't need to do anything too fancy or customised with it, the Eclipse plugin works really well with it, and Jenkins builds work out of the box. I do really like the look of Gradle, and have experimented with it both personally and at work. We use Ant + Ivy at work, so I took one of our existing projects and converted it to Gradle as a proof of concept; talk about simplicity. 10 line Gradle scripts replace hundred line Ant scripts + Ivy files.

4. **Groovy** - Earlier this year I read Making Java Groovy, and I was pleasantly surprised at how well it does things that Java makes hard. I started incorporating Groovy into my projects from then on. My Maven pom.xml files now all use the groovy compiler:

5. **IntelliJ IDEA** - I have IntelliJ IDEA installed, and I've dabbled with it, but I can't say it's my go-to IDE... yet. After using Eclipse for so long, and knowing it so well, it's going to take time, experimentation, and patience before I can make a bona-fide decision on which IDE is the one.

6. **Jenkins** - Now this one I know. I've championed the introduction of Jenkins as the continuous integration tool of choice at the last two companies I've worked for, and have set up build pipelines that have automated much of what was previously done ad-hoc and manually. There are so many plugins and resources out there to get your builds and deployments humming nicely. I currently use a CloudBees free account to run a build and deployment pipeline for one of my live projects, based on the talk [Real-World Strategies for Continuous Delivery with Maven and Jenkins](www.youtube.com/watch?v=McTZtyb9M38).

7. **JIRA and Confluence** - We use this in work. A lot. JIRA is a fantastic product... I'd like to see what type of market share it has for issue management products. I've no doubt it's an overwhelming majority, because it's just damn good.

8. **MongoDB** - Read about it, contemplated using it in a personal project, but not pulled the trigger yet.

9.  **Scala** - I recently started a Coursera course called [Functional Programming Principles in Scala](https://www.coursera.org/course/progfun). Unfortunately I had to pull the pin after the 3rd assignment as a combination of family (the arrival of my second child) and work commitments  meant my time was limited. But not before I recorded 10/10 for the first three assignments. Scala looked promising and I will most certainly invest the time to learn the language going forward.

10. **Tomcat + TomEE** - I have a system running on Tomcat for 80+ simultaneous users, and it has been live now for over a year and a half. On top of that, we use Tomcat for development in work, and it has been my go-to servlet container for many, many years. To be honest though, lately I've been looking at switching to applications running on embedded Jetty instances, and have been reworking a couple of applications to run on the [Dropwizard](https://dropwizard.github.io/dropwizard/) framework.

Well, according the the original article:

> If you already know more half, give yourself a pat on the back.

Done.
