library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Harlan's ShinyDevCon 2016 Notes"),
  dashboardSidebar(
    sidebarMenu(id="tabs",
                menuItem("Notes", tabName="notes", icon=icon("pencil")))
  ),
  dashboardBody(
    tabItems(
      tabItem("notes",
              htmlOutput("mdnotes", inline=TRUE))
    )
  ),
  title="ShinyDevCon 2016"
)
