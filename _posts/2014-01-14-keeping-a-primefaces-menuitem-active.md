---
layout: post
title:  "Keeping a Primefaces MenuItem active"
---

In an application I'm currently writing using Primefaces, I'm using a menu and individual menuItems to navigate to different pages. I wanted to keep the menuItem representing the current page to remain selected. For example, if the current page was /admin/users.xhtml, I wanted something like this:

![](/assets/img/2014-01-14-primefaces-menu-active.png)

After a little digging I found a neat little solution which only involved modifying the .xhtml file:

```xhtml
<p:menu style="width:90%;">
  <p:submenu label="Admin">
    <p:menuitem value="Users" outcome="users.xhtml" styleClass="#{view.viewId == '/admin/users.xhtml' ? 'ui-state-active' : ''}" />
    <p:menuitem value="Groups" outcome="groups.xhtml" styleClass="#{view.viewId == '/admin/groups.xhtml' ? 'ui-state-active' : ''}" />
  </p:submenu>
</p:menu>
```  

Hope this helps anyone looking for a similar solution.
