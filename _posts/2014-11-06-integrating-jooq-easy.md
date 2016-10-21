---
layout: post
title:  "Integrating JOOQ... easy"
---

Integrating [JOOQ](http://www.jooq.org/) into your application is a [piece of piss](http://www.urbandictionary.com/define.php?term=piece%20of%20piss), as I discovered recently when I needed to build some non-ORM/Hibernate database access into some reports. I'm upgrading the reports component of an application I develop and needed to add some *performant* metrics. I didn't want to use direct SQL or JDBC, so I decided to see how JOOQ performed... and I was pleasantly surprised at how simple it was to set up and use.

First, add the dependency. I'm not using code generation so I only needed the core library.

```xml
<dependency>
  <groupId>org.jooq</groupId>
  <artifactId>jooq</artifactId>
  <version>3.4.4</version>
</dependency>
```

This particular application uses [CDI/Weld](http://weld.cdi-spec.org/) as its dependency injection framework, so I created a [Producer method](https://docs.jboss.org/weld/reference/1.0.0/en-US/html/producermethods.html) which produces a JOOQ DSLContext using the DataSource injected via JNDI using the @Resource annotation:

```java
	...
  import org.jooq.DSLContext;
  import org.jooq.SQLDialect;
  import org.jooq.impl.DSL;

  @SuppressWarnings("serial")
  public class DSLContextProducer implements Serializable {

      @Resource(mappedName="java:comp/env/jdbc/dataSourceName")
  private DataSource ds;

  @Produces
  public DSLContext getDSLContext() throws SQLException {
  	return DSL.using(ds.getConnection(), SQLDialect.MYSQL);
  }
}
```

This makes the JOOQ DSLContext easy to access throughout the application by simply injecting it wherever it is needed:

```java
@Inject DSLContext jooq;
```

And get busy using:

```java
...
Field<?> AVG = DSL.field("avg(metric)").as("Average Some Metric");
Field<?> YEAR = DSL.field("EXTRACT(YEAR FROM createdDateTime)").as("Year");
Field<?> MONTH = DSL.field("EXTRACT(MONTH FROM createdDateTime)").as("Month");
...
jooq.select(AVG, YEAR, MONTH)
  .from("TABLE")
  .groupBy(MONTH, YEAR)
  .orderBy(YEAR.desc(), MONTH.desc())
  .fetch());
```

There's a lot more to learn, but with [fantastic documentation](http://www.jooq.org/learn/), I have no doubt JOOQ will become one of my go to Java database tools.
