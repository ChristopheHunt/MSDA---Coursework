#
#

library(shiny)
library(tidyverse)
library(plotly)
library(forcats)

setwd(file.path("C:", "Users", "Christophe", "Documents", "GitHub", "MSDA - Coursework", "Data 608", "HW3"))

dfMort <- read.csv("cdc-mortality-1999-2010.csv") %>%
          filter(Year.Code == 2010) %>%
          mutate(Crude.Rate = round(((Deaths/Population)*100000),1)) %>%
          select(State, ICD.Chapter, Crude.Rate) 
          
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
  dfMortSub <- dfMort %>% 
               #filter(ICD.Chapter %in% input$conditions) %>%
               group_by(State) %>%
               summarise(Crude.Rate = sum(Crude.Rate)) %>%
               arrange(-Crude.Rate)
  
  dfMortSub$State <- lvls_reorder(unique(dfMortSub$State), seq(0:length(unique(dfMortSub$State))) )
  
  ggplot(data = dfMortSub, aes(y = Crude.Rate, x = State)) +
        geom_bar(stat = "identity") +
        coord_flip()
    
  })
  
})
