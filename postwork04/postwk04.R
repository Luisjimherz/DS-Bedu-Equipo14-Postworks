# @Postwork: Sesión 4
# @Equipo: 14 


setwd("postwork02")
df <- read.csv("postwork02.csv")
names(df)
View(df)

# 1. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas entre
#    el producto de las probabilidades marginales correspondientes.

FTHG <- df$FTHG
FTAG <- df$FTAG
(df.tbl <- table(FTHG, FTAG)) # Tabla de frecuencias

(totalObs <- sum(df.tbl)) # Observaciones totales

(p.conjunta <- df.tbl / totalObs) # Tabla de frecuencias relativas

# Table of the product of marginal probabilities

(pm.FTHG <- rowSums(df.tbl) / totalObs) # Probabilidades marginales FTHG
(pm.FTAG <- colSums(df.tbl) /totalObs)  # Probabilidades marginales FTAG

(FTHG.mat <-matrix(pm.FTHG, nrow=9, ncol=7)) # Matriz de probabilidades marginales
(FTAG.mat <-matrix(pm.FTAG, nrow=9, ncol=7, byrow = T)) #Matrix of marginal p for FTAG

(mp.product <- as.table(FTHG.mat * FTAG.mat)) # Tabla contingencia del producto de probabilidades marginales

# Tabla de cocientes p
(quotients.tbl <- p.conjunta / mp.product)

# 2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos 
#    en la tabla del punto anterior. Esto para tener una idea de las distribuciones 
#    de la cual vienen los cocientes en la tabla anterior. 
#    Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla
#    en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables 
#    aleatorias X y Y).
setwd("../postwork04")
library(reshape2)
library(ggplot2)
quotients.tbl[1:5, 1:6]
(quotients.df <- melt(quotients.tbl[1:5, 1:6]))  
(quotients.df <- quotients.df[quotients.df$value != 0,]) # omitiendo valores con ceros

ggplot(quotients.df, aes(value)) +
  geom_histogram(binwidth=0.2) +
  ggtitle("Histograma de cocientes") +
  ylab("Frecuencia") +
  xlab("") + 
  theme_light()
ggsave("histograma.png")

(original.sample <- quotients.df$value)
original.sample <- as.data.frame(original.sample)


#(resample <- sample(original.sample, length(original.sample), replace=T))
#(resample <- data.frame(quotients=resample))

#ggplot(resample, aes(quotients)) +
#  geom_histogram(binwidth=0.2) +
#  ggtitle("Histograma de cocientes") +
#  ylab("Frecuencia") +
#  xlab("") + 
#  theme_light()
#ggsave("histograma_B2.png")

#install.packages('boot',dep=TRUE)
library(boot)
set.seed(89)

qmed <- function(data, indices){
  dt <- data[indices, ]
  return(median(dt))
}
bootstrap <- boot(original.sample, statistic=qmed, R=1000)
head(as.data.frame(bootstrap$t))
bootstrap
summary(bootstrap)
boot.ci(bootstrap, index=1)
plot(bootstrap)
ggplot(as.data.frame(bootstrap$t), aes(V1)) +
  geom_histogram(binwidth=0.009) +
  ggtitle("Histograma de cocientes") +
  ylab("Frecuencia") +
  xlab("") + 
  theme_light()
