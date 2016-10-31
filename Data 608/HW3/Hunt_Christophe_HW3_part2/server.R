dfMort <- read.csv("https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework/master/Data%20608/HW3/cleaned-cdc-mortality-1999-2010.csv")
#
#
library(pacman)
p_load(shiny, tidyverse, plotly, forcats, plotly, scales)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    dfUs <- dfMort %>%
            mutate(State = "All States") %>%
            filter(Year == as.integer(
              input$timePeriod[[1]]
              #1999 # test value 
              ) | Year == as.integer(
              input$timePeriod[[2]]
              #2010 # test value  
              )) %>%
            group_by(State, ICD.Chapter, Year) %>%
            select(State, ICD.Chapter, Year, Deaths, Population) %>%
            summarise(Deaths = sum(as.numeric(Deaths)), 
                      Population = sum(as.numeric(Population))) %>%
            mutate(Crude.Rate = round(((Deaths/Population)*100000),1)) %>%
            select(State, ICD.Chapter, Year, Crude.Rate)  %>% 
            filter(ICD.Chapter %in% 
                       input$conditions
                       #c("Certain infectious and parasitic diseases") # test value
              ) %>%
           spread(Year, Crude.Rate) %>%
           ungroup() %>%
           mutate(`% Change` = ((.[[4]] - .[[3]])/.[[3]]))

    
    dfMortSub <- dfMort %>%
      filter(Year == as.integer(
        input$timePeriod[[1]]
        #1999 # test value 
      ) | Year == as.integer(
        input$timePeriod[[2]]
        #2010 # test value  
      )) %>%
      mutate(Crude.Rate = round(((Deaths/Population)*100000),1)) %>%
      select(State, ICD.Chapter, Year, Crude.Rate)  %>% 
      filter(ICD.Chapter %in% 
               input$conditions
               #c("Certain infectious and parasitic diseases") #test value
      )  %>%
      group_by(State, ICD.Chapter, Year) %>%
      spread(Year, Crude.Rate) %>%
      ungroup() %>%
      mutate(`% Change` = ((.[[4]] - .[[3]])/.[[3]])) %>%
      arrange(-`% Change`) %>%
      mutate(State = factor(State,State)) 
      
    
    ggplot(data = dfMortSub, aes(y = `% Change`, x = State, fill = `% Change`)) +
      geom_bar(stat = "identity", width = .5) +
      scale_fill_distiller(palette = "YlOrRd", label = percent, name = "% Change \n") + 
      scale_y_continuous(labels = percent) + 
      ylab(paste("Percentage Change of Mortality Rate from Year", input$timePeriod[[1]], "to",input$timePeriod[[2]])) + 
      geom_hline(aes(yintercept = dfUs$`% Change`, linetype = dfUs$State), size = .75) +
      scale_linetype_discrete("National Rate Change") + 
      coord_flip() + 
      theme_minimal() 
      
  })
  
 # output$event <- renderPrint({
 #  d <- event_data("plotly_hover")
 # })
  
})
