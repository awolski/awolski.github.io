---
layout: post
title:  "Power searching in JIRA"
date:   2012-11-26 21:33:34 +0000
permalink: power-searching-in-jira
---

I was promoted to Java Team Lead earlier this year, a role that comes with the responsibility of doing performance reviews biannually. In my first four months in the position I haven't really worked closely with my team at all; they're on completely different projects, and they are all just as busy as I am.

Without knowing a great deal about the work they've been doing over the last 4-5 months, I needed to generate some metrics to see how each of my team members has performed against their Individual Performance Objectives. I wasn't sure how I was going to do this, until I delved into the world [advanced searching in JIRA with JQL](https://confluence.atlassian.com/display/JIRA/Advanced+Searching) (Jira Query Language).

Our development team uses [JIRA](https://www.atlassian.com/software/jira) for issue management, so everyone's work on items is traced (to a degree - we could be using JIRA a lot better). With all most of our work data stored, it was just a matter of extracting the information I needed for the metrics I needed it for.

Simple search using all of the fields JIRA provides just wasn't cutting it. Searches only allowed me to view issues for the current assignee, or its current status. I needed to know whether issues were assigned to my team members *at some point* in the last 6 months, or if they had worked on an issue that had passed or failed a code review.

I'd been avoiding using advanced queries in JIRA; it just looked like another language to learn, and felt it would consume too much time to learn it. But I had to extract this data. So I took a deep breath, and dived in.

I wish I'd done so sooner. JQL is so easy to use, and so powerful, especially with auto-complete feature turned on.

Here are a couple of the measurements I needed, and the queries I used to (help) quantify them:

**Performance objective**: Perform an equal share of code reviews during each sprint.
**Quantified by**: Comparing the number of issues resolved, against the number of code reviews completed, and the individual's contribution to those code reviews.
**Solution**:

First, retrieve a list of all issues resolved (and therefore should be code reviewed) for the projects on which the individual worked:

`updated >= 2012-06-01 AND project IN ("Comma Separated", "List of", "Projects") AND (status was Resolved  OR status = Resolved) ORDER BY updated DESC`

Then, retrieve the issues for which the individual did code reviews:

`updated >= 2012-06-01 AND project IN ("Comma Separated", "List of", "Projects") AND (status was Resolved  OR status = Resolved) AND "Reviewer's Name" = <username> ORDER BY updated DESC`

As a supplement, retrieve how many were actually code reviewed:

`updated >= 2012-06-01 AND project IN ("Comma Separated", "List of", "Projects") AND (status was Resolved  OR status = Resolved) AND "Reviewer's Name" is not EMPTY ORDER BY updated DESC`

**Performance objective**: Complete all development tasks in accordance with our coding standards.
**Quantified by**: Issues the individual has worked on and their code review success/failure ratio.
**Solution**:

How many issues each of them has worked (resolved) on since their mid-year performance review:

`updated >= 2012-06-01 AND status CHANGED TO Resolved BY <username> ORDER BY updated DESC`

Then how many have been code reviewed:

`updated >= 2012-06-01 AND status CHANGED TO Resolved BY <username> AND status WAS "Code Reviewed" AND "Reviewer's Name" != <username> ORDER BY updated DESC`

Finally, how many have didn't pass code review:

`updated >= 2012-06-01 AND status CHANGED TO Resolved BY <username> AND status WAS "Code Reviewed" AND "Reviewer's Name" != <username> AND status CHANGED FROM "Code Reviewed" TO Reopened ORDER BY updated DESC`

Some of these queries aren't entirely accurate due to us not having consistent workflows throughout all of our projects, but they can be tweaked to slightly to get the results you're after.
