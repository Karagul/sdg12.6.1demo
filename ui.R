
library(shiny)
library(shinydashboard)
library(plotly)
dat <- read.csv("fake_data.csv")


dashboardPage(
  dashboardHeader(title = "SDG 12.6.1 platform"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon=icon("tachometer-alt")),
      menuItem("About SDG12.6.1", tabName="about", icon=icon("question-circle")), 
      menuItem("Data Table", tabName="rawdata", icon=icon("table"))
    ),
    selectInput("country", 
                "Select Country:", 
                c("All", unique(as.character(dat$country)))),
    selectInput("sector",
                "Select Sector:",
                c("All", unique(as.character(dat$sector)))),
    sliderInput("employees",
                "Select Number of Employees:",
                min=min(dat$employees), max=max(dat$employees), value=c(min(dat$employees), max(dat$employees))),
    fileInput("file_input", "Upload individual report (PDF only)", accep=c('.pdf'))
   
  ),
  dashboardBody(
    tabItems(
      tabItem("dashboard",
              fluidRow(
                valueBoxOutput("mininum"),
                valueBoxOutput("advanced")
              ), 
              fluidRow(
                plotlyOutput("barplot")
              )
             
      ),
      tabItem("about",
              img(src="sdg12.png", align="left", height=200, border=100), 
              h3("About SDG12.6.1"), 
              h4("While Indicator 12.6.1 counts the number of companies producing 
                 sustainability reports, the custodian agencies consider the indicator 
                 an important opportunity not only to monitor and promote the growth 
                 in sustainability reporting globally, but also to monitor and promote 
                 high quality reporting.")
      ),
      tabItem("rawdata", 
            DT::dataTableOutput('table')
              
              )
    )
  )
)


