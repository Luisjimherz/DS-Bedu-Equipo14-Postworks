setwd("postwork3")
dir()
library(dplyr)

sp1718 = "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
sp1819 = "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
sp1920 = "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = sp1718, destfile = "Spain1-1718.csv", mode = "wb")
download.file(url = sp1819, destfile = "Spain1-1819.csv", mode = "wb")
download.file(url = sp1920, destfile = "Spain1-1920.csv", mode = "wb")

lista <- lapply(dir(), read.csv)

#Con la función select del paquete dplyr selecciona únicamente las columnas:
#Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames

lista <- lapply(lista, select, FTHG, FTAG)

#Con ayuda de la función rbind forma un único data frame que contenga las seis columnas
#mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).

data <- do.call(rbind, lista)

View(data)
#------------------------------------------------------------------------------

# Con el último data frame obtenido en el postwork de la sesión 2, elabora
# tablas de frecuencias relativas para estimar las siguientes probabilidades:

# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

anotados.casa <- data.frame(FTHG <- data$FTHG)
anotados.casa
(tabla.casa <- table(anotados.casa))
(prob.m.goles.casa <- data.frame(prop.table(tabla.casa)))
colnames(prob.m.goles.casa)[1] <- "Goles"
colnames(prob.m.goles.casa)[2] <- "Prob"
prob.m.goles.casa

# La probabilidad (marginal) de que el equipo que juega como visitante anote
# y goles (y=0,1,2,)

anotados.visita <- data.frame(FTAG <- data$FTAG)
(tabla.visita <- table(anotados.visita))
(prob.m.goles.visita <- data.frame(prop.table(tabla.visita)))
colnames(prob.m.goles.visita)[1] <- "Goles"
colnames(prob.m.goles.visita)[2] <- "Prob"
prob.m.goles.visita

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles
#y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

(anotados.global <- data.frame(FTHG <- data$FTHG, FTAG <- data$FTAG))
colnames(anotados.global)[1] <- "Casa"
colnames(anotados.global)[2] <- "Visita"
(tabla.global <- table(anotados.global)[1:7,])

(prob.c.goles.globales <- (prop.table(tabla.global)))
str(prob.c.goles.globales)

prob.c.goles.globales
# Realiza lo siguiente:

library(ggplot2)

# Un gráfico de barras para las probabilidades marginales estimadas del número
# de goles que anota el equipo de casa

ggplot(prob.m.goles.casa, aes(Goles, Prob)) +
  geom_bar(stat = "identity") + 
  ggtitle("Prob marginal del número de goles que anota el equipo de casa")

# Un gráfico de barras para las probabilidades marginales estimadas del número
# de goles que anota el equipo visitante.

ggplot(prob.m.goles.visita, aes(Goles, Prob)) +
  geom_bar(stat = "identity") + 
  ggtitle("Prob marginal del número de goles que anota el equipo visitante")

# Un HeatMap para las probabilidades conjuntas estimadas de los números de
#goles que anotan el equipo de casa y el equipo visitante en un partido.
library(reshape2)

melted.df <- melt(tabla.global)
str(melted.df)
melted.df$value <- melted.df$value / sum(tabla.global)


ggplot((melted.df)) +
  geom_tile(aes(x = Casa, y = Visita, fill = value)) +
  scale_fill_gradient(low="white", high="blue")


