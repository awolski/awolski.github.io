---
layout: post
title:  "The things you discover... httpie and jq"
---

Sometimes working with technology you feel so far behind the eight ball. Like, how do you **not** know about some of the awesome tools out there that *could* have made your life so much easier before now. This week I was introduced to two such tools, [httpie](https://github.com/jkbrzt/httpie) and [jq](https://stedolan.github.io/jq/). I just know that the combination of these two command line apps are going to come in real handy.

### httpie

From the homepage:

> **httpie** is a command line HTTP client. Its goal is to make CLI interaction with web services as human-friendly as possible. It provides a simple http command that allows for sending arbitrary HTTP requests using a simple and natural syntax, and displays colorized output. HTTPie can be used for testing, debugging, and generally interacting with HTTP servers.

I'm currently evaluating [Vault](https://www.vaultproject.io/) by Hashicorp, working my way through the getting started guide. I wanted to test out the [http api](https://www.vaultproject.io/docs/http/) instead of using the command line client. The examples show you can execute a curl command like this to write a secret to vault:

```
$ curl \
    -H "X-Vault-Token: f3b09679-3001-009d-2b80-9c306ab81aa6" \
    -H "Content-Type: application/json" \
    -X POST \
    -d '{"value":"bar"}' \
    http://127.0.0.1:8200/v1/secret/baz
```
With http installed that turns into...
```
$ http --json POST http://127.0.0.1:8200/v1/secret/baz \
    X-Vault-Token:6bf59568-6530-588b-3928-1918f7dc781a \
    value=bar
```
So much easier! No more curl for me. There's a great [httpie cheatsheet](http://ricostacruz.com/cheatsheets/httpie.html) for quick reference, as I found it difficult making switch and not having to enter options for headers and the like.

### jq

From the homepage:

 > jq is a lightweight and flexible command-line JSON processor.

Continuing with the same getting started guide, let's use httpie to pull out the secret we just wrote:

```
$ http GET http://127.0.0.1:8200/v1/secret/baz \
    X-Vault-Token:6bf59568-6530-588b-3928-1918f7dc781a
HTTP/1.1 200 OK
Content-Length: 110
Content-Type: application/json
Date: Sat, 16 Jan 2016 21:33:06 GMT

{
    "auth": null,
    "data": {
        "value": "bar"
    },
    "lease_duration": 2592000,
    "lease_id": "",
    "renewable": false,
    "warnings": null
}
```
So what can we do with jq? Well, what if we just want to read the value of the secret we just stored? jq makes that really easy:
```
$ vault read -format=json secret/baz | jq -r .data.value
bar
```
Awesome! jq is a tool I think I'm going to be using a lot, especially in conjunction with httpie. Just check out what's possible on the [tutorial](https://stedolan.github.io/jq/tutorial/) page.