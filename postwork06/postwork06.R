# @Postwork: SesiÃ³n 6
# @Equipo:14

# Librerías
library(dplyr)

# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
setwd("postwork06")
match.data <- read.csv("match.data.csv")
match.data <- mutate(match.data, date = as.Date(date))

# 1. Agrega una nueva columna sumagoles que contenga la suma de goles por partido.

match.data <- mutate(match.data, sumagoles = home.score + away.score)
View(match.data)
# 2. ObtÃ©n el promedio por mes de la suma de goles.

goles.mes <- match.data %>% group_by(año = format(date, "%Y"), 
                                     mes = format(date, "%m")) %>% 
  summarise(prom = round(mean(sumagoles), 2))
View(goles.mes)

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
goles.mes.ts <- ts(goles.mes[goles.mes$año < 2020, ], 
                   frequency = 10, 
                   start = c(2010, 8), 
                   end = c(2019, 12))
View(goles.mes.ts)

#  Grafica la serie de tiempo.

plot(goles.mes.ts)
ts.plot(goles.mes.ts)
