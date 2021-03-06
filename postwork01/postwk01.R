# @Postwork: Sesi�n 1
# @Equipo: 14

repo.dir <- "C:/Users/luisf/Github/DS-Bedu-Equipo14-Postworks"
setwd(repo.dir)

# 1. Importa los datos de soccer de la temporada 2019/2020 
#    de la primera divisi�n de la liga espa�ola a R
df <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
names(df)
summary(df)

# 2. Etrae las columnas que contienen los n�meros de goles anotados por los 
#    equipos que jugaron en casa (FTHG) y los goles anotados por los equipos 
#    que jugaron como visitante (FTAG)

(FTHG <- df$FTHG)
(FTAG <- df$FTAG)

# 3. Estima las siguientes probabilidades:
# Tabla de contingencia FTGH x FTAG
(df.tbl <- table(FTHG, FTAG)) 
dim(df.tbl)

# N�mero total de observaciones
(totalObs <- sum(rowSums(df.tbl)))

# 3.1 Probabilidad marginal de que el equipo en casa anote x goles
(FTHG.marginal <- apply(df.tbl, 1, sum) /totalObs)

# 3.2 Probabilidad marginal de que el equipo visitante anote y goles
(FTAG.marginal <- apply(df.tbl, 2, sum) /totalObs)

# 3.3 Probabilidades conjuntas
(conjunta <- df.tbl / totalObs)

