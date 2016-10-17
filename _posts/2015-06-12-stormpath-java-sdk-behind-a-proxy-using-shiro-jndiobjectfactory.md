---
layout: post
title:  "Java Stormpath SDK behind a Proxy using Shiro JndiObjectFactory"
permalink: stormpath-java-sdk-behind-a-proxy-using-shiro-jndiobjectfactory
---

I needed to develop an application that used the Java Stormpath SDK from behind a corporate proxy. The SDK has a [Proxy](https://docs.stormpath.com/java/apidocs/index.html?com/stormpath/sdk/client/Proxy.html) class just for this purpose, but it doesn't conform to the [JavaBeans specification](http://www.oracle.com/technetwork/java/javase/documentation/spec-136004.html) (a good explanation of which can be found [here](http://stackoverflow.com/a/3295517/2309046)). The Proxy class has two constructors, both with arguments, and its fields are final. Because I'm using Apache Shiro and initialising the Stormpath client using a [shiro.ini configuration file](https://shiro.apache.org/configuration.html), I couldn't see a way to set the Proxy on the ClientBuilder where it was needed.

I'm not sure whether this design is intentional or not. Maybe the Proxy class was created without much thought about Shiro integration. Maybe I'm missing something. But I can't find any documentation about how to configure it without doing so in code.

I still needed a solution though...

Then I discovered Shiro's [JndiObjectFactory](http://shiro.apache.org/static/1.2.3/apidocs/org/apache/shiro/jndi/JndiObjectFactory.html), which allows you to look up objects in JNDI from your shiro.ini. Using the approach I'll explain below, I was able to use my system's already configured Java proxy settings - if they are configured - but not have to change any code if I continue develop the application in a non-proxy environment, like at home.

First, I created an implementation of `javax.naming.spi.ObjectFactory` that returns a ClientBuilder.

```
class ClientBuilderFactory implements ObjectFactory {

     @Override
     public Object getObjectInstance(Object obj, Name name, Context nameCtx, Hashtable<?, ?> environment) throws Exception {

          ClientBuilder builder = new DefaultClientBuilder()
     
          String proxyHost = System.getProperty('http.proxyHost')
          if (proxyHost != null) {
               int proxyPort = Integer.parseInt(System.getProperty('http.proxyPort'))
               String proxyUser = System.getProperty('http.proxyUser')
               String proxyPassword = System.getProperty('http.proxyPassword')

               Proxy proxy = new Proxy(proxyHost, proxyPort, proxyUser, proxyPassword)
               return builder.setProxy(proxy)
          }
          return builder;
     }
}
```

The default ClientBuilder used by the stormpath sdk is com.stormpath.sdk.impl.client.DefaultClientBuilder, so we don't reinvent the wheel there. Then we check for the `http.proxyHost` system property, which you typically set in JAVA_OPTS when you're developing applications that need to talk to the outside world from behind a proxy. If it's present, we create the Proxy object with the `http.proxyPort`, `http.proxyUser` and `http.proxyPassword`. Then set the proxy on the builder.

The beauty about this is that if there is no proxy argument set for the JVM, the ClientBuilder returned will be exactly the same as that which would have been created during shiro.ini initialisation.

Next, as per Tomcat's documentation on [adding custom resource factories](https://tomcat.apache.org/tomcat-7.0-doc/jndi-resources-howto.html#Adding_Custom_Resource_Factories), add the factory to your web application's `META-INF/context.xml`: 

```
<Resource name="ClientBuilder"
          auth="Container"
          type="com.stormpath.sdk.client.ClientBuilder"
          factory="com.awolski.accounts.stormpath.ClientBuilderFactory"
          singleton="true" />
```

Wire it up in your `web.xml`:

```
<resource-env-ref>
    <resource-env-ref-name>ClientBuilder</resource-env-ref-name>
    <resource-env-ref-type>com.stormpath.sdk.client.ClientBuilder</resource-env-ref-type>
</resource-env-ref>
```

And finally, using Shiro's JndiObjectFactory in our shiro.ini, we set the `stormpathClient`'s clientBuilder to the one we created using our factory: 

```
clientBuilder = org.apache.shiro.jndi.JndiObjectFactory
clientBuilder.resourceName = ClientBuilder
clientBuilder.resourceRef = true
...
stormpathClient = com.stormpath.shiro.client.ClientFactory
stormpathClient.clientBuilder = $clientBuilder
```

And that's it, you're Stormpath Client will execute its http requests using the proxy configured in your system. No need to add any other proxy settings to your application.