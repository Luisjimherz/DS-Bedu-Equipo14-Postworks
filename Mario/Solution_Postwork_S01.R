football <- read.csv("C:/Users/acer/Documents/TEC/KAUST Learning/BEDU/Modulo 2/Programacion-con-R-Santander-master/Sesion-01/Postwork/SP1.csv")

library(dplyr)

goals <- select(football, FTHG, FTAG)

# count(subset(goals, select = FTHG))

hteam <- table(goals$FTHG)/dim(goals)[1]*100
vteam <- table(goals$FTAG)/dim(goals)[1]*100

hteam.m <- as.matrix(hteam)
vteam.m <- as.matrix(vteam)

p.conjunta <- hteam.m %*% t(vteam.m) / 100

sum(hteam.m %*% t(vteam.m) / 100)
