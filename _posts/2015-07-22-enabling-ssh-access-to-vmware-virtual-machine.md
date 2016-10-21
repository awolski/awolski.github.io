---
layout: post
title:  "Enabling ssh access to VMWare virtual machine"
---

I'm in the process of creating a Vagrant box for a VMWare VM for a machine I'm working on, the end goal being fully automated development environment built so that new developers can get up and running quick-smart.

To start with, I need a Vagrant Base Box I can use as the foundation of the development environment. There is a set minimum requirements for VMWare base boxes, as indicated by Vagrant's documentation:

> Base boxes for VMware should have the following software installed, as a bare minimum:

> * SSH server with key-based authentication setup. If you want the box to work with default Vagrant settings, the SSH user must be set to accept the insecure keypair that ships with Vagrant.
* VMware Tools so that things such as shared folders can function. There are many other benefits to installing the tools, such as improved networking performance.

The VMWare Tools bit was easy, but this was the first time I'd attempted setting up a VM to allow ssh access, so I thought I'd document the process. 

First I created a new VM using CentOS 6.6 iso and made sure all the packages were up to date by running `yum update` and re-installing VMWare Tools.

CentOS already has an openssh-server installed, so all you have to do is add Vagrant's insecure public key to the ~/.ssh/authorized\_keys.  To do this, open your browser and copy the text in https://github.com/mitchellh/vagrant/blob/master/keys/vagrant.pub, and add it to ~/.ssh/authorized_keys.

![Vagrant insecure ssh public key](/assets/img/2015-07-22-vagrant-public-ssh-key.png)

To test an SSH connection from your host to the guest VM, locate the IP address of the guest. Running `ifconfig` will give you:

```
[user@localhost ~]$ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0C:29:2F:AD:F5  
          inet addr:192.168.220.143  Bcast:192.168.220.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fe2f:adf5/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:164689 errors:0 dropped:0 overruns:0 frame:0
          TX packets:65149 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:246264808 (234.8 MiB)  TX bytes:3547672 (3.3 MiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:480 (480.0 b)  TX bytes:480 (480.0 b)
```

The inet addr is the IP you're looking for, in this case `192.168.220.143`.

On your host machine, open a terminal and ssh into the guest machine:

```
awolski$ ssh user@192.168.220.143
The authenticity of host '192.168.220.143 (192.168.220.143)' can't be established.
RSA key fingerprint is 19:c1:19:f5:7f:e9:4b:38:74:26:ab:3f:24:f7:48:be.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.220.143' (RSA) to the list of known hosts.
user@192.168.220.143's password: 
[user@localhost ~]$ pwd
/home/user
```

That's it. My VMWare VM is ready to be packaged as a Vagrant Base box.