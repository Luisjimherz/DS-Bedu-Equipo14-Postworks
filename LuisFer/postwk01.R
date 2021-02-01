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
df.tbl

apply(df.tbl, 1, sum) /totalObs

# 3.2 (marginal vistante)
apply(df.tbl, 2, sum) /totalObs

# 3.3 Probabilidades conjuntas
df.tbl / totalObs










