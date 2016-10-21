---
layout: post
title:  "JavaOne 2013 - Decompose that WAR! Architecting for Adaptability, Scalability and Deployability"
---

Last night I watched the JavaOne 2013 session [Decompose that WAR! Architecting for Adaptability, Scalability and Deployability](http://parleys.com/play/525047b6e4b0c4f11ec5764b). The presenter was Chris Richardson, the author of [POJOs in Action](http://www.amazon.co.uk/POJOs-Action-Developing-Applications-Lightweight/dp/1932394583), and in the  talk he discusses how very large applications bundled into a single war, what he calls monolithic applications, can give you more headaches than the benefits they provide.

### Problems with the Monolithic Architecture

First, he discussed the problems with a monolithic architecture

* It intimidates developers. New developers don't know where to start.
* It's an obstacle to frequent deployments. You need to redeploy the entire application to change just a single component. This can interrupt batch or scheduled jobs, and it increases the risk of failure. This has a knock on effect in that:
	* There is a lot of pressure to get it (deployments) right
    * Change happens less frequently
    * QA is slow, because you've got to test the entire application for small changes

* It overloads your IDE and your web container:
	* For your IDE, the larger the app, the slower your IDE, and the less productive you are
    * For the container, the longer it takes for the application to start up, the slower the development, deploy, restart, test cycle is.
It's an obstacle to scaling development. Your development teams (UI, backend etc.) and test teams get in the way of each other, waiting on each other.
	* It locks you into a long term commitment to a technology stack, and stops you from being able to adopt new and upcoming technologies.

I can certainly relate to a lot, if not all, of these points. I currently work on an accounting application that is integrated into a insurance application. Even, the accounting application on its own could be considered monolithic, but when the insurance project is built, it pulls in the entire accounts web application as an Ivy dependency and bundles the whole lot up into a single, huge 'monolithic' app.

Our development and QA team suffer from all of the issues mentioned above:

* New developers are intimidated by the application, even just the accounts side, let alone the insurance component. I've been working on the system for over a year and a half now and I'm still not 100% confident with it.
* The frequency of our deployments, although they've improved, are still only once a day (scheduled). Yes, we can get a deployment out to a test box multiple times if need be, but even then the build/deploy lifecycle takes about an hour. And that's just for QA. Production deployments happen only a few times each year.
* We need 1GB RAM in our Tomcat JVM settings just to get the accounts application running in Eclipse. 'Nuff said.
* Yeah, I don't think we'll be switching any of our development stack any time soon. It's not a bad stack (JSF, Spring, Hibernate etc.), but changes to it wouldn't be an option. Version updates don't keep up either.

### An Alternative: Micro-Architecture

Richardson suggests a better approach is decompose your applications into small, manageable services; an architecture he calls 'Micro-Architecture'. The idea
smaller, simpler applications that:

* Are easier to understand and develop
* Have a reduced startup time
* Give you less jar/classpath hell
* Who needs OSGI when you've got micro-architecture
* Eliminates long term commitment to a single technology stack. Moves us into the world of modular, polyglot, mulit-framework applications. Lets you try out new technologies. If they don't work out, you can just throw them away and try something else.
* Scales Development : develop, deploy and scale each service independently
Improves fault isolation

The bit I really like from the list above is the ability to build one service with one technology, and another service in a completely different development stack. As long as the interfaces are defined and implemented correctly, each service can be developed in whatever technology the developer chooses: Scala, Groovy, NodeJS etc. I love experimenting with different languages so this really hit the spot.

Of course, this approach is by no means a panacea. Problems Richardson highlights are:

* Complexity: Teams dependent on teams, and it can be difficult to track down an issue
* Multiple databases and transaction management
* Implementing features that span multiple features can be challenging

Richardson goes into a high level overview about micro-architecture integration patterns, data formats and technologies like synchronous HTTP, asynchronous communication, JSON, XML, Protocol Buffers, Thrift etc. I'll leave it up to the reader to check out the presentation for more details.

###Tips about how to go from a 10M line monolithic app to a 'nice' architecture…

Strategy #1 - Make any new services a small, pristine services. Don't just shove in new functionality with the rest of the monolithic application. Put an anti-corruption layer in between the monolith and the pristine new service/functionality.

Strategy #2 - Extract existing services. Spend some time describing what the ideal partitioned architecture is. Then Start extracting those parts into new, small, pristine services. Partition the system by verb or noun.

An in all a interesting talk and one well worth checking out.
