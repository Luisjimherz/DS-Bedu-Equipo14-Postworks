setwd("C:/Users/luisf/MEGA/Courses/DataScience/BEDU/Resources/DataSets/FootballESP")
df <- read.csv("postwork02.csv")
names(df)
View(df)

#1. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas entre
#el producto de las probabilidades marginales correspondientes.

#Creating a contingency table
df.tbl <- table(df$FTHG, df$FTAG) # contingency rows=FTHG cols=FTAG
df.tbl

#Total Observations
(totalObs <- sum(df.tbl))

# Joint probability for each pair of results
(jointP.tbl <- df.tbl / totalObs)

# Table of the product of marginal probabilities

(mp.FTHG <- rowSums(df.tbl) / totalObs) #Collection of marginal p for FTHG
(mp.FTAG <- colSums(df.tbl) /totalObs)  #Collection of marginal p for FTAG

(mat.FTHG <-matrix(mp.FTHG, nrow=9, ncol=7)) #Matrix of marginal p for FTHG
(mat.FTAG <-matrix(mp.FTAG, nrow=9, ncol=7, byrow = T)) #Matrix of marginal p for FTAG

(marginalP.product.tbl <- as.table(mat.FTHG *mat.FTAG))

#Table of the quotients 
(quotients.tbl <- jointP.tbl / marginalP.product.tbl)

#2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos 
#en la tabla del punto anterior. Esto para tener una idea de las distribuciones 
#de la cual vienen los cocientes en la tabla anterior. 
#Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla
#en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables 
#aleatorias X y Y).
library(reshape2)
quotients.df <- melt(quotients.tbl)
quotients.sample <- quotients.df$value
hist(quotients.sample)
