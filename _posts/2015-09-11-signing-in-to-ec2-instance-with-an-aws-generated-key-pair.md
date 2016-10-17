---
layout: post
title:  "Signing in to EC2 instance with an AWS generated key pair"
permalink: signing-in-to-ec2-instance-with-an-aws-generated-key-pair
---

Today I hit an issue signing in to an new ec2 instance using a private key I generated and downloaded on AWS. 

```
ssh -i ~/.aws/mykey.pem <ip_address>
```

I was getting this error:

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0640 for '/Users/awolski/.aws/mykey.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
bad permissions: ignore key: /Users/awolski/.aws/my-key.pem
```

I thought changing to `0600` would sort the issue out, but it made no difference whatsoever. A quick Google search brought up [this](http://stackoverflow.com/a/10822056) answer on Stack Overflow. Apparently it's outlined in the AWS documentation:

> Your key file must not be publicly viewable for SSH to work. Use this command if needed: chmod 400 mykey.pem

I should have known better. Also a little note to self: make sure you use the right user... Ubuntu images use `ubuntu`:

```
ssh -i ~/.aws/mykey.pem -l ubuntu <ip_address>
```
