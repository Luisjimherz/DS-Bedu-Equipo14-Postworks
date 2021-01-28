library(dplyr)

#Importa los datos de soccer de la temporada 2019/2020 de la primera division de la liga espanola a R, los datos los puedes encontrar en el siguiente enlace

datos <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
datos

#Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

goles.anotados <- data.frame(FTHG <- datos$FTHG, FTAG <- datos$FTAG)
goles.anotados

#Consulta cómo funciona la función table en R al ejecutar en la consola ?table

tabla.frec.abs <- table(goles.anotados)
tabla.frec.abs

#Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
  #La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)

prob.mar.fthg <- apply(prop.table(tabla.frec.abs), 1, sum)
prob.mar.fthg #Probabilidad de que el equipo local anote X goles

  #La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)

prob.mar.ftag <- apply(prop.table(tabla.frec.abs), 2, sum)
prob.mar.ftag #Probabilidad de que el equipo visitante anote X goles

  #La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)

prob.con <- prop.table(tabla.frec.abs)
prob.con #Probabilidades de que cada equipo anote X y Y goles
