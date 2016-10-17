---
layout: post
title:  "AWS access control policies and IAM best practices"
permalink: aws-access-control-policies-and-iam-best-practices
---

I watched a couple of great videos today on AWS Identity and Access Management (IAM) best practices, and what's possible with access control policies. I thought I'd post a few of the key takeaways here in order to drum them home, and for future reference.

The videos I watched were [Mastering Access Control Policies (SEC302) | AWS re:Invent 2013](https://www.youtube.com/watch?t=33&v=Rkr5enrsMks):
<p><iframe width="560" height="315" src="https://www.youtube.com/embed/Rkr5enrsMks" frameborder="0" allowfullscreen></iframe></p>
  
and [AWS re:Invent 2014 | (SEC305) IAM Best Practices](https://www.youtube.com/watch?v=ZhvXW-ILyPs):
  
<p><iframe width="560" height="315" src="https://www.youtube.com/embed/ZhvXW-ILyPs" frameborder="0" allowfullscreen></iframe></p>
  
In the past I've been a relatively light user of Amazon Web Services (although that's changing as I'm porting my applications over to AWS from another PaaS, and I've just started working for a company that hosts their infrastructure in AWS). As such, my understanding of IAM, access policies, groups, roles, resources, actions etc. was... not basic... but certainly not advanced.

As my new role is going to be a lot more hands on in the AWS environment, I wanted to gain a deeper understanding of IAM and AWS security. Firstly of what's possible, and secondly, what are the best practices.

The two videos above are a great resource and have certainly given me a more in depth understanding of how to secure AWS resources, how to create policies, and how to apply those policies to users, groups, roles and resources. I'd certainly recommend them to anyone wanting to learn similar concepts.

Some things I picked up that I wasn't aware of:

* You can use [Policy Variables](http://docs.aws.amazon.com/IAM/latest/UserGuide/PolicyVariables.html) to allow access based on, for example, the current user (`${aws.username}`).
* You can configure federated access using OpenIDConnect, so when configured, you can login and access your AWS environment with, say, your Google account.

Here's a summary of IAM best practices pulled from the second video:

1. Users — Create individual users
2. Permissions — Grant least privilege
3. Groups — Manage permission with groups
4. Conditions — Restrict privileged access further with conditions
5. Auditing — Enable AWS CloudTrail to get logs of API calls
6. Passwords — Configure a strong password policy
7. Rotation — Rotate/Delete security credentials regularly
8. MFA — Enable MFA for privileged users
9. Sharing — Use IAM roles to share access
10. Roles — Use IAM roles for EC2 instances
11. Root — Reduce or remove use of root 

And just to ram it home... Never use your root account. **Ever**. No really, **never**.