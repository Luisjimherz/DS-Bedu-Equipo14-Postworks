# Establecemos el directorio de trabajo donde se encuentran los datos 
setwd(paste(getwd(),"/Sesion-01/Data", sep=''))

# Cargar datos   
equipos.list <- read.csv("SP1.csv")
equipos <- data.frame(equipos.list)

# Explorando los datos 
dim(equipos)
str(equipos)
summary(equipos)
# Saber el nombre de columnas
colnames(equipos)
names(equipos)

# Tablas de frecuencia relativas 
FTHG <- table(equipos$FTHG) 
FTAG <- table(equipos$FTAG) 
FTHGAG <- table(equipos$FTHG, equipos$FTAG)

# Información de referencia 
# http://sgpwe.izt.uam.mx/files/users/uami/gvar/Bioestad_I/pdf/prbayes_.pdf

# Estimar La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
res <- FTHG / sum(FTHG)
paste("La probabilidad marginal de que el equipo que juege en casa anote", c(1:6), "gole es:", res)

# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
res <- FTAG / sum(FTAG)
paste("La probabilidad marginal de que el equipo que juege en casa anote", c(1:6), "gole es:", res)


# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
res <- FTHGAG / sum(FTHGAG)  

# La probabilidad conjunta más elevada es que el juego termine 1 a 1 
which.max(res) 


