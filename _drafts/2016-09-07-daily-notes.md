---
layout: post
title:  "Wednesday 7th September 2016"
date:   2016-09-07 13:12:00 +0000
permalink: 2016-09-07-daily-notes
---

I'm setting up a hosted instance of VistA.js using Amazon ECS. A lot of the grunt work has been done previously, I just had to look into why importing ssl client certificates without passwords weren't working.

Then I broke everything by changing the instance type. Which apparently [you're not allowed to do][cannot-change-instance-type]:

> Because each container instance has unique state information that is stored locally on the container instance and within Amazon ECS, you cannot stop a container instance and change its instance type. Instead, we recommend that you terminate the container instance and launch a new container instance with the desired instance size and the latest Amazon ECS-optimized AMI in your desired cluster.


```bash
#!/bin/bash
echo ECS_CLUSTER=vistajs-develop >> /etc/ecs/ecs.config
echo ECS_ENGINE_AUTH_TYPE=dockercfg
echo ECS_ENGINE_AUTH_DATA={"https://index.docker.io/v1/":{"auth":"blahblahblah","email":"anthony.wolski@somedomain.com"}}
```

According to the documentation it's not good practice to put auth data in instance user data, but rather load it from s3 using an IAM role.

[cannot-change-instance-type]: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_instances.html
