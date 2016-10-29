dfMort <- read.csv("https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework/master/Data%20608/HW3/cleaned-cdc-mortality-1999-2010.csv")
#
#
library(pacman)
p_load(shiny, tidyverse, plotly, forcats, plotly)

dfMort <- dfMort %>%
          filter(Year.Code == 2010) %>%
          mutate(Crude.Rate = round(((Deaths/Population)*100000),1)) %>%
          select(State, ICD.Chapter, Crude.Rate) 
          
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlotly({
    
  dfMortSub <- dfMort %>% 
               filter(ICD.Chapter %in% input$conditions) %>%
               group_by(State) %>%
               summarise(Crude.Rate = sum(Crude.Rate)) %>%
               arrange(Crude.Rate) %>%
               mutate(State = factor(State,State))

               ggplot(data = dfMortSub, aes(y = Crude.Rate, x = State, color = Crude.Rate)) +
                      scale_color_distiller(palette = "YlOrRd") +
                      geom_bar(stat = "identity", width = .5) +
                      ylab("Rate (per 100000 people)") + 
                      coord_flip() + 
                      theme_minimal()
  })
  
  output$event <- renderPrint({
    d <- event_data("plotly_hover")
    })
  
})
