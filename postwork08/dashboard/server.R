# @Postwork: Sesion 8
# @Equipo: 14

# Librerias
library(shiny)
library(dplyr)
library(stringr)

# Datos para graficas dinamicas
df <- read.csv("match.data.csv")
df$home.score <- as.numeric(df$home.score)

shinyServer(function(input, output) {
   
   output$output_text <- renderText(paste("Goles", input$x))
   
   #Gráficas  
   output$output_plot <- renderPlot({ggplot(df, aes(home.score)) + geom_bar() + })
   
   #imprimiendo el summary                                  
   output$summary <- renderPrint({
      mtcars %>%  filter(str_detect(rownames(mtcars), 'Mer') & mpg >20 )
   })
   
   # Agregando el dataframe
   output$table <- renderTable({ 
     data.frame(mtcars)
   })
   
   #Agregando el data table
   output$data_table <- renderDataTable({mtcars}, 
                                        options = list(aLengthMenu = c(5,25,50),
                                                       iDisplayLength = 5))
   
   
})