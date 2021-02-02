# 1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
# install.packages("reshape2", dependencies=TRUE, INSTALL_opts = c('--no-lock'))
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
(MP.HGAG <- matrix(MP.HG,nrow=length(MP.HG),ncol=1)  %*%  matrix(MP.AG,nrow=1,ncol=length(MP.AG)))
# Independency table where 1 means independency and 0 means dependency between FTHG and FTAH 
(INDT <- JNSP/MP.HGAG)

# dataframe 
Sdf <- as.data.frame(INDT) ; colnames(Sdf)<-c("FTHG","FTAH", "COS")

# HeatMap
ggplot(Sdf, aes(FTHG, FTAH, fill= COS)) + 
  geom_tile() +  geom_text(aes(label = round(COS, 2)))   +  ggtitle('Independency Table')
ggsave("./Sesion-04/Postwork/IndependencyT.png")

# Quitamos cocientes que sean cero
Sdf <- Sdf[Sdf$COS!=0, ] 

# Histogram 
Sdf %>% ggplot() + aes(COS) + geom_histogram(binwidth = 0.25, col='black', fill = 'gray') +  ggtitle('Histograma de cocientes original') + ylab('Frecuencias') + xlab('Cocientes') + theme_light()
ggsave("./Sesion-04/Postwork/HistOrg.png")

#2 Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).

sample(Sdf$COS)


# Bootstrap 95% 
library(boot)

# function to obtain R-Squared from the data
rsq <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
}

# bootstrapping with 1000 replications
results <- boot(data=mtcars, statistic=rsq,
   R=1000, formula=mpg~wt+disp)


# view results
results
plot(results)

# get 95% confidence interval
boot.ci(results, type="bca")

