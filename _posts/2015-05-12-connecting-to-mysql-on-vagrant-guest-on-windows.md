---
layout: post
title:  "Connecting to MySQL on Vagrant guest on Windows"
permalink: connecting-to-mysql-on-vagrant-guest-on-windows
---

Last week I set up a Vagrant box with Tomcat, MariaDB and a couple of Java web applications so that our testers could quickly get started on their own private instances. Being able to run locally, upgrade the applications and database when they like will be a real productivity win for us... I'm not saying anything about the efficiency of IT support ;-). 

If you're interested, I've created a GitHub repository for the Vagrant-Tomcat-MariaDB setup, which you can view [here](https://github.com/awolski/vagrant-tomcat7-mariadb).

One problem I had a bit of trouble with connecting to the MariaDB database on the VM using our regular MySQL client. We run on Windows here, so SSH is not available without installing another tool like PuTTy or similar. Typically when we create a connection it's using localhost, but becuase the VM is effectively another machine with its own IP address, and you're trying to connect over SSH, things get a bit tricky. It is possible though, and here's how:

### Forward the MySQL/MariaDB port

First, in your Vagrant script, forward the MySQL port to the host:

```
Vagrant.configure(2) do |config|
  ...
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  ...
end
```

###Configure MySQL to allow remote connections:

When your box is up and running, or in your provisioning scripts, configure MySQL/MariaDB on the VM to allow connections from remote machines (i.e. the host):

```
$ sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf
$ sudo service mysql restart`
```
###Configure the MySQL client to connect over SSH

When you're working locally (database and applications on your own machine), you'd normally configure a MySQL workbench connection using Standard TCP/IP. However when connecting to your VirtualBoxVM, you'll need to change the connection method and enter a few different parameters.

If you don't configure ssh in your Vagrant file explicitly, the defaults kick in when you first run `vagrant ssh` to login to the box (using CygWin or PuTTy), a private_key file is generated in .vagrant/default/virtualbox. You'll uses this as the SSH Key File in your connection settings, as outline below:

* **Connection Method**: Standard TCP/IP over SSH
* **SSH Hostname**: 127.0.0.1:2222
* **SSH Username**: vagrant
* **SSH Key File**: <path_to_vagrant_folder>/.vagrant/default/virtualbox/private_key
* **MySQL Hostname**: 127.0.0.1
* **MySQL Server Port**: 3306 (or whatever port you forwarded to)

![MySQL connection using TCP/IP over SSH](/assets/img/2015-05-12-vagrant-mysql-tcp-over-ssh.png)

Hopefully this helps someone out trying to connect to a MySQL based database inside a Vagrant VM.