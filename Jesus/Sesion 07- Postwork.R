
# install.packages("mongolite")
# setwd("~/Downloads/BEDU/postwork7/")
# dir()
library(mongolite)

con <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://adminBEDU:1701@bedu.3qryh.mongodb.net/match?retryWrites=true&w=majority",
  verbose = FALSE,
  options = ssl_options()
)

data <- read.csv("data.csv")
View(data)
con$insert(data)

con$count(query = '{}')

# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

partido <- con$aggregate(pipeline = 
'[
  {
    "$addFields": {
      "Contrincante": "$AwayTeam",
      "Goles Anotados": "$FTHG",
      "Gano": {
        "$regexMatch": {
          "input": "$FTR",
          "regex": "H"
        }
      },
      "Perdio": {
        "$regexMatch": {
          "input": "$FTR",
          "regex": "A"
        }
      },
      "Empato": {
        "$regexMatch": {
          "input": "$FTR",
          "regex": "D"
        }
      }
    }
  },
  {
    "$match": {
      "$and": [
        {
          "HomeTeam": "Real Madrid"
        },
        {
          "Date": "2017-08-27"
        }
      ]
    }
  },
  {
    "$project": {
      "_id": 0,
      "X": 0,
      "HomeTeam": 0,
      "AwayTeam": 0,
      "FTHG": 0,
      "FTAG": 0,
      "FTR": 0
    }
  }
]'
)
partido


con$disconnect()
