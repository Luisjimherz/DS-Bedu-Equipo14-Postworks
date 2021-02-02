football <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

library(dplyr)

goals <- select(football, FTHG, FTAG)

hteam <- table(goals$FTHG)/dim(goals)[1]*100
vteam <- table(goals$FTAG)/dim(goals)[1]*100

p.conjunta <- table(goals$FTHG,goals$FTAG)/dim(goals)[1]

sum(hteam.m %*% t(vteam.m) / 100)
