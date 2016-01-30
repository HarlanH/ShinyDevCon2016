library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Harlan's ShinyDevCon 2016 Notes"),
  dashboardSidebar(
    sidebarMenu(id="tabs",
                menuItem("Notes", tabName="notes", icon=icon("pencil")),
                menuItem("Interactive Graphs", tabName="intgraphs", icon=icon("hand-o-left")),
                menuItem("About", tabName="about", icon=icon("question")))
  ),
  dashboardBody(
    tabItems(
      tabItem("notes",
              htmlOutput("mdnotes", inline=TRUE)),
      tabItem("intgraphs",
              div(p("Hover to see point details; click to remove the point")),
              plotOutput("plot1", width = 400,
                         hover = hoverOpts(
                           id = "plot1_hover", delay = 500
                         ),
                         click = "plot1_click"),
              tableOutput("plot1_hover_table")),
      tabItem("about",
              div(p(a(href="https://github.com/HarlanH/ShinyDevCon2016", "GitHub Source"))))
    )
  ),
  title="ShinyDevCon 2016"
)
