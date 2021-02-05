# @Postwork: Sesión 3
# @Equipo: 14 

# Librerías
library(dplyr)
library(ggplot2)

# 1. Con el ultimo df del postwork de la sesión 2 elabora las tablas de frecuencias
#    relativas para estimar las siguientes probabilidades:

setwd("postwork02")
df <- read.csv("postwork02.csv")

setwd("../postwork03")
FTHG <- df$FTHG ; FTAG <- df$FTAG
(df.tbl <- table(FTHG, FTAG))

# 1.1. Probabilidad marginal de que el equipo que juega en casa anote 
#      x goles (x=0,1,2)

(pm.FTHG <- table(FTHG)/sum(table(FTHG)))
paste("La probabilidad marginal de que el equipo que juega en casa anote:", 
      seq(0,8), "goles, es de:", pm.FTHG)
write.csv(pm.FTHG, file="../postwork03/postwk03_pm_FTHG.csv", row.names=TRUE)

# 1.2. Probabilidad marginal de que el equipo que juega como visitante 
#      anote y goles (y=0,1,2,)
(pm.FTAG <- table(FTAG)/sum(table(FTAG)))
paste("La probabilidad marginal de que el equipo que juega en casa anote:", 
      seq(0,6), "goles, es de:", pm.FTAG)
write.csv(pm.FTAG, file="../postwork03/postwk03_pm_FTAG.csv", row.names=TRUE)

# 1.3. Probabilidad conjunta de que el equipo que juega en casa anote x 
#      goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
(p.conjunta <- table(FTHG, FTAG)/sum(table(FTHG, FTAG)))
write.csv(p.conjunta, file="../postwork03/postwk03_pc.csv", row.names=TRUE)

#2. Realiza las siguientes graficas:
# 2.1. Grafico de barras para las probabilidades marginales estimadas del número de 
#      goles que anota el equipo en casa
(home <- as.data.frame(pm.FTHG))

home %>% ggplot() + aes(x = FTHG , y = Freq ) + 
  geom_bar(stat="identity", color='black')+  
  ggtitle('Probabilidad Marginal FTHG') + 
  ylab('Frecuencia relativa de goles') + xlab('Goles') + 
  theme_light() +  
  geom_text(aes(label=round(Freq,2)), vjust=-0.3, size=3.5) 
ggsave("postwk03_FTHG.png")

# 2.2. Grafico de barras para las probabilidades marginales estimadas del número de 
#      goles que anota el equipo visitante
(visitor <- as.data.frame(pm.FTAG))

visitor %>% ggplot() + aes(x = FTAG , y = Freq ) + 
  geom_bar(stat="identity", color='black')+  
  ggtitle('Probabilidad Marginal FTAG') + 
  ylab('Frecuencia relativa de goles') + 
  xlab('Goles') + 
  theme_light() +  
  geom_text(aes(label=round(Freq,2)), vjust=-0.3, size=3.5) 
ggsave("postwk03_FTAG.png")

# 2.3. Un HeatMap para las probabilidades conjuntas estimadas de los números de goles
#      que anotan el equipo visitante y el equipo de casa
hvsv <- as.data.frame(p.conjunta)

ggplot(hvsv, aes(FTHG, FTAG, fill= Freq)) + 
  geom_tile() +  geom_text(aes(label = round(Freq, 2))) + 
  ggtitle('Probabilidad conjunta')
ggsave("postwk03_Heatmap.png")

setwd("..")
