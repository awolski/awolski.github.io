---
layout: post
title:  "Accessing Stormpath Client when using shiro.ini"
---

I ran into a problem recently while trying to get access to the `com.stormpath.sdk.client.Client` instance when it is initialised by [Apache Shiro](http://shiro.apache.org/documentation.html)'s `shiro.ini` configuration. I couldn't find any help in the [Shiro](http://shiro.apache.org/webapp-tutorial.html) or [Stormpath](https://github.com/stormpath/stormpath-shiro/wiki) documentation.

Initially I was creating a separate instance of `com.stormpath.sdk.client.Client` in code, but I realised I was having to duplicate configuration by specifying `apiKeyFileLocation` and `cacheManager` config in both shiro.ini and in environment variables/context parameters.

In the end it was a simple task of looking into the Shiro and Stormpath source code to find out what is exactly happening...

One of the steps of configuring Shiro in a web application is to register a listener in your web.xml:

```xml
<listener>
  <listener-class>org.apache.shiro.web.env.EnvironmentLoaderListener</listener-class>
</listener>
```

In its `contextInitialized(ServletContextEvent sce)` method, it initialises the `org.apache.shiro.web.env.WebEnvironment` and stores it in a ServletContext for use throughout the application (by Shiro - it exposes the SecurityManager):

```java
...
WebEnvironment environment = createEnvironment(servletContext);
servletContext.setAttribute(ENVIRONMENT_ATTRIBUTE_KEY, environment);
...
```

Becuase we're using the `shiro.ini` configuration file, the implementation of WebEnvironment that gets created is the `org.apache.shiro.web.env.IniWebEnvironment`. Whilst debugging on startup, I noticed that in the in `IniWebEnvironment`'s `createWebSecurityManager()` method, the beans that are specified in, and loaded from, the `shiro.ini` file are stored in a `this.objects` field:

```java
protected WebSecurityManager createWebSecurityManager() {
  WebIniSecurityManagerFactory factory;
  Ini ini = getIni();
  ...
  Map<String, ?> beans = factory.getBeans();
  if (!CollectionUtils.isEmpty(beans)) {
    this.objects.putAll(beans); // BOOM!
  }
  return wsm;
}
```

Tracing this up the dependency heirarchy we find that `this.objects` is an instance of `Map<String, Object>` and has a public getter, so accessing the Stormpath Client instance created by Shiro is rather trivial:

```java
public class StormpathClientProducer {

  @Inject
  ServletContext servletContext;

  @Produces @Singleton
  public Client getStormpathClient() {
    DefaultEnvironment env = (DefaultEnvironment) servletContext.getAttribute(ENVIRONMENT_ATTRIBUTE_KEY);
    return env.getObject("stormpathClient", ClientFactory.class).getInstance();
  }
}
```
