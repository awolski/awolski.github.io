---
layout: post
title:  "Chances are someone's coded it already. Better."
---

Before you go and write that feature or half-baked code or API, spend some time searching for it. Search in your own code base, on Google, on GitHub, anywhere. Because chances are, somebody has already written code that does exactly what you need. Better than the half-baked shite you're about to churn out too.

![Code Reuse](/assets/img/2015-01-09-code-reuse.gif)

### You're problem is not unique.

Today I almost fell into the age-old trap of thinking that the problem I was confronting was unique, and the solution would need to be also. And being a bit of a pefectionist (at times), in the back of my mind I knew that coming up with an elegant solution to it would have taken me a day... and the rest. The design, trying to make it generic in order to capture more cases than the one I was trying to solve, testing, refactoring. Rinse, repeat. I had that gut feeling, the bad one... optimistic that coding this up wouldn't make me miss my deadline, but realistic that it would.

This happens all the time. A week ago a colleague was about to write his own profiling code using `System.currentTimeMillis()` before I pointed him in the direction of the [Metrics library](http://blog.awolski.com/simple-and-poejava-metrics-with-metrics/). If he had have spent 30 minutes - 1 hour searching, researching and experimenting, he would have been done in a fraction of the time, with a more robust solution.

### Find the code you're looking for

So today all it took was 5 minutes of browsing through the dependencies already in my web application, 10 doing a bit of research on the Javadoc of Apache Commons Collections, and 20 experimenting with how the library worked, and I had my solution. Avoiding hours of unecessary work.

None of what we do now as developers is possible without the thought and hard work of those that have gone before us. So we should look to the past so as not to waste time creating what already exists.
