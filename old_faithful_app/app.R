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
      plotOutput(outputId = "distPlot"),
      # ----
      # ADD THIS
      # ----
      textOutput(outputId = "eruptionCounter")
    )
  )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # ----
  # ADD THIS
  # This isn't particularly good code, we probably wouldn't call this data.
  # We're just doing it to make sure a git conflict happens later!
  # ----
  data <- faithful %>%
    summarise(num_eruptions = n())
  
  output$distPlot <- renderPlot({
    # draw the histogram with the specified number of bins
    faithful %>% ggplot(aes(x = waiting)) +
      geom_histogram(bins = input$bins, col = "white", fill = "darkred") +
      xlab("Waiting time (mins)") +
      ylab("Number of eruptions") +
      ggtitle("Histogram of eruption waiting times")
  })
  
  # ----
  # ADD THIS
  # ----
  output$eruptionCounter <- renderText({
    paste("Number of eruptions in histogram: ", data$num_eruptions)
  })
  
}
# Run the application 
shinyApp(ui = ui, server = server)