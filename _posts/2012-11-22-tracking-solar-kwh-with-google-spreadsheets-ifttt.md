---
layout: post
title:  "Tracking solar kWh with Google Spreadsheets & IFTTT"
date:   2012-11-22 21:46:34 +0100
permalink: tracking-solar-kwh-with-google-spreadsheets-ifttt
---

About a month ago we had solar panels installed. Sixteen panels in total, thirteen split over two sections of the roof and five on the garage, totalling a 4kW system. I hadn't considered solar when we bought the house, but fortunately we have south-east and south-west facing sides of the house, and after a little research, solar turned out to be the best investment with the money available to invest.

I check the meter every now and again to see how many kWhs we're producing. I've been surprised by the output on some days, and a little disappointed on others. One glorious October day we almost hit 16kWh. However on the frequent cloudy days here in the UK we're barely able produce 1 or 2kWh. Two days ago I thought the system had stopped altogether.

![Solar Panels]({{ site.url }}/assets/img/2012-11-22-solar-panels.jpg)

I decided it would be valuable to have a record of how the system is performing. In particular, to compare what we're producing against the forecasts in the proposal given to us before the system was installed. Currently I don't think it's performing as well as I'd hoped. I would like to get a better idea of whether that is due to the weather or the system.

So  in order to track the solar generation, I set up a Google Spreadsheet where I'll record the meter reading each day. But in order to help with the weather side of things, I set up an IFTTT recipe to record some of the day's weather details. Each morning at sunrise, IFTTT appends a row to the spreadsheet with the date, time of sunrise, forecast minimum and maximum temperature for the day, and the current condition.

This setup should give me a good starting point for keeping track of how the system performs in certain weather conditions. The weather details I'm gathering aren't exactly what I am after, but you've got to start somewhere.

This is my first IFTTT recipe; let's see if it inspires me to more interesting uses.
