# @Postwork: Sesión 4
# @Equipo: 14 

# Librerías
#install.packages('boot',dep=TRUE)
library(boot)
library(reshape2)
library(ggplot2)

# 1. Obtén una tabla de cocientes al dividir las probabilidades conjuntas entre
#    el producto de las probabilidades marginales correspondientes.
setwd("postwork03")
p.conjunta <- read.table("postwk03_pc.csv", sep=",", header=T)
p.conjunta <- pc[-1]
rownames(pc) <- 0:8 ; colnames(pc) <- 0:6

# Table of the product of marginal probabilities
pm.FTHG <- read.table("postwk03_pm_FTHG.csv", sep=",", header=T)
pm.FTHG <- pm.FTHG[-1]
pm.FTAG <- read.table("postwk03_pm_FTAG.csv", sep=",", header=T)
pm.FTAG <- pm.FTAG[-1]

?table

mp.product <- matrix(pm.FTHG$Freq, nrow=length(pm.FTHG$Freq), ncol=1) %*% 
  matrix(pm.FTHG$Freq, nrow=1, ncol=length(pm.FTAG$Freq))

# Tabla de cocientes p
quotients.tbl <- p.conjunta / mp.product
hist(quotients.tbl)

# 2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos 
#    en la tabla del punto anterior. Esto para tener una idea de las distribuciones 
#    de la cual vienen los cocientes en la tabla anterior. 
#    Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla
#    en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables 
#    aleatorias X y Y).
setwd("../postwork04")

(quotients.df <- melt(quotients.tbl[0:6,0:5]))  

ggplot(quotients.df, aes(value)) +
  geom_histogram(binwidth=0.25) +
  ggtitle("Histograma de cocientes") +
  ylab("Frecuencia") +
  xlab("") + 
  theme_light()
ggsave("histograma_original.png")

(original.sample <- quotients.df$value)

# Manual method
#bootstrap.median <- c()
#for(i in 1:100000){
#  resample <- sample(original.sample, size=length(original.sample), replace=T)
#  bootstrap.median <- cbind(bootstrap.median, median(resample))
#}
#hist(bootstrap.median)

# boot library
set.seed(89)

qmed <- function(data, indices){
  dt <- data[indices]
  return(median(dt))
}

btp <- boot(original.sample, statistic=qmed, R=1000000)
btp
head(as.data.frame(btp$t))
plot(btp)
boot.ci(btp)

ggplot(as.data.frame(btp$t), aes(V1)) +
  geom_histogram(binwidth=0.03) +
  ggtitle("Histograma de cocientes") +
  ylab("Frecuencia") +
  xlab("") + 
  theme_light()
ggsave("histograma_bootstrap.png")

setwd("..")
