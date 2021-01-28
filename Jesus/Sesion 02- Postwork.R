setwd("postwork2")
dir()
library(dplyr)
#Descargue los archivos csv 2017/2018, 2018/2019, 2019/2020 de la primera division española

sp1718 = "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
sp1819 = "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
sp1920 = "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = sp1718, destfile = "Spain1-1718.csv", mode = "wb")
download.file(url = sp1819, destfile = "Spain1-1819.csv", mode = "wb")
download.file(url = sp1920, destfile = "Spain1-1920.csv", mode = "wb")

#Importe los archivos descargados a R

lista <- lapply(dir(), read.csv)

#Obten una mejor idea de las características de los data frames al usar las funciones: str, head, View y summary

str(lista[1])
lapply(lista, head)
View(lista[1])
summary(lista[1])

#Con la función select del paquete dplyr selecciona únicamente las columnas:
#Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames

lista <- lapply(lista, select, Date, HomeTeam, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

#Asegúrate de que los elementos de las columnas correspondientes de los nuevos
#data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas).

lista <- lapply(lista, mutate, Date = as.Date(Date, "%d/%m/%y"))

#Con ayuda de la función rbind forma un único data frame que contenga las seis columnas
#mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).

data <- do.call(rbind, lista)
head(data)
dim(data)
View(data)
