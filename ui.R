library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Harlan's ShinyDevCon 2016 Notes"),
  dashboardSidebar(
    sidebarMenu(id="tabs",
                menuItem("Notes", tabName="notes", icon=icon("pencil")),
                menuItem("About", tabName="about"))
  ),
  dashboardBody(
    tabItems(
      tabItem("notes",
              htmlOutput("mdnotes", inline=TRUE)),
      tabItem("about",
              div(p(a(href="https://github.com/HarlanH/ShinyDevCon2016", "GitHub Source"))))
    )
  ),
  title="ShinyDevCon 2016"
)
