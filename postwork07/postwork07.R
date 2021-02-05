
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

data <- read.csv("match.data.csv")
View(data)
con$insert(data)

# Conteo de registros en la base de datos

con$count(query = '{}')

# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el nÃºmero de goles que metiÃ³ el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugÃ³, Â¿perdiÃ³ Ã³ fue goleada?

partido <- con$aggregate(pipeline = 
'[
  {
    "$addFields": {
      "Contrincante": "$away_team",
      "Goles Anotados": "$home_score",
      "Won?": {
          "$gt": ["$home_score","$away_score"]
      },
      "Lost?": {
        "$gt": ["$away_score","$home_score"]
      },
      "Tied?": {
        "$eq": ["$away_score","$home_score"]
      }
    }
  },
  {
    "$match": {
      "$and": [
        {
          "home_team": "Real Madrid"
        },
        {
          "date": "2015-12-20" 
        }
      ]
    }
  },
  {
    "$project": {
      "_id": 0,
      "date": 0,
      "home_team": 0,
      "away_team": 0,
      "away_score": 0,
      "home_score": 0
    }
  }
]'
)
partido


con$disconnect()
