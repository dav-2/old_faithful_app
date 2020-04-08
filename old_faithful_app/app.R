library(shiny)
library(tidyverse)
# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # draw the histogram with the specified number of bins
    faithful %>% ggplot(aes(x = waiting)) +
      geom_histogram(bins = input$bins, col = "white", fill = "darkred") +
      xlab("Waiting time (mins)") +
      ylab("Number of eruptions") +
      ggtitle("Histogram of eruption waiting times")
  })
  
}
# Run the application 
shinyApp(ui = ui, server = server)