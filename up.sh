#!/usr/bin/env bash

docker run -d --rm --label=jekyll --volume=$PWD:/srv/jekyll -p 4000:4000 jekyll/jekyll:3.5 jekyll serve
