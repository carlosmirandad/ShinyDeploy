############################################################################
# server.R
############################################################################
library(shiny)
library(ggplot2)

#Load the dataset (one time)
datWTO       <- read.csv("./WTO_TS_2013_2006.csv")
datWTO$Value <- as.numeric(datWTO$Value)
datCountries <- as.character(unique(datWTO$Reporting_Country))
userCount    <- 0


shinyServer(
    function(input,output,session) {
        userCount <<- userCount + 1
        updateSelectInput(session, "Countries", 
                          choices=datCountries, 
                          selected=c("United States","Thailand","Saudi Arabia","India","Brazil"))
        
        output$Year        <- renderPrint(input$Year)
        output$Commodities <- renderPrint(input$Commodities)
        output$Countries   <- renderPrint(input$Countries)
        
        yr   <- reactive({as.numeric(input$Year)})
        comm <- reactive({as.character(input$Commodities)})
        ctry <- reactive({as.character(input$Countries)})
        datWTOExp <- reactive({datWTO[datWTO$Year==yr() & 
                                          datWTO$Reporting_Country %in% ctry() &
                                          datWTO$Commodity %in% comm() &
                                          datWTO$Flow=="Exports",
                                      c("Reporting_Country","Value","Commodity_Type")
                                      ]})
        datWTOImp <- reactive({datWTO[datWTO$Year==yr() & 
                                          datWTO$Reporting_Country %in% ctry() &
                                          datWTO$Commodity %in% comm() &
                                          datWTO$Flow=="Imports",
                                      c("Reporting_Country","Value","Commodity_Type")
                                      ]})
        
        output$gExport <- renderPlot({
            #plot(Value ~ Reporting_Country, data=datWTORed())
            qplot(x=Reporting_Country, y=Value, fill=Commodity_Type, data=datWTOExp(),
                  main=paste("Reported Exports for Year",as.character(yr())), 
                  xlab="", ylab="Total Export Value (US$ Million)",
                  geom="bar", stat="identity", position="dodge")
        })
        output$gImport <- renderPlot({
            #plot(Value ~ Reporting_Country, data=datWTORed())
            qplot(x=Reporting_Country, y=Value, fill=Commodity_Type, data=datWTOImp(), 
                  main=paste("Reported Imports for Year",as.character(yr())), 
                  xlab="", ylab="Total Import Value (US$ Million)",
                  geom="bar", stat="identity", position="dodge")
        })
        
    }    
)