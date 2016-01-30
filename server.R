library(shiny)
library(shinydashboard)
library(markdown)

rendered_notes <- markdownToHTML(file="notes.md", fragment.only = TRUE)

shinyServer(function(input, output, session) {

  output$mdnotes <- renderText({
    rendered_notes
  })
  
})
