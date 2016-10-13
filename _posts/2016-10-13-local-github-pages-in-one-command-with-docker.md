---
layout: post
title:  "Local GitHub Pages in one command (with Docker)"
permalink: local-github-pages-in-one-command-with-docker
---

I wiped and installed [macOs Sierra][macos-sierra] on Macbook Pro on the weekend, something I like to do regularly to hone my reboot procedure with [my dotfiles][my-dotfiles] repo. Part of that procedure is to get my blog up and running, which runs on Jekyll and GitHub Pages. I like to edit a blog post locally, and run `bundle exec jekyll serve` to see how the layout looks locally before I push to GitHub.

When I first installed Jekyll I installed [rvm][rvm] to manage and install Ruby. However I don't write Ruby code and find it's overkill to have to install it simply to start my blog. After all, I'm a **minimalist**, and I only really want to work in a terminal and a browser.

So I decided to try and spin up my Jekyll based GitHub Pages blog on Docker. And it turned out to be a really simple task.

First, I found the official jekyll docker images [here][jekyll-docker]. Visiting the wiki brought me to [Usage: Running][jekyll-docker-wiki-running] page, and combining the run command with GitHub's instructions to [Build your local Jekyll site][gh-pages-build-local]:
 
 ```
 docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll -it -p 127.0.0.1:4000:4000 jekyll/jekyll bundle exec jekyll serve
 ```
 
... to my delight, started the blog first time and was accessible at [http://localhost:4000](http://localhost:4000). 

Awesome. No dependencies to install. Easy to remove from my system. Minimalism at it's best.

[macos-sierra]: http://www.apple.com/uk/macos/sierra/
[my-dotfiles]: https://github.com/awolski/dotfiles
[rvm]: https://rvm.io/
[jekyll-docker]: https://github.com/jekyll/docker
[jekyll-docker-wiki]: https://github.com/jekyll/docker/wiki/
[jekyll-docker-wiki-running]: https://github.com/jekyll/docker/wiki/Usage:-Running
[gh-pages-build-local]: https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/#step-4-build-your-local-jekyll-site



