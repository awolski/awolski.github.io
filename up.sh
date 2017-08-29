#!/usr/bin/env bash

docker run --rm --label=jekyll --volume=$PWD:/srv/jekyll -it -p 4000:4000 jekyll/jekyll:3.5 jekyll build
