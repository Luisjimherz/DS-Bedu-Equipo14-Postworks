# 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a `R`, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

library(dplyr)
library(ggplot2)

# Directorio de trabajo
setwd(paste(getwd(),"Sesion-03/Data", sep='/'))

# Importar dataset
conf <- read.csv('SP1-1720.csv',sep=',')
Sconf <- mutate(conf,Date=as.Date(Date))

# Explorar 
names(Sconf)
str(Sconf)
head(Sconf)


# 1.A La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
(PMFTHG <- table(Sconf$FTHG)/sum(table(Sconf$FTHG)))
paste("La probabilidad marginal de que el equipo que juega en casa anote:",seq(0,8),"goles, es de:",PMFTHG)

# 1.B La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
(PMFTAG <- table(Sconf$FTAG)/sum(table(Sconf$FTAG)))
paste("La probabilidad marginal de que el equipo que juega en casa anote:",seq(0,6),"goles, es de:",PMFTAG)

# 1.C La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
(PMFTHAG <- table(Sconf$FTHG,Sconf$FTAG)/sum(table(Sconf$FTHG,Sconf$FTAG)))


# 2.A Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
(Stemp <- as.data.frame(PMFTHG))

Stemp %>% ggplot() + aes(x = Var1 , y = Freq ) + geom_bar(stat="identity", fill='white', color='black')+  ggtitle('Probabilidad Marginal FTHG') + ylab('PMFTHG') + xlab('Goles') + theme_light() +  geom_text(aes(label=round(Freq,2)), vjust=-0.3, size=3.5) 

ggsave("PMFTHG.png")

# 2.B Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
(Stemp <- as.data.frame(PMFTAG))

Stemp %>% ggplot() + aes(x = Var1 , y = Freq ) + geom_bar(stat="identity", fill='white', color='black')+  ggtitle('Probabilidad Marginal FTAG') + ylab('PMFTAG') + xlab('Goles') + theme_light() +  geom_text(aes(label=round(Freq,2)), vjust=-0.3, size=3.5) 

ggsave("PMFTAG.png")

# 2.C Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.

(Stemp <- as.data.frame(PMFTHAG))
colnames(Stemp)<-c("FTHG","FTAH", "Freq")

ggplot(Stemp, aes(FTHG, FTAH, fill= Freq)) + 
  geom_tile() +  geom_text(aes(label = round(Freq, 2)))   +  ggtitle('Probabilidad conjunta')

ggsave("HeatMap.png")
