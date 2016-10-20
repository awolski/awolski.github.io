---
layout: post
title:  "Problems building a CentOS AWS AMI with Packer"
permalink: building-an-aws-ami-with-packer
---

I'm in the early stages of working with (awesome) tools like Packer and [Terraform](https://www.terraform.io/) and I ran into a few issues whilst trying to create a base image that mirrors the production environment we're deploying to. I wanted to document them here to a) engrain what I'm learning and b) document the solutions for future reference.

When getting started with any new technology it's good to work your way through the getting started guide, which is what I did on this occasion. I copied the `example.json` example from Packer's [getting started guide](https://www.packer.io/intro/getting-started/build-image.html) and changed the instance type from `t1.micro` to `t2.micro` and the ami to an `eu-west-1` CentOS 6 ami. So here is what I started with:

```json
{
  "variables": {
  "aws_access_key": "",
  "aws_secret_key": ""
},
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "eu-west-1",
    "source_ami": "ami-30ff5c47",
    "instance_type": "t2.micro",
    "ssh_username": "root",
    "ami_name": "CentOS 6 x86_64",
    "associate_public_ip_address": true
  }]
}
```

Running 
```
packer validate example.json
```

worked without error, so I continued with
```
packer build example.json
```

And I hit an error...

### Problem: Not specifying subnet_id when using non-default VPC

<pre>
<span style='color:red;'>==> amazon-ebs: Error launching source instance: InvalidParameterCombination: VPC security groups may not be used for a non-VPC launch</span>
</pre>

The error on this one through me a little bit as it points to something awry with security groups. But the real issue solution is to do with the switching to a t2.micro instance and not specifying a `vpc_ic` and `subnet_id`. From the [T2 Instances documentation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/t2-instances.html):

> You must launch your T2 instances into a virtual private cloud (VPC); they are not supported on the EC2-Classic platform.

So I added a `vpc_id` and `subnet_id` to the template:
```
  ...
  "vpc_id": "vpc-62086907",
  "subnet_id": "subnet-01451564",
  ...
```

Running `packer build` now didn't hit this issue, but seemed to take an eternity when trying to connect via SSH...

### Problem: Timeout waiting for SSH.

```bash
amazon-ebs output will be in this color.
amazon-ebs: Prevalidating AMI Name...
amazon-ebs: Inspecting the source AMI...
...
amazon-ebs: Waiting for instance (i-cfbf6363) to become ready...
amazon-ebs: Waiting for SSH to become available...
amazon-ebs: Timeout waiting for SSH.
...
amazon-ebs: Terminating the source AWS instance...
```

This is when I discovered that when launching an ec2 instance into a non-default subnet the instance is not assigned a public IP. This is explained in AWS' [Default VPC and Subnet documentation](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/default-vpc.html):

> Instances that you launch into a default subnet receive both a public IP address and a private IP address. Instances in a default subnet also receive both public and private DNS hostnames. Instances that you launch into a nondefault subnet in a default VPC don't receive a public IP address or a DNS hostname. You can change your subnet's default public IP addressing behavior. For more information, see Modifying Your Subnet's Public IP Addressing Behavior.

So I dug a little deeper into Packer's [aws-ebs backed documentation](https://www.packer.io/docs/builders/amazon-ebs.html) and discovered the way to fix this is to add the `associate_public_ip_address` (`true`) attribute:

```
  "associate_public_ip_address": true
```

So the final (working) packer template is listed below (changes I've made from the example in the documentation are highlighted):

```json
{
  "variables": {
  "aws_access_key": "",
  "aws_secret_key": ""
},
  "builders": [{
  "type": "amazon-ebs",
  "access_key": "{{user `aws_access_key`}}",
  "secret_key": "{{user `aws_secret_key`}}",
  "region": "eu-west-1",
  "source_ami": "<b>ami-30ff5c47",
  "instance_type": "<b>t2.micro",
  "ssh_username": "root",
  "ami_name": "CentOS 6 x86_64",
  "vpc_id": "vpc-62086907",
  "subnet_id": "subnet-01451564",
  "associate_public_ip_address": true
}]
```