---
layout: post
title:  "Parallel deployment in Tomcat"
permalink: parallel-deployment-in-tomcat
---

Recently I've been looking for the ~~right~~ best way to deploy an application with zero downtime. My search led me to a nifty feature introduced into Tomcat 7 called [parallel deployment](http://tomcat.apache.org/tomcat-7.0-doc/config/context.html#Parallel_deployment). Parallel deployment allows you to deploy multiple versions of a web application with the same context path at the same time.

Let's say you've got an awesome application running on Tomcat at the url `http://yourdomain.com/awesomeapp`. Normally You deploy the war — something like `awesomeapp-1.0.0.war` — to `$CATALINA_HOME/webapps/`. You've modified the `path` element of your context.xml file so that your app is reachable at the aforementioned url. You realise you need to deploy a new version of your app because *&lt;insert your reason here&gt;*, but you don't want to have to bring down the whole application server and deploy the new version of the app.

With Tomcat 7 you don't have to.

If you follow the Tomcat parallel deployment versioning conventions, you can just drop the new updated version of your application in the $CATALINA_HOME/webapps directory and *new* users will see the new version of your application, whilst *old* users (those with existing sessions) will continue to see the *old* version.

So what are the version conventions you need use to make this work?

> The version component is treated as a String both for performance reasons and to allow flexibility in versioning schemes. String comparisons are used to determine version order. If version is not specified, it is treated as the empty string. Therefore, `foo.war` will be treated as an earlier version than `foo##11.war` and `foo##11.war` will be treated as an earlier version than `foo##2.war`. If using a purely numerical versioning scheme it is recommended that zero padding is used so that `foo##002.war` is treated as an earlier version than `foo##011.war`.

I tested this out by deploying version 1.0.17 of an application I'm working on to a local `$CATALINA_HOME/webapps/app-name##1.0.17.war`, and opening the application in Chrome. I then made a small but noticeable UI change, built and deployed version 1.0.18 to `$CATALINA_HOME/webapps/app-name##1.0.18.war`, opening the application in Safari. I was surprised to see how easily it parallel deployment works... the two browsers were showing different versions! Safari, with no session information from the first version deployed automatically loaded second deployed version. After clearing the cache in Chrome, the second version (1.0.18) was displayed. Nice.

There are certainly things that you need to consider before you adopt this approach for zero downtime in a production implementation (such as database schema changes, potentially serious bugs in and old version still being used becuase of sessions).

Parallel deployment may not be the answer to my zero downtime goal, but it's always nice to discover and play around with features you weren't aware of.
