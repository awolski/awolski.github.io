---
layout: page
title: Books
permalink: /books/
---

{% for item in site.books %}
  <img style="float: left; margin-right: 2em; margin-top: 10px;" src="/assets/img/{{ item.id }}.jpg">
  <h3>{{ item.title }}</h3>
  <p>{{ item.excerpt }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}
