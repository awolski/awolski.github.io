---
layout: post
title:  "Is it time to get off the JSF bandwagon?"
date:   2014-02-27 07:45:00 +0100
permalink: is-it-time-to-get-off-the-jsf-bandwagon
---

I watched a pertinent video tonight: ["Comparing JVM Web Frameworks" by Matt Raible](http://www.youtube.com/watch?v=ygW8fJVlDxQ). It was a really interesting presentation, and quite applicable to me at the moment because I'm trying to do decide an a new architecture and web framework for an application I've developed... one that currently uses Primefaces.

One slide in particular caught my attention, referencing a link to a ThoughtWorks note about JSF:

> "We continue to see teams run into trouble using JSF -- JavaServer Faces -- and are recommending you avoid this technology. Teams seem to choose JSF because it is a J2EE standard without really evaluating whether the programming model suits them. We think JSF is flawed because it tries to abstract away HTML, CSS and HTTP, exactly the reverse of what modern web frameworks do. JSF, like ASP.NET webforms, attempts to create statefulness on top of the stateless protocol HTTP and ends up causing a whole host of problems involving shared server-side state. We are aware of the improvements in JSF 2.0, but think the model is fundamentally broken. We recommend teams use simple frameworks and embrace and understand web technologies including HTTP, HTML and CSS."
>
> http://www.thoughtworks.com/radar/#/languages-and-frameworks/683

This does kind of sum up an underlying uncomfortable feeling I've had with JSF and the few frameworks I've worked with (MyFaces and PrimeFaces). Primefaces in particular is great if you want to get something done quickly with a whole load of out-of-the-box components. But I don't like the 'statefulness on  a stateless protocol (HTTP).' I'm drawn to use HTTP as it was intended (a stateless protocol) and move toward a REST based back end which I can plug in (and experiment with) any front end web framework I choose.

Something else to keep in mind is what Rich Manalang calls the four principles of modern web development:

* Designing for mobile first (even if you're not building a mobile app)
* Build only single page apps
* Create and use your own REST API (I really like this one - a work in progress for me)
* "Sex sells" applies to web apps
