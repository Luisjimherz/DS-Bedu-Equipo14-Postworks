# @Postwork: Sesión 2
# @Equipo: 14

# Librerías
library(dplyr)

# 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 
#    y 2019/2020 de la primera división de la liga española a R
setwd("postwork02")

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = url1, destfile = "soccerESP2017.csv", mode = "wb")
download.file(url = url2, destfile = "soccerESP2018.csv", mode = "wb")
download.file(url = url3, destfile = "soccerESP2019.csv", mode = "wb")

lista <- lapply(dir(), read.csv)

#2. Obten una mejor idea de las características de los data frames 
#al usar las funciones: str, head, View y summary

lapply(lista, summary)
str(lista[[1]])
View(lista[[1]])

# 3. Con la función select del paquete dplyr selecciona únicamente 
#las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; 
#esto para cada uno de los data frames. (Hint: también puedes usar lapply).

lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
lapply(lista, names)

# 4. Asegúrate de que los elementos de las columnas correspondientes 
#de los nuevos data frames sean del mismo tipo 
#(Hint 1: usa as.Date y mutate para arreglar las fechas).
#Con ayuda de la función rbind forma un único data frame que contenga 
#las seis columnas mencionadas en el punto 3 
#(Hint 2: la función do.call podría ser utilizada).

?as.Date
lista <- lapply(lista, mutate, Date = as.Date(Date, format="%d/%m/%y"))

df <- do.call(rbind, lista)
head(df)
str(df)
View(df)

write.csv(df, "postwork02.csv")












