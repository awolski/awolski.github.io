---
layout: post
title:  "Failing aws cli on Docker container with old date time"
date:   2016-07-25 21:46:34 +0100
permalink: failing-aws-cli-on-docker-container-with-old-date-time
---
Today I hit an issue which completely stumped me (for a while). Running an `aws s3 cp` from a Docker container — that had *never* failed before in the same scenario — was failing every time with '`A client error (403) occurred when calling the HeadObject operation: Forbidden`'. When run from my Mac directly with the same `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` it worked. **WTF!**

Some Googling lead me to [this][stackoverflow-iam-role] question, which contained [this answer][stackoverflow-awscli-time] of particular interest:

> "can also be caused if your system clock is too far off. I was 12 hours in the past and got this error. Set the clock to within a minute of the true time, and error went away."

So I checked the time of the container by running `date` an sure enough, the container's date was 3 days ago:

```bash
$ date
Fri Jul 29 15:18:17 UTC 2016
```

I was a bit perplexed how the container — or Docker — got in such a state, because I'd never had an issue like this before. I found [this answer][stackoverflow-docker-time-drift] which indicated that when using boot2docker the Docker Engine VM's time can drift when OS X is asleep:

> "Time synch becomes an issue because the boot2docker host has its time drift while your OS is asleep."

I'd recently updated to [Docker for Mac][docker-for-mac], so maybe that had something to do with it? To correct the issue, I initially tried to set the container's date, before I learned you [can't do that][stackoverflow-docker-set-time] without using `--privileged`. Doing so can cause bad things to happen:

> "Using the --privileged switch here will cause the command from the container to affect the docker host. Also other bad things can happen if you use the --privileged without knowing the effects."

So I thought the quickest way to see if things would resolve themselves would be to restart my machine (something I don't do often enough). Sure enough, after a restart running the same image produced the correct date and time:

```
$ date
Mon Aug  1 15:18:17 UTC 2016
```

But I wasn't happy with just getting things working again; I wanted to know what the issue was with the aws cli when your system date/time isn't correct. So I dug a little deeper into the [AWS Command Line Interface User Guide][aws-cli-user-guide] and found the answer on page 10:

> The AWS CLI signs requests on your behalf, and includes a date in the signature. Ensure that your computer's date and time are set correctly; if not, the date in the signature may not match the date of the request, and AWS rejects the request.

And there you have it. A mistake not to be made again in the future.

[aws-cli-user-guide]: http://docs.aws.amazon.com/cli/latest/userguide/aws-cli.pdf
[stackoverflow-iam-role]: https://stackoverflow.com/questions/22262906
[stackoverflow-awscli-time]: http://stackoverflow.com/a/28488143/2309046
[stackoverflow-docker-set-time]: http://stackoverflow.com/questions/29556879
[stackoverflow-docker-time-drift]: http://stackoverflow.com/a/26454059
[docker-for-mac]: https://docs.docker.com/docker-for-mac/
