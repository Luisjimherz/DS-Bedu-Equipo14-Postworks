f_19_20 <- read.csv("SP1.csv")
f_18_19 <- read.csv("SP2.csv")
f_17_18 <- read.csv("SP3.csv")

library(dplyr)

f_19_20 <- f_19_20 %>% select(Date, HomeTeam:FTR)
f_18_19 <- f_18_19 %>% select(Date, HomeTeam:FTR)
f_17_18 <- f_17_18 %>% select(Date, HomeTeam:FTR)
f_19_20 <- mutate(f_19_20, Date = as.Date(Date, "%d/%m/%Y"))
f_18_19 <- mutate(f_18_19, Date = as.Date(Date, "%d/%m/%Y"))
f_17_18 <- mutate(f_17_18, Date = as.Date(Date, "%d/%m/%Y"))
all <- rbind(f_19_20,f_18_19,f_17_18)

