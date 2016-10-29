#
#
library(pacman)
p_load(shiny, tidyverse, plotly, forcats)

setwd(file.path("C:", "Users", "Christophe", "Documents", "GitHub", "MSDA - Coursework", "Data 608", "HW3"))

dfMort <- read.csv("cdc-mortality-1999-2010.csv") %>%
          filter(Year.Code == 2010) %>%
          mutate(Crude.Rate = round(((Deaths/Population)*100000),1)) %>%
          select(State, ICD.Chapter, Crude.Rate) 
          
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
  dfMortSub <- dfMort %>% 
               filter(ICD.Chapter %in% input$conditions) %>%
               group_by(State) %>%
               summarise(Crude.Rate = sum(Crude.Rate)) %>%
               arrange(Crude.Rate) %>%
               mutate(State = factor(State,State))

               ggplot(data = dfMortSub, aes(y = Crude.Rate, x = State, fill = Crude.Rate)) +
                      scale_fill_distiller(palette = "Spectral") + 
                      geom_bar(stat = "identity", width = .5) +
                      ylab("Rate (per 100000 people)") + 
                      coord_flip() + 
                      theme_minimal()
  })
  
})
