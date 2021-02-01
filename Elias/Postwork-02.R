# 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a `R`, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

library(dplyr)
setwd(paste(getwd(),"Sesion-02/Data", sep='/'))

u1920 = "https://www.football-data.co.uk/mmz4281/920/SP1.csv"
u1819 = "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1718 = "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"

download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")


# lista <- list.files(pattern='^SP1')
lista <- c('SP1-1920.csv','SP1-1819.csv','SP1-1718.csv')

# leer archivos en SP 
lista <- lapply(lista, read.csv) # Guardamos los archivos en lista

# Explorar 
lapply(lista, head)
lapply(lista, str)
lapply(lista, View)
lapply(lista, summary)
lapply(lista,names)

# los elementos de lista son los archivos csv leidos y se encuentran
# como data frames
lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) # seleccionamos solo algunas columnas de cada data frame

lista <- lapply(lista, mutate,Date=as.Date(Date))

# cada uno de los data frames que tenemos en lista, los podemos combinar
# en un único data frame utilizando las funciones rbind y do.call
# de la siguiente manera

# Función do.call
data <- do.call(rbind, lista)
head(data)
dim(data)
str(data)




