#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Wasi Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("num",
                        "Select a number:",
                        min = 1,
                        max = 50,
                        value = 20,
                        )
        ),
        
    plotOutput(outputId="hist")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$hist <- renderPlot({
        hist(rnorm(input$sum))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
