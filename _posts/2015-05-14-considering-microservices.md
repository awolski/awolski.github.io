---
layout: post
title:  "Considering Microservices"
permalink: considering-microservices
---

One of the most valuable blogs I subscribe to is [Martin Fowler's](http://martinfowler.com/). I say valuable because every post he creates makes me a better developer. His posts are always thoughtful, insightful, detailed and thorough. You just know each one packs so much experience behind it you'd have to be a fool not to take his insights board.

Having myself been swept up in the hype of microservices — what he and the ThoughtWorks Technology Radar group call [microservices envy](http://www.thoughtworks.com/radar/techniques/microservice-envy) — I was interested to read his latest post [MicroservicePremium](http://martinfowler.com/bliki/MicroservicePremium.html), in which he explains under what circumstances, or complexity, a microservice architecture becomes preferable over a monolithic one.

> So my primary guideline would be **don't even consider microservices unless you have a system that's too complex to manage as a monolith**. The majority of software systems should be built as a single monolithic application. Do pay attention to good modularity within that monolith, but don't try to separate it into separate services.

An interesting opinion, and one that I will, again, take on board. But I have some opinions of my own. 

There are systems that I work on that are blatantly too complex to manage as a monolith; they're crying out to have sections ripped out and developed independently. There are others that are probably small and simple enough to be built monolithically, but that I would still consider breaking up and taking a hit on the complexities of a microservices architecture.

I've done a load of researching, experimenting and even implementing microservice architectures since I first discovered the concept a few years ago. I ~~fully~~ understand a lot of the complexities that going down the microservice/distributed architecture route introduces. But for me, similar to the way Martin starts his his answer in his post, it depends.

> When you use microservices you have to work on automated deployment, monitoring, dealing with failure, eventual consistency, and other factors that a distributed system introduces. There are well-known ways to cope with all this, but it's extra effort, and nobody I know in software development seems to have acres of free time.

Of course the quickest way to the finish line of application development is the tried and tested approach. The monolith way. But what if you have time? What if you know the system you're developing would be better developed not as a monolith, but as a number of small, isolated but integrated parts? Do you just slap out a single deployable and be done with it, just because it doesn't — or might not — hit the complexity 'threshold'? Or do you spend the time working through microservice baggage, coming out the other end with a cleaner, clearer solution?

Personally, I'm glad for my foray into the microservices hype, even though some of the systems I'm working on might not have warranted it. I can't overestimate the value of what I've learned in the process. I feel I'm better equipped now to make the decision when a monolith is too complex and needs to be split up, and when not to. True, some of the systems I've developed could well have been completed quicker if I'd chosen the tried and tested path. But in my opinion, you've got to be searching for improvement. You've got to be [Kaizen](http://en.wikipedia.org/wiki/Kaizen) focused. Even if it's a little more painful and/or time consuming getting to the end goal.

Just my two cents.