library(shiny)
library(shinydashboard)
library(shinythemes)
library(ggthemes)
library(ggplot2)

match.data <- read.csv("match.data.csv")

ui <- fluidPage(
    dashboardPage(
        dashboardHeader(title = "Basic dashboard"),
        skin = "green",
        
        dashboardSidebar(
            sidebarMenu(
                menuItem("Graficos de barras", tabName = "Dashboard", icon = icon("chart-bar")),
                menuItem("Imágenes de Postwork 3", tabName = "img", icon = icon("file-picture-o")),
                menuItem("Tabla de Datos", tabName = "data_table", icon = icon("table")),
                menuItem("Imágenes de Momios", tabName = "img2", icon = icon("file-picture-o"))
            )
        ),
        dashboardBody(
            tabItems(
                tabItem(tabName = "Dashboard",
                        fluidRow(
                            titlePanel("Grafico de barras de goles anotados"), 
                            selectInput("x", "Seleccione el valor de X",
                                        choices = c("home.score", "away.score")),
                            box(plotOutput("plot1", height = 600, width = 1000)),
                        )
                ),
                tabItem(tabName = "data_table",
                        fluidRow(        
                            titlePanel(h3("Data Table")),
                            dataTableOutput ("data_table")
                        )
                ), 
                tabItem(tabName = "img",
                        fluidRow(
                            titlePanel(h3("Imágen de postwork 3")),
                            img( src = "postwork3_FTAG.png", 
                                 height = 350, width = 350),
                            img( src = "postwork3_FTHG.png", 
                                 height = 350, width = 350),
                            img( src = "postwork3_Heatmap.png", 
                                 height = 350, width = 350)
                        )
                ),
                tabItem(tabName = "img2",
                        fluidRow(
                            titlePanel(h3("Imágen de momios.R")),
                            img( src = "plot1.png", 
                                 height = 350, width = 500),
                            img( src = "plot2.png", 
                                 height = 350, width = 500),
                        )
                )
                
            )
        )
    )
)

#De aquí en adelante es la parte que corresponde al server

server <- function(input, output) {
    
    #Gráfico de Histograma
    output$plot1 <- renderPlot({
        ggplot(match.data, aes(match.data[, input$x])) + 
            geom_bar() + 
            xlab(input$x) +
            ylab("Frecuencia") +
            facet_wrap( ~ away.team) + 
            theme(
                strip.background = element_rect( fill = "#EEFFEE", color = NA ),
                panel.background = element_rect( fill = "#FFFFFF", color = NA ),
                panel.grid.major.x = element_blank(),
                panel.grid.minor.x = element_blank(),
                panel.grid.minor.y = element_blank(),
                panel.grid.major.y = element_line( color = "#b2b2b2" )
            )
    })
    
    #Data Table
    output$data_table <- renderDataTable( {match.data}, 
                                          options = list(aLengthMenu = c(20,50, 100),
                                                         iDisplayLength = 20)
    )
    
}


shinyApp(ui, server)
