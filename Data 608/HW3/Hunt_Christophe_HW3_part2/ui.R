#Often you are asked whether particular States are improving their mortality rates (per cause) faster than, or slower than, the national average. Create a visualization that lets your clients see this for themselves for one cause of death at the time. Keep in mind that the national average should be weighted by the national population.


dfMort <- read.csv("https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework/master/Data%20608/HW3/cleaned-cdc-mortality-1999-2010.csv")

library(shiny)
library(pacman)
p_load(tidyverse, plotly, forcats, plotly)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mortality Rate Change by State"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("foo", "Time Period", min = min(as.numeric(dfMort$Year)),
                  max = max(as.numeric(dfMort$Year)), value = c(min(as.numeric(dfMort$Year)), max(as.numeric(dfMort$Year))), sep = ""),
     
      selectInput("conditions", "Conditions", 
                  unique(as.character(dfMort$ICD.Chapter)), selectize = TRUE),
      tableOutput("data")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("distPlot", height = 700, width = 500)
      
    )
  )
))
