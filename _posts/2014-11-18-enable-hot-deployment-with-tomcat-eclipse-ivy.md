---
layout: post
title:  "Enable hot-deployment with Tomcat + Eclipse + Ivy"
permalink: enable-hot-deployment-with-tomcat-eclipse-ivy
---

I occasionally forget how to configure Tomcat and Eclipse so that my code changes hot-swapped into the JVM when running a web application in debug... here's how:

1. *Open Window > Preferences > Ivy > Classpath Container*. Make sure '*Resolve dependencies in workspace*' is checked:

	![](/assets/img/2014-11-18-resolve-dependencies-in-workspace-1.png)

2. With your web application selected, select the *Project* menu and ensure '*Build automatically*' is checked:

	![](/assets/img/2014-11-18-build-automatically.png)

3. Open your Tomcat configuration (by double clicking on the server in the Servers tab), and under the *Server Options* menu, uncheck all values:

	![](/assets/img/2014-11-18-server-options.png)

4. On the same Tomcat configuration page, under the *Publishing* menu, select '*Automatically publish when resources change*':

	![](/assets/img/2014-11-18-automatically-publish-1.png)

5. Select the *Modules* tab at the bottom of the configuration page. Select your web application in the list and click the *Edit*... button.

	![](/assets/img/2014-11-18-edit-web-modules.png)

6. Finally, in the *Edit Web Module* pop-up, uncheck '*Auto reloading enabled*':

	![](/assets/img/2014-11-18-module-auto-reloading.png)

Now when you run your application/server in Debug mode, you will be able to edit method bodies in your Java classes (including dependent projects open in your workspace) and have the changes automatically available without needing to rebuild or restart your server.
