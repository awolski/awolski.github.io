---
layout: post
title:  "Creating a database and namespace in Intersystems Caché using expect"
---

```
# ccontrol start CACHE                                                                                                                                                                                                                              
Starting CACHE
using 'cache.cpf' configuration file

Automatically configuring buffers
Allocated 335MB shared memory: 249MB global buffers, 24MB routine buffers
Creating a WIJ file to hold 31 megabytes of data
This copy of Cache has been licensed for use exclusively by:
VA VHA CBO Kiosk Program
Copyright (c) 1986-2015 by InterSystems Corporation
Any other use is a violation of your license agreement

1 alert(s) during startup. See cconsole.log for details.

[root@c8018cbd7924 /]# csession CACHE <ENTER>

Node: c8018cbd7924, Instance: CACHE <ENTER>

USER>d ^%MGDIR <ENTER>
You're in namespace %SYS
Default directory is /opt/cache/mgr/
%SYS>d ^DATABASE <ENTER>


 1) Create a database
 2) Edit a database
 3) List databases
 4) Delete a database
 5) Mount a database
 6) Dismount a database
 7) Compact globals in a database
 8) Show free space for a database
 9) Show details for a database
10) Recreate a database
11) Manage database encryption
12) Return unused space for a database
13) Compact freespace in a database
14) Defragment globals in a database

Option? 1 <ENTER>
Database directory? /opt/cache/mgr/vistajs <ENTER>
Directory does not exist, create it? No => Yes <ENTER>
Change default database properties? No => <ENTER>
Dataset name of this database in the configuration: VISTAJS <ENTER>
Mount VISTAJS Required At Startup? No => Yes <ENTER>
Confirm creation of database in /opt/cache/mgr/vistajs/? Yes => <ENTER>
Formatting...
Database in /opt/cache/mgr/vistajs/ created
Dataset VISTAJS added to the current configuration.
Database directory? <ENTER>

 1) Create a database
 2) Edit a database
 3) List databases
 4) Delete a database
 5) Mount a database
 6) Dismount a database
 7) Compact globals in a database
 8) Show free space for a database
 9) Show details for a database
10) Recreate a database
11) Manage database encryption
12) Return unused space for a database
13) Compact freespace in a database
14) Defragment globals in a database

Option?
%SYS>s Name="VISTAJS" <ENTER>

%SYS>s Properties("Globals")="VISTAJS" <ENTER>

%SYS>s Status=##Class(Config.Namespaces).Create(Name,.Properties)
```

Once the database and namespace are created, we need to create the the global and routine mappings. To do this we can simply add a Map section in cache.cpf file and restart Caché:

```
[Map.VISTAJS]
Global_%Z*=VISTAJ
Routine_%DT*=VISTAJS
Routine_%RCR=VISTAJS
Routine_%XU*=VISTAJS
Routine_%ZIS*=VISTAJS
Routine_%ZO*=VISTAJS
Routine_%ZT*=VISTAJS
Routine_%ZV*=VISTAJS
```

Appending this to the end of cache.cpf is fine; Caché will move it to the correct section upon restart.
