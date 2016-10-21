---
layout: post
title:  "Running Liquibase against an existing database, part 2"
---

It turns out integrating liquibase into an existing project/database is a lot easier than I originally thought...

Initially, I thought [changelogsync](http://www.liquibase.org/documentation/ant/changelogsync_ant_task.html) need to be executed against your database first, in order for the Liquibase tables to be created and have your database marked as in a 'from now on we're on Liquibase' state. And when I looked back over the [existing project documentation](http://www.liquibase.org/documentation/existing_project.html), I thought they had messed up the section 'We are going to use Liquibase starting... NOW!':

> Instead of building up a changeLog to match your existing database, you can instead just declare “from now on we are using Liquibase”. The advantage to this is that it much easier to set up because it is just a mandate. Usually this works best going from one version to the next because your databases are all in a reasonably consistent state and you simply start tracking database changes in your next version using Liquibase. Because Liquibase only looks at the DatabaseChangeLog table to determine what needs to run, it doesn’t care what else might be in your database and so it will leave all your existing tables alone and just run the new changeSets.

I thought "Hang on guys... You're missing a reference to to the changelogsync task... It'll fall over if you haven't run that first."

To verify my initial assumptions I deleted the `databasechangelog` and `databasechangeloglock` tables from a sandbox environment I'm using at work, and just started up my server (which uses the LiquibaseServletListener). To my surprise, Liquibase creates the tables on it's first run if they're not there... which makes sense really.

So there you go, no excuses for not automating your schema updates. One less step (unless you understood correctly from the get go).
