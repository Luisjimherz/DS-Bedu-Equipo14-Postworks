# @Postwork: Sesión 5
# @Equipo: 14

# Librerías
library(dplyr)
library(fbRanks)

# 1. A partir del conjunto de datos de soccer de la liga española crea 
#    el data frame SmallData, que contenga las columnas date, home.team, 
#    home.score, away.team y away.score; esto lo puedes hacer con ayuda de la 
#    función select del paquete dplyr. Luego crea un directorio de trabajo y 
#    con ayuda de la función write.csv guarde el data frame como un archivo csv 
#    con nombre soccer.csv. Puedes colocar como argumento row.names = FALSE 
#    en write.csv. 
setwd("postwork02")
SmallData <- select(read.csv("postwork02.csv"), Date, HomeTeam, FTHG, AwayTeam, FTAG)
colnames(SmallData) <- c("date", "home.team", "home.score", "away.team", "away.score")
head(SmallData)
setwd("../postwork05")
write.csv(SmallData, file="soccer.csv", row.names=F)

# 2. Con la función create.fbRanks.dataframes del paquete fbRanks importa el 
#    archivo soccer.csv a R y al mismo tiempo asignarlo a una variable llamada 
#    listasoccer. Se creará una lista con los elementos scores y teams que son 
#    data frames listos para la función rank.teams. Asigna estos data frames 
#    a variables llamadas anotaciones y equipos. 

lista.soccer <- create.fbRanks.dataframes("soccer.csv")
anotaciones <- lista.soccer$scores
equipos <- lista.soccer$teams

# 3. Con ayuda de la función unique crea un vector de fechas (fecha) que no 
#    se repitan y que correspondan a las fechas en las que se jugaron partidos. 
#    Crea una variable llamada n que contenga el número de fechas diferentes. 
#    Posteriormente, con la función rank.teams y usando como argumentos los 
#    data frames anotaciones y equipos, crea un ranking de equipos usando 
#    únicamente datos desde la fecha inicial y hasta la penúltima fecha en la 
#    que se jugaron partidos, estas fechas las deberá especificar en max.date 
#    y min.date. Guarda los resultados con el nombre ranking. 
fechas <- unique(as.Date(anotaciones$date))
n <- length(fechas)
ranking <- rank.teams(scores=anotaciones, teams=equipos, 
                      min.date=fechas[1] , 
                      max.date=fechas[n-1])

# 4. Finalmente estima las probabilidades de los eventos, el equipo de casa 
#    gana, el equipo visitante gana o el resultado es un empate para los partidos
#    que se jugaron en la última fecha del vector de fechas fecha. Esto lo 
#    puedes hacer con ayuda de la función predict y usando como argumentos ranking
#    y fecha[n] que deberá especificar en date.
predict(ranking, min.date=fechas[n], max.date=fechas[n])

setwd("..")
