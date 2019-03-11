##################################################
## title: shots-data
## description:add name and minute to five Gsw players shots data and combine them into a whole csv and make summaries
## inputs:andre-iguodala.csv, draymond-green.csv, kevin-durant.csv, klay-thompson.csv, stephen-curry.csv
## outputs:shots-data.csv, shots-data-summary.txt, andre-iguodala-summary.txt,draymond-green-summary.txt, kevin-durant-summary.txt, klay-thompson-summary.txt, stephen-curry-summary.txt 
##################################################
rm(list=ls())
setwd("./Desktop/berkeley education/stat133/workouts/workout01/code")
iguodala <- read.csv("../data/andre-iguodala.csv",stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv",stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv",stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv",stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv",stringsAsFactors = FALSE)

iguodala$name = "Andre Iguodala"
curry$name = "Stephen Curry"
green$name = "Draymond Green"
durant$name = "Kevin Durant"
thompson$name = "Klay Thompson"

gsw_players <- rbind(iguodala,green,durant,thompson,curry)
gsw_players[gsw_players$shot_made_flag=='y',]$shot_made_flag <- "shot_yes"
gsw_players[gsw_players$shot_made_flag=='n',]$shot_made_flag <- "shot_no"

# iguodala[iguodala$shot_made_flag=="y",]$shot_made_flag <- "shot_yes"
# iguodala[iguodala$shot_made_flag=="n",]$shot_made_flag <- "shot_no"
# green[green$shot_made_flag=="y",]$shot_made_flag <- "shot_yes"
# green[green$shot_made_flag=="n",]$shot_made_flag <- "shot_no"
# durant[durant$shot_made_flag=="y",]$shot_made_flag <- "shot_yes"
# durant[durant$shot_made_flag=="n",]$shot_made_flag <- "shot_no"
# thompson[thompson$shot_made_flag=="y",]$shot_made_flag <- "shot_yes"
# thompson[thompson$shot_made_flag=="n",]$shot_made_flag <- "shot_no"
# curry[curry$shot_made_flag=="y",]$shot_made_flag <- "shot_yes"
# curry[curry$shot_made_flag=="n",]$shot_made_flag <- "shot_no"
gsw_players$minute <- gsw_players$period * 12 - gsw_players$minutes_remaining 

iguodala <- gsw_players[gsw_players$name=='Andre Iguodala',]
green <- gsw_players[gsw_players$name=='Draymond Green',]
durant <- gsw_players[gsw_players$name=='Kevin Durant',]
thompson <- gsw_players[gsw_players$name=='Klay Thompson',]
curry <- gsw_players[gsw_players$name=='Stephen Curry',]
sink(file="../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()
sink(file="../output/draymond-green-summary.txt")
summary(green)
sink()
sink(file="../output/kevin-durant-summary.txt")
summary(durant)
sink()
sink(file="../output/klay-thompson-summary.txt")
summary(thompson)
sink()
sink(file="../output/stephen-curry-summary.txt")
summary(curry)
sink()
write.csv(gsw_players,file="../data/shots-data.csv")
sink(file="../output/shots-data-summary.txt")
summary(gsw_players)
sink()
