---
layout: post
title:  "Installing Liquibase Extensions"
---

Since version 3.1, support for 'less common' databases has been removed from the core Liquibase distribution. This is documented Liquibase's supported databases page. I'm working with a DB2i database, so I needed to work out how to install the [liquibase-db2i](https://github.com/liquibase/liquibase-db2i) extension. I couldn't find any documentation anywhere, but I managed to nut out what was in the end a relatively trivial task...

Executing generateChangeLog via the command line looks something like this:

```bash
liquibase --driver=com.ibm.as400.access.AS400JDBCDriver \
  --classpath=jt400.jar \
--changeLogFile=file-to-export-to.xml \
--url="jdbc:as400://AS400X;libraries=LIBRARY;trace=false;naming=sql;extended dynamic=true;" \
--username=blah --password=***** --logLevel=debug \
--databaseClass=liquibase.ext.db2i.database.DB2iDatabase generateChangeLog
```

But the DB2iDatabase class is not in the core distribution any more, and without the liquibase-db2i extension installed, I got a ClassNotFoundException:

```bash
Liquibase generateChangeLog Failed: liquibase.exception.DatabaseException: java.lang.ClassNotFoundException: liquibase.ext.db2i.database.DB2iDatabase
```

In order to install the db2i-extension, all that was required was to:

1. Clone the repository from Github.
2. Build the Maven project.
3. Copy the liquibase-db2i*.jar to $LIQUIBASE_HOME



```bash
$ git clone https://github.com/liquibase/liquibase-db2i.git
$ cd liquibase-db2i
$ mvn clean install
$ cp target/liquibase-db2i-1.0-SNAPSHOT.jar $LIQUIBASE_HOME/lib/
```

Any jars you add to `$LIQUIBASE_HOME/lib` folder are added to liquibase's classpath, so the next run of the same generateChangeLog command above worked fine (well, at least got me past the ClassNotFoundException ;-).

Hope this helps if you're wondering how to install any other liquibase extensions.
