---
layout: post
title:  "Using Docker to spin up databases for development"
permalink: using-docker-to-spin-up-databases-for-development
---

Using Docker to spin up production-like databases during application development can help take out the uncertainty of whether your changes will work when deployed to production. In this post, I'll show you how I use Docker to create a clean MySQL database that mirrors production each time a start development on a new feature.

Have you ever been developing something for a long period of time, making changes to your development database as you go, and then when you've gone to integrate it into staging or production things haven't quite worked? You've had to manually write scripts to 'fix' things, or try and get back to your clean development database state by exporting, copying and importing... all manually via your database client?

If this sounds like you (as it did me), you'll be pleased to know there are better ways to manage your development database workflow. 

I user [Docker](https://www.docker.com/) (specifically [Docker Machine](https://docs.docker.com/machine/)), to spin up clean MySQL instances, and with a few commands have a production-like database to develop against. And the best part about my workflow is that I don't have to install MySQL on my laptop or have numerous schemas floating around. If I want to remove what I've been doing and start afresh, all I have to do is stop and remove the containers I've been working with.

Here's how I do it:

First create or restart a VM using Docker Machine:

```
docker-machine create --driver virtualbox dev` or `docker-machine restart dev`
```

Then set your machine as the one you'll be using:

```
$ docker-machine env dev
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH="/Users/awolski/.docker/machine/machines/dev"
export DOCKER_HOST=tcp://192.168.99.100:2376
# Run this command to configure your shell: eval "$(docker-machine env dev)"
$ eval "$(docker-machine env dev)"
```

This will let you run `docker` from the command line which will be run against your dev machine.

Next, create a mysql data container to store our data:

```
$ docker create -v /var/lib/mysql --name my-database mysql  /bin/true
6e144f951abb32fa985353c42ad0c46b629da0e2f4f367aa724b526dfbe752b8
```

We can check that the container was created with `docker ps -all`:

```
$ docker ps -all
CONTAINER ID    IMAGE         ...  NAMES
6e144f951abb    mysql:latest  ...  my-database
```

Now start a MySQL container, exposing the port (so that we can connect from the host machine) and mounting the data container with the `--volumes-from` argument:

```
$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 --volumes-from my-database -d mysql`
```

You should now see that the container is up and running:

```
$ docker ps
CONTAINER ID    IMAGE         STATUS        PORTS                   NAMES
600ed53340ab    mysql:latest  Up 4 minutes  0.0.0.0:3306->3306/tcp  mysql
```

I don't have, nor do I want to install, a MySQL client (visual or otherwise) on my pristine laptop. So how are do we get the schema and data into our MySQL container running on Docker? The answer is to run whatever commands we need using another MySQL Docker container linked to our 'server instance'. Instructions on how to do this are outlined in the section **Connect to MySQL from the MySQL command line client** on the [MySQL Docker image](https://registry.hub.docker.com/_/mysql/) page in the official Docker registry.

Now create the schema that our application is going to use:

```
$ docker run -it --link mysql:mysql --rm mysql sh -c \
   'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" \
   -P"$MYSQL_PORT_3306_TCP_PORT" -uroot \
   -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" \
   -e "create schema my-schema"'`
```

Check that the database was created:

```
$ docker run -it --link mysql:mysql --rm mysql sh -c \
    'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" \
    -P"$MYSQL_PORT_3306_TCP_PORT" -uroot \
    -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" \
    -e "show databases"'
Warning: Using a password on the command line interface can be insecure.
+--------------------+
| Database           |
+--------------------+
| information_schema |
| my-schema          |
| mysql              |
| performance_schema |
+--------------------+
```

Next I want to take a snapshot of the production database:

```
$ docker run -it -v /Users/awolski/Downloads:/tmp \
   --rm mysql sh -c 'exec mysqldump -h<production_db_ip> \
   -uusername -p <production_schema> > /tmp/my-schema.sql'
Enter password:
```

And then import my snapshot into the new schema I created, mounting the directory I exported the production schema to as a volume:

```
$ docker run -it -v /Users/awolski/Downloads:/tmp \
   --link mysql:mysql --rm mysql sh -c 'exec mysql \
   -h"$MYSQL_PORT_3306_TCP_ADDR" \
   -P"$MYSQL_PORT_3306_TCP_PORT" -uroot \
   -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" \
   my-schema < /tmp/my-schema.sql'
```

I can verify that everything worked by showing the new tables:

```
$ docker run -it --link mysql:mysql --rm mysql sh -c \
   'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" \
   -P"$MYSQL_PORT_3306_TCP_PORT" -uroot \
   -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" \
   -e "use my-schema; show tables;"'
```

(I've omitted the output for brevity).

There you have it... point your application at the ip output by `docker-machine ip` and you're away, coding against a production-like database.

Obviously you don't want to run all of these commands every time you need to start from scratch. And let's be honest, who's going to remember all of those environment variables anyway. So best to create a script to replicate it, using a few arguments for customisation. But I'll leave that as a task for the reader!