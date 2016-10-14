---
layout: post
title:  "Mockito Javadoc. The best use of Javadoc, ever"
permalink: mockito-javadocs-the-best-use-of-javadoc-ever
---

Whilst writing a few test cases this morning using [Mockito](https://github.com/mockito/mockito) as my mocking framework, I was browsing Mockito's official [documentation](http://site.mockito.org/mockito/docs/current/org/mockito/Mockito.html). I was particularly impressed with the conciseness of the examples and explanations. In no time at all I had the information I needed. Then it dawned on me that these beautifully formatted, thoroughly useful help pages were generated using the [Javadoc documentation tool](https://www.google.co.uk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0CCkQFjAB&url=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Farticles%2Fjava%2Findex-jsp-135444.html&ei=YJoZVfD-BYTcas7XgOgN&usg=AFQjCNFEz_fxLI435eayi9HEMEKceAL3vw&sig2=1UR3I3TiBO_Uj3xfQMZVUg)... I was gobsmacked. I've never seen such a fantastic use of Javadoc before. In fact, I was a bit jealous that I'd never thought to use the Javadoc tool in such away before.

![Mockito Javadocs](/assets/img/2015-03-30-mockito-docs.png)

### A history of poor Javadoc

Java documentation is not something done particularly well on many (or any) of the projects I've worked on. Typically thera are Eclipse generated Javadoc comments present, but they are limited to a short description of what the class or method is and possibly an explanation of it does. On very few occasions have seen the use of html tags for formatting, linking, least of all fully blown getting started pages or user guides.

So why is that? Why, as Java developers with this fully fledged, powerful documentation tool at our fingertips, do we not produce beautiful, informative documentation like Mockito's?

One reason is that more often than not Javadoc is only ever seen by the developers working on the code. And when you're writing code, you just want to crack on doing that... writing code. Writing Javadoc comments that are only going to be seen (and maybe read) by other developers just gets in the way. And in a lot of cases our Javadoc is never intended to be read by anyone other than developers on the same project.

But what if it's an open source framework that's consumed by thousands of developers? Well, documentation like getting started guides, user guides, are usually done on external tools like wikis, Github \*.md files, and confluence.

### Benefits of using Javadoc for documentation

One benefit I see to using Javadoc as your main documentation tool is that you can write your getting started guides, examples, explanations, and more, as and when you're writing you're code. When you're in the midst of finishing off that elegant method, for which you've already written your unit tests, you can be filling your Javadoc with fresh examples and explanations in the same work block.

Another huge benefit to using Javadoc for more elaborate documentation is that when you check in your code, your documentation goes with it. Your changes are recorded. You have a full history of all of your documentation changes for zero extra effort.

I know I'll be revisiting Mockito's documentation as a source of inspiration in the future.