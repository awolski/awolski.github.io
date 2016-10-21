---
layout: post
title:  "Immutable. Um, no it isn't"
---

When you're working on a large project for which the code base has been around for a long time, you have the pleasure (cough) of seeing some pretty 'interesting' code. 

Today for example, I had to use an existing model object. I noticed in the class level comment the word 'Immutable.' Having recently read about Google's AutoValue Java library for immutable value objects, I thought I'd look to see just how 'immutable' this object really is.

Unfortunately (for the author), Eclipse code assist immediately pointed out that the class in question is indeed very mutable. How can it be immutable with seven setter methods?

![](/assets/img/2015-01-08-mutable.png)

You can't call a class immutable when it extends from a parent object that is not immutable.
