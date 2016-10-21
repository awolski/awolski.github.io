---
layout: post
title:  "Unit tests: worth their weight in gold"
---

For the whole of today, and a large chunk of yesterday, I laboured away writing a single unit test. Without context 1.5 days for a single unit test sounds pretty bad, but in my defence, the test involved mocking out numerous services and a deep understanding of the underlying model and a complex part of the system in order to set up the scenario I was trying to test. Because of this complexity, and the possibility of inadvertantly breaking existing functionality and/or business rules, I wanted to make *damn sure* my changes were sound.

![Test confidence](/assets/img/2014-09-02-unit-testing.gif)

We don't have a strong unit testing culture at my company, at least not on this particular project. I think this is partly due to culture, partly historical. But I also think there can be too much of a focus in enterprise software teams to 'just get things into test' as soon as possible, oftentimes to the detriment of code quality,  correctness, and the validation of the two.

It's a shame that management sometimes don't understand, or often overlook, the fact that unit testing actually saves time in the long run. In my opinion, the time I spent over the last couple of days will pay for itself tenfold in future development, through developer confidence, and a reduction in the number of release/test/develop lifecycles we'll need to go through.

Search the web and you'll find so many great resources on  why [unit testing is worth the effort](http://stackoverflow.com/a/67500), but for me there are a few crucial ones:

1. **It proves your code actually works.** If your unit tests provide enough coverage and test the right (or wrong) scenarios *you'll know that your code works*.
2. **It gives you a low-level regression suite.** Good unit test coverage gives your developer colleagues the confidence to make changes to the code fast. They'll know that if they mess something up, a simple execution of the test suite will tell them so, not a production incident months down the line.
3. **It improves the design and quality of your code.** Unit testing, particulary if done before the actual coding, helps you think about how the code should be pieced together in a way that not only *can* be unit tested, but is well designed. It also allows you to refactor existing code without concern for breaking its functionality.
4. **It reduces the cost of bugs.** A no brainer really. How much cheaper is it to debug and fix an issue locally over an issue that is found after the software is built, released, deployed, user acceptance tested, and shipped?
