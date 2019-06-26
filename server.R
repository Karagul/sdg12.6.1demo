#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
data <- read.csv("fake_data.csv")

shinyServer(function(input, output) {
  
  employ <- reactive({
    employ <- input$employees
  })
  output$employ <- renderPrint({ employ })
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- read.csv("fake_data.csv")
    if (input$country != "All") {
      data <- data[data$country == input$country,]
    }
    if (input$sector != "All") {
      data <- data[data$sector == input$sector,]
    }
    data <- data[data$employees>input$employees[1]&data$employees<input$employees[2],]
    data
  }))
 
  output$barplot <- renderPlotly({
    data <- read.csv("fake_data.csv")
    if (input$country != "All") {
      data <- data[data$country == input$country,]
    }
    g <- ggplot(data=data, aes(x=sector))+geom_bar()+theme(axis.text.x=element_blank())
    ggplotly(g)
  })
  
  output$mininum <- renderValueBox({
    data <- read.csv("fake_data.csv")
    if (input$country != "All") {
      data <- data[data$country == input$country,]
    }
    if (input$sector != "All") {
      data <- data[data$sector == input$sector,]
    }
    mindat <- data[data$requirement=="minimum",]
    valueBox(
      value=nrow(mindat), 
      subtitle = "Companies meeting minimum requirements", 
      icon = icon("tasks"), 
      color="aqua"
    )
  })
  
  output$advanced <- renderValueBox({
    data <- read.csv("fake_data.csv")
    if (input$country != "All") {
      data <- data[data$country == input$country,]
    }
    if (input$sector != "All") {
      data <- data[data$sector == input$sector,]
    }
    advdat <- data[data$requirement=="advanced",]
    valueBox(
      value=nrow(advdat), 
      subtitle = "Companies meeting advanced level requirements", 
      icon = icon("tasks"), 
      color="aqua"
    )
  })

  
})
