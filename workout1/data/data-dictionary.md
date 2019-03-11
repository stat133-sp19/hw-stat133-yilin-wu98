---
title: "data-dictionary"
author: "yilin-wu"
date: "March 8, 2019"
output: github_document
---
* team_name 
    + description: the name of NBA team 
    
    + type : character
    
    + value : GSW (stands for Golden State Warriors)

* game_data 
    + description: the exact date of the game in day,month and year
    
    + type : character
    
    + format : MM/DD/YY
    
    + value :
    
        + MM : 1,2,3,4,5,6,7,8,9,10,11,12
        
        + DD : 1,2,3,4,...,30,31
        
        + YY : 16 stands for 2016, 17 stands for 2017
        
* season
    + description: The season when the game happens
    
    + type: integer(numeric)
    
    + value : 2016 
    
* period
    + description: A game of basketball has 4 periods and each period has 12 minutes so the overall time of a game is 48 minutes if we don't count the time in timeout.
    
    + type: integer(numeric)
    
    + value : 1,2,3,4 
    
* minutes_remaining
    + description: each period has 12 minutes and minutes_remaining means the minutes left, therefore the remaining minutes is less than 12 minutes.
    
    + type: integer(numeric)
    
    + value: 0,1,2,3,4,5,6,7,8,9,10,11
    
* seconds_remaining
    + description: combines with the minutes_remaining, it has the exact time of how much time remains in the game. Because we have 60 seconds in a minute, so it is less than 60.
    
    + type : integer(numeric)
    
    + value: 0,1,2,3,4...,59,60
    
* shot_made_flag
    + description: it is a flag to indicate whether the shot is successfully made or not.
    
    + type: character
    
    + value: y( for yes) n( for no)
    
* action_type
    + description:the basketball moves used by players either to pass by defenders to gain access to the basket, or to get a clean pass to a teammate to score two pointer or three pointer.
    
    + type : character
    + value : "Jump Shot, Dunk Shot, Driving Dunk Shot" etc.
    
* shot_type
    + description: basketball shots has two types : 2-point shot and 3-point shot, determining how many points you get when you make that shot. The difference is decided by distance.
    + type: character
    
    + value : 2PT Field Goal( 2-point shot) 3PT Field Goal(3-point shot)
    
* shot_distance
    + description: distance to basket(measuerd in feet)
    
    + type: integer
    
    + value: 0,1,2,....,50
    
* opponent
    + description: a NBA team also in that game as the opponent of Golden state warriors.
    
    + type: character
    
    + value: 30 other NBA teams like "Orlando Magic"
    
* x
    + description: the court coordinate x where a shot occurs measured in inches
    
    + type: integer
    
    + value:-250-250
    
* y
    + description:the court coordinate y where a shot occurs measured in inches
    
    + type: integer
    
    + value: 0-500

            
Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
