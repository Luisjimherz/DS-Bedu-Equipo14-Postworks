# @Postwork: Sesión 3
# @Equipo: 14 

# 1. Con el ultimo df del postwork de la sesión 2 elabora las tablas de frecuencias
# relativas para estimar las siguientes probabilidades:

setwd("postwork02")
df <- read.csv("postwork02.csv")
names(df)
View(df)
setwd("../postwork03")
(FTHG <- df$FTHG)
(FTAG <- df$FTAG)
(df.tbl <- table(FTHG, FTAG))

#Total Observations
(totalObs <- sum(df.tbl))

# 1.1. Probabilidad (marginal) de que el equipo que juega en casa anote 
#      x goles (x=0,1,2)
(f.FTHG012 <- rowSums(df.tbl[1:3,]))
(fr.FTHG.012 <- f.FTHG012/totalObs)
     
# 1.2. Probabilidad (marginal) de que el equipo que juega como visitante 
#      anote y goles (y=0,1,2,)
f.FTAG012 <- colSums(df.tbl[ ,1:3])
(fr.FTAHG012 <- f.FTAG012/totalObs)

# 1.3. Probabilidad (conjunta) de que el equipo que juega en casa anote x 
#      goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
(f.joint <- df.tbl[1:3,1:3])
(fr.joint <- f.joint/totalObs)

#2. Realiza las siguientes graficas:
library(ggplot2)
# 2.1. Grafico de barras para las probabilidades marginales estimadas del número de 
#      goles que anota el equipo en casa

(home <- cbind.data.frame(Goals=0:8, Probability=rowSums(df.tbl)/totalObs))

ggplot(home, aes(Goals, Probability))+
  geom_bar(stat="identity") +
  ggtitle("Probability for Home team") +
  ylab("Goals") +
  xlab("Marginal estimated probability") + 
  theme_light()
ggsave("postworw03FTHG.png")

# 2.2. Grafico de barras para las probabilidades marginales estimadas del número de 
#      goles que anota el equipo visitante
(visitor <- cbind.data.frame(Goals=0:6, Probability=colSums(df.tbl)/totalObs))

ggplot(visitor, aes(Goals, Probability))+
  geom_bar(stat="identity") +
  ggtitle("Probability for Home team") +
  ylab("Goals") +
  xlab("Marginal estimated probability") + 
  theme_light()
ggsave("postworw03FTAG.png")


# 3.3. Un HeatMap para las probabilidades conjuntas estimadas de los números de goles
#      que anotan el equipo visitante y el equipo de casa
library(reshape2)
(hvsv <- melt(df.tbl))
(hvsv$value <- hvsv$value/totalObs)

ggplot(hvsv, aes(FTHG, FTAG))+
  geom_tile(aes(fill=value)) +
  ggtitle("Probability for game results") +
  ylab("Visitor") +
  xlab("Home")

ggsave("postworw03joint.png")
