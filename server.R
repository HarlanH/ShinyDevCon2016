library(shiny)
library(shinydashboard)
library(markdown)

shinyServer(function(input, output, session) {
  
  callModule(mywidget, "one")
  
  dat <- reactiveValues(mtcars=mtcars)
  
  observe({
    row <- nearPoints(dat$mtcars, input$plot1_click,
                      xvar = "wt", yvar = "mpg",
                      threshold = 5, maxpoints = 1)
    if (nrow(row) == 1)
      dat$mtcars <- subset(dat$mtcars, rownames(dat$mtcars) != rownames(row))
  })
  
  output$plot1 <- renderPlot({
    plot(dat$mtcars$wt, dat$mtcars$mpg)
  } )
  
  output$plot1_hover_table <- renderTable({
    row <- nearPoints(dat$mtcars, input$plot1_hover,
                      xvar = "wt", yvar = "mpg",
                      threshold = 5, maxpoints = 1)
    row
  })
  
})
