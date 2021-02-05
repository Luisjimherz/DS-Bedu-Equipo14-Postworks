# @Postwork: Sesion 8
# @Equipo: 14

# Librerias
library(shiny)
library(shinydashboard)
library(shinythemes)

# Datos para graficas dinamicas
df <- read.csv("match.data.csv")
df$home.score <- as.numeric(df$home.score)
df$home.score <- as.numeric(df$home.score)
df.teams <- select(df, home.score, away.score)

# Interfaz grafica
ui <- 
  
  fluidPage(
    
    dashboardPage(
      
      dashboardHeader(title = "Pronósticos de La Liga Española de Soccer"),
      
      dashboardSidebar(
        
        sidebarMenu(
          menuItem("Goles", tabName = "gol", icon = icon("dashboard")), # Dashboard -> gol
          menuItem("Probabilidades", tabName = "pswk3", icon = icon("area-chart")), # graph -> pswk3
          menuItem("Tabla", tabName = "data_table", icon = icon("table")),
          menuItem("Momios", tabName = "mom", icon = icon("file-picture-o")) # img -> mom
        )
        
      ),
      
      dashboardBody(
        
        tabItems(
          
          # Histograma
          tabItem(tabName = "gol",
                  fluidRow(
                    titlePanel("Gráfica de barra de Goles"), 
                    selectInput("team", "Seleccione el equipo",
                                choices = names(df.teams)),
                    
                   box(plotOutput("plot1", height = 650)),
                    
                    box(
                      title = "Controls",
                      sliderInput("bins", "Number of observations:", 1, 30, 15)
                    )
                  )
          ),
          
          # Graficas del postwork 3
          tabItem(tabName = "pswk3", 
                  fluidRow(
                    titlePanel(h3("Gráficos de Probabilidades")),
                    
                    #selectInput("graph", "Selecciona la gráfica",
                     #s                    choices = c("postwk03_FTAG.png"))),
                    h4("Probabilidades Marginales"),
                    
                    img( src = "postwk03_FTHG.png", 
                         height = 250, width = 250),
                    
                    img( src = "postwk03_FTAG.png", 
                         height = 250, width = 250),
                    
                    h4("Probabilidade Conjunta"),
                    
                    img( src = "postwk03_Heatmap.png", 
                         height = 250, width = 250),
                    
                    #selectInput("a", "Selecciona la gráfica",
                       #         choices = names(mtcars)),
                    #selectInput("y", "Seleccione el valor de y",
                      #          choices = names(mtcars)),
                    #selectInput("z", "Selecciona la variable del grid", 
                     #           choices = c("cyl", "vs", "gear", "carb")),
                    #box(plotOutput("output_plot", height = 300, width = 460) )
                    
                  )
          ),
          
          
          # Tabla de marcadores
          tabItem(tabName = "data_table",
                  fluidRow(        
                    titlePanel(h3("Tabla de marcadores")),
                    dataTableOutput ("data_table")
                  )
          ), 
          
          # Momios
          tabItem(tabName = "mom",
                  fluidRow(
                    titlePanel(h3("Consulta los momios")),
                    
                    h4("Momios máximos"),
                    
                    img( src = "momios_max.png", 
                         height = 350, width = 350),
                    
                    h4("Momios promedio"),
                    
                    img( src = "momios_mean.png", 
                         height = 350, width = 350)
                  )
          )
          
        )
      )
    )
  )

#De aquí en adelante es la parte que corresponde al server

server <- function(input, output) {
  library(ggplot2)
  
  #Gráfico de Histograma
  output$plot1 <- renderPlot({
    
    x <- df[,input$team]
    y <- df.teams[, names(df.teams) != input$team] 
    bin <- seq(min(x), max(x), length.out = input$bins + 1)
    
    ggplot(df, aes(x)) + #, fill = df[,input$zz] 
      geom_histogram( breaks = bin) +
      labs( xlim = c(0, max(x))) + 
      theme_light() + 
      xlab(input$team) + ylab("Frecuencia") + 
      facet_grid(y)
    
    
  })
  
    #Data Table
    output$data_table <- renderDataTable( {df}, 
                                          options = list(aLengthMenu = c(5,25,50),
                                                         iDisplayLength = 5)
        )
   
}
    

shinyApp(ui, server)