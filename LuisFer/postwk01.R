#@ Postwork: Session01
#@ Student: Luis Fernando Jimenez Hernandez

# 1. Importa el data set:
getwd()
setwd("C:/Users/luisf/MEGA/Courses/DataScience/BEDU/Module02/01_IntroductionR/Postwork")
df <- read.csv("SP1.csv")
View(df)
names(df)
str(df)
head(df)

#2. Extrae los goles de los equipos en casa y visitantes
cbind.data.frame(df$FTHG, df$FTAG)

# 3. Calculo de probabilidades
? table # create a contingency table
df.tbl <- table(df$FTHG, df$FTAG) # contingency table ixj FTGHxFTAG
df.tbl
? dim
dim(df.tbl)

? rowSums
totalObs <- sum(rowSums(df.tbl))


# 3.1 (marginal) de que el equipo en casa anote x goles
mingoals = min(df$FTHG)
maxgoals = max(df$FTHG)
homeMP <- data.frame(goals = mingoals:maxgoals, prob)
homeMP
for(g in mingoals:maxgoals){
  homeMP[g+1,2] = (sum(df.tbl[g+1, ])/totalObs)
}
homeMP
sum(homeMP[,2])


# 3.2 (marginal) de que el equipo visitant anote y goles
mingoals <- min(df$FTAG)
maxgoals <- max(df$FTAG)
visitMP <- data.frame(goals = mingoals:maxgoals, prob)
visitMP
for(g in mingoals:maxgoals){
  visitMP[g+1,2] <- (sum(df.tbl[g+1, ])/totalObs)
}
visitMP
sum(visitMP[,2])


# 3.3 (joint) casa anote x y visit y goles
minH = min(df$FTHG)
maxH = max(df$FTHG)
minV = min(df$FTAG)
maxV = max(df$FTAG)

jointP <- table(df$FTHG, df$FTAG)
jointP
for (row in 1 : (max(df$FTHG)+1)){
  for(col in 1 : (max(df$FTAG)+1)){
    jointP[row, col] = jointP[row, col] / totalObs
  }
}
jointP



