---
layout: post
title:  "Starting and using a service during Docker build"
---

**Problem**: You're building a image from a Dockerfile and you need to interact with a running process during the build of the said image. How? I really struggled with this question for some time, but I've since discovered the solution. Read on to find out how...

My specific use case is this: start a local npm registry — [sinopia](https://github.com/rlidwka/sinopia) — that acts as a proxy with an uplink to another npm registry. Run `npm install --registry http://localhost:4873/` for a bunch of node modules, which pulls the node modules into the storage directory of the sinopia proxy. Then package up the the proxy sinopia instance as a distributable registry with all dependencies in its `storage` directory.

 When I first got started with Docker I tried this:

```
RUN sinopia --config /opt/sinopia/config.yaml
RUN npm install --registry http://localhost:4873/ <package>
```

But I soon realised this doesn't work. In this example, by the time the second RUN command executes, sinopia is no longer running. That layer of [Union File System](https://docs.docker.com/engine/introduction/understanding-docker/#how-does-a-docker-image-work) has already been committed.

There are a couple of ways you can achieve this. The first is to chain commands with double ampersand:

```
RUN sinopia --config /opt/sinopia/config.yaml && npm install ...
```

The other option, and the one I've taken in for the aforementioned problem due to the sheer number of things that need to happen while the sinopia registry is up, is to create a build script, `ADD` it to the Dockerfile and run it like so:

```
ADD build.sh /home/sinopia/
RUN /bin/bash -c /home/sinopia/build.sh
```

The `build.sh` script:

```bash
#!/bin/bash
...
sinopia --config /opt/sinopia/config.yaml
npm install --registry http://localhost:4873/ <package>
...
```
