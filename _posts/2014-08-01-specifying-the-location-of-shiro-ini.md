---
layout: post
title:  "Specifying the location of shiro.ini"
date:   2014-08-01 17:54:00 +0100
permalink: specifying-the-location-of-shiro-ini
---

I've been working on switching the identity and security management libraries in one of my applications from [Seam Security/PicketLink IDM](http://docs.jboss.org/seam/3/security/latest/reference/en-US/html/security-identitymanagement.html) to [Shiro](http://shiro.apache.org/) backed by [Stormpath](https://stormpath.com/). Shiro and Stormpath are really quite easy to set up, and there are some [good guides](https://github.com/stormpath/stormpath-shiro/wiki) out there to help you get up and running. For me, everything was going really well in my local development environment, but when I finally pushed these changes to my hosting provider, [Jelastic](http://jelastic.com/), I hit an issue...

As per Stormpath's API key instructions, I  placed my apiKey.properties file in my `user.home` home directory on my development machine:

> "... This will generate your API Key and download it to your computer as an apiKey.properties file. If you open the file in a text editor, you will see something similar to the following:

 	apiKey.id = 144JVZINOF5EBNCMG9EXAMPLE
 	apiKey.secret = lWxOiKqKPNwJmSldbiSkEbkNjgh2uRSNAb+AEXAMPLE

> "... Save this file in a secure location, such as your home directory, in a hidden `.stormpath` directory. For example:

```bash
$ mkdir ~/.stormpath
$ mv ~/Downloads/apiKey.properties ~/.stormpath/
```

Then, in your `shiro.ini` file you specify the location of `apiKey.properties`:

```
stormpathClient.apiKeyFileLocation = /Users/awolski/.stormpath/apiKey.properties
```

But `/Users/awolski/.stormpath` doesn't exist in Jelastic (obviously), so specifying a hard-coded location in your `WEB-INF/shiro.ini` won't work when you need to port your application to another environment.


### Environment specific shiro.ini


The default location Shiro looks for your \*.ini file is `"/WEB-INF/shiro.ini"`, however I discovered you could override this location by using `shiroConfigLocations` context parameter, as explained here:

> "The shiroConfigLocations context-param, if it exists, allows you to specify the config location(s) (resource path(s)) that will be relayed to the instantiated WebEnvironment..."

You could put this in your web.xml, but because my configuration will be environment specific, I put the parameter in Tomcat's context.xml:

```xml
<Parameter name="shiroConfigLocations" value="file:/opt/tomcat/temp/shiro.ini" override="false"/>`
```

Then your environment specific shiro configuration can point to a different location for your Stormpath apiKey.properties:

```
stormpathClient.apiKeyFileLocation = /opt/tomcat/temp/.stormpath/apiKey.properties`
```

My experience with Shiro, and in particular Stormpath, has been really positive so far. The API is well documented and solves a lot of user management problems straight out of the box with just a little configuration. I especially LOVE Stormpath's [customData](https://stormpath.com/blog/custom-user-data-stormpath-now-beta/), which I can foresee covering all of my identity management needs going forward.

Check them out, you won't be disappointed!
