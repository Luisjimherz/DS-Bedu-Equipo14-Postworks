# @Postwork: Sesion 8
# @Equipo: 14

# Librerias
library(class)
library(dplyr)
library(stringr)
library(shiny)
library(shinydashboard)

# Datos para graficas dinamicas
df <- read.csv("match.data.csv")
df.names <- select(df, home.score, away.score)

shinyUI(
    pageWithSidebar(
        headerPanel("Aplicacion básica con Shiny"),
        sidebarPanel(
            p("Crear plots con el DF 'auto'"), 
            selectInput("x", "Seleccione el valor de X",
                        choices = names(df.names))
        ),
        mainPanel(
    # Tabs
    tabsetPanel(
        # Goals(bar) tab
        tabPanel("Goles",   
                 h1(textOutput("output_text")), 
                 plotOutput("output_plot"), 
        ),
        
        # Postwork 3 tab 
        # todo: Add two more images
        tabPanel("postwork03",  
               img( src = "postwk03_Heatmap.png", 
                     height = 450, width = 450)
        ), 
        
        # match.data.csv tab
        tabPanel("Table", tableOutput("table"))
    )
)
)

)

