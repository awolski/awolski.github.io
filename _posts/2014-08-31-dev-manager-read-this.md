---
layout: post
title:  "Dev manager, read this"
permalink: dev-manager-read-this
---

I clipped a link to [this article](http://www.activestate.com/blog/2014/08/microservices-and-paas-part-i) earlier this week, thinking it was one of the best things I've read on micro-services and continuous, PaaS and continuous delivery all year. But to be sure, I wanted to revisit it later, hence the clip to Evernote. I've just re-read it now, and it is. So many great nuggets of ~~information~~ experience to draw on from people who have been there, done that. It's the sort of article you just want to stick on your development manager's desk and with a note saying "this is how we need to be developing, deploying, delivering."

### Microservices advantages

> Small independent microservices can be built using the technology best suited for their requirements. No longer does every application component need to be built on a common company-mandated language and framework such as Java/Spring or Ruby on Rails.

Or insert your enterprise stack here. It's true. With a monolothic architecture, developer's are constrained to using the stack that somebody decided years and years ago, which may not be the best way to do things now. Just try and re-architect it... yeah right, it's just not going to happen. Microservices make sense in this respect, in that it allows developers to experiment with new and better fitting technologies for small components, that aren't going to break *everything*.

### Speed wins

> Rapid software delivery is the most important factor for success, and thus, effort spent in streamlining this is effort well spent. Microservices drastically improve the time required to push out a new update, allowing a much more agile development process.

Read that again dev manager.

> Trusting developers, and promoting a culture of freedom with responsibility not only reduces software delivery times and increases success rates, but also has the side effect of improving workplace culture and employee retention.

And that.

### Process is Scar Tissue

> process is usually based on old and legacy ways of doing things. As a result, it rarely adapts to new requirements, is often complex and burdensome, and brings with it all sorts of baggage like training and documentation overhead. To an organization delivering software, process is "scar tissue" and should be removed.

And change is difficult to introduce in an organisation that is entrenched in process... I know from experience. But unless you have buy-in and investment from the very top, process is very difficult to remove.

### Invert Conway's Law

> Conway's Law... states that "the interface structure of a software system will reflect the social structure of the organization(s) that produced it." So if we start off with a company that's complex, costly to run, fragile, inflexible, mired-in-process, and bureaucratic, guest what? We'll end up with software that has the same characteristics.

This article is definitely worth a read, particularly if you work in an organsation that is mired in legacy processes and with monolithic application architectures, or if your working towards a more agile and microservices architecture.

I'll be forwarding it on to our development manger.
