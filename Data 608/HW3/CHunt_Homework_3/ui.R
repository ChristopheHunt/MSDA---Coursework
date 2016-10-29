#As a researcher, you frequenctly compare mortality rates from particular causes across different States. You need a visualization that will let you see (for 2010 only) the crude mortality rate, across all States, from one cause (for example, Neoplasms, which effectively cancers). Create a visualization that allows you to rank States by crude mortality of each cause of death
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Mortality Rates by States in 2010"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        selectInput("conditions", "Conditions", 
                    unique(as.character(dfMort$ICD.Chapter)), selectize = TRUE),
        tableOutput("data")
    
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot", height = 700, width = 500)
    )
  )
))
