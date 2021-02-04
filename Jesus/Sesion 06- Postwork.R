
setwd("~/Downloads/BEDU/postwork6/")
dir()

# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:

match.data <- read.csv("match.data.csv")
library(dplyr)
match.data <- mutate(match.data, date = as.Date(date))

# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.

match.data <- mutate(match.data, sumagoles = home.score + away.score)

# Obtén el promedio por mes de la suma de goles.

goles.mes <- match.data %>% group_by(año = format(date, "%Y"), mes = format(date, "%m")) %>% summarise(prom = round(mean(sumagoles), 2))
View(goles.mes)

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.

goles.mes.ts <- ts(goles.mes, frequency = 10, start = c(2011, 01), end = c(2019, 12))
View(goles.mes.ts)

#  Grafica la serie de tiempo.

plot(goles.mes.ts)
ts.plot(goles.mes.ts)
