# 1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
# install.packages("reshape2", dependencies=TRUE, INSTALL_opts = c('--no-lock'), dep=TRUE)
# install.packages("boot", dependencies=TRUE, INSTALL_opts = c('--no-lock'), dep=TRUE)
library(dplyr)
library(ggplot2)
library(reshape2)
library(boot)

# Importar dataset
SP11720 <- read.csv('./Sesion-04/Postwork/SP1-1720.csv',sep=',')

# Joint Prabability 
(JNSP <- table(SP11720$FTHG, SP11720$FTAG)/dim(SP11720)[1])
# Marginal Probability
(MP.HG <- table(SP11720$FTHG)/sum(table(SP11720$FTHG)))
(MP.AG <- table(SP11720$FTAG)/sum(table(SP11720$FTAG)))

# Outher product of marginal probability multiplication 
(MP.HGAG <- matrix(MP.HG,nrow=length(MP.HG),ncol=1)  %*% matrix(MP.AG,nrow=1,ncol=length(MP.AG)))
# Independency table where 1 means independency and 0 means dependency between FTHG and FTAH 
(INDT <- JNSP/MP.HGAG)


# dataframe of subset INDT(7X6) and values different from 0
subset1 <- INDT[1:7,1:6]
df1 <- as.data.frame(subset1) ; colnames(df1)<-c("FTHG","FTAH", "FRAC")
df2 <- df1[df1$FRAC!=0, ]

# HeatMap
ggplot(df2, aes(FTHG, FTAH, fill= FRAC)) + 
  geom_tile() +  geom_text(aes(label = round(FRAC, 2)))   +  ggtitle('Independency Table')
ggsave("./Sesion-04/Postwork/IndependencyT.png")

# Histogram 
df2 %>% ggplot() + aes(FRAC) + geom_histogram(binwidth = 0.25, col='black', fill = 'gray') +  ggtitle('Histograma de cocientes original') + ylab('Frecuencias') + xlab('Cocientes') + theme_light()
ggsave("./Sesion-04/Postwork/HistOrg.png")

#2 Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).

sample(df2$FRAC, replace=TRUE)

# Bootstrap Library 
library(boot)
# Fix Seed 
set.seed(100)
# function to obtain the median from the data
bmedian <- function(data, index) {
  d <- data[index, ] # allows boot to select sample
  return(median(d$FRAC))
}

# bootstrapping with 10000 replications
results <- boot(data=df2, statistic=bmedian,R=10000)

# view results
results
plot(results)

# get 95% confidence interval
interv <- boot.ci(results, type="bca")
interv

# Boostrap Histogram 
as.data.frame(results$t) %>% ggplot() + aes(V1) + geom_histogram(binwidth = 0.05, col='black', fill = 'gray') +  ggtitle('Histograma de cocientes boostrap') + ylab('Frecuencias') + xlab('Cocientes') + theme_light()
ggsave("./Sesion-04/Postwork/HistBoot.png")

