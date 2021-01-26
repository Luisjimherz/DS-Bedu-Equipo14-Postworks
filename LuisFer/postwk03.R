#@Bedu
#@Postwork: Session 03
#@author : Luis Fernando Jimenez
#@team : 14 

# 1. Con el ultimo df del postwork de la sesión 2 elabora las tablas de frecuencias
# relativas para estimar las siguientes probabilidades:

#Importing the object
setwd("C:/Users/luisf/MEGA/Courses/DataScience/BEDU/Resources/DataSets/FootballESP")
df <- read.csv("postwork02.csv")
names(df)
View(df)

#Creating a contingency table
?table
df.tbl <- table(df$FTHG, df$FTAG) # contingency rows=FTHG cols=FTAG
df.tbl

#Total Observations
(totalObs <- sum(df.tbl))

#a) Marginal P(c)
f.FTHG012 <- sum(df.tbl[1:3,])
(p.FTHG012 <- f.FTHG012/totalObs) # Result
     
#b) Marginal P(0<=FTAH<2)
f.FTAG012 <- sum(df.tbl[ ,1:3])
(p.FTAHG012 <- f.FTHG012/totalObs) # Result

#c) Joint P(0<=FTHG<2 ^ 0<=FTHG<2)
f.joint <- sum(df.tbl[1:3,1:3])
(p.joint <- f.joint/totalObs)

#2. Realiza las siguientes graficas:
library(ggplot2)
#a) Grafico de barras para las probabilidades marginales estimadas del número de 
#goles que anota el equipo en casa

(home <- cbind.data.frame(Goals=0:8, Probability=rowSums(df.tbl)/totalObs))

ggplot(home, aes(Goals, Probability))+
  geom_bar(stat="identity") +
  ggtitle("Probability for Home team") +
  ylab("Goals") +
  xlab("Marginal estimated probability") + 
  theme_light()
ggsave("postworw03FTHG.png")

#b) Grafico de barras para las probabilidades marginales estimadas del número de 
#goles que anota el equipo visitante
(visitor <- cbind.data.frame(Goals=0:6, Probability=colSums(df.tbl)/totalObs))

ggplot(visitor, aes(Goals, Probability))+
  geom_bar(stat="identity") +
  ggtitle("Probability for Home team") +
  ylab("Goals") +
  xlab("Marginal estimated probability") + 
  theme_light()
ggsave("postworw03FTAG.png")


#c)Un HeatMap para las probabilidades conjuntas estimadas de los números de goles
# que anotan el equipo visitante y el equipo de casa
library(reshape2)
(hvsv <- melt(df.tbl))
(hvsv$value <- hvsv$value/totalObs)

ggplot(hvsv, aes(Var1, Var2))+
  geom_tile(aes(fill=value)) +
  ggtitle("Probability for game results") +
  ylab("Visitor") +
  xlab("Home")

ggsave("postworw03joint.png")
