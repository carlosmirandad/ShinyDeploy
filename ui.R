############################################################################
# ui.R
############################################################################
shinyUI(pageWithSidebar(
    
    headerPanel("World Trade Organization Statistics"),
    
    sidebarPanel(
        #includeMarkdown("Documentation.md"),
        includeHTML("Documentation.html"),
        strong("Make your selections here:"),
        br(),
        sliderInput('Year', 'Year:', value=2013, min=2006, max=2013, step=1),
        br(),
        checkboxGroupInput("Commodities", 
                           "Commodity Types:",
                           c("Agricultural products" = "A",
                             "Fuels and mining products" = "F",
                             "Manufactures" = "M"),
                           selected=c("A","F","M")
                           ),
        br(),
        selectInput('Countries', 
                    'Countries and Territories:', 
                    c("United States","Thailand","Saudi Arabia","India","Brazil"),
                    selected=c("United States","Thailand","Saudi Arabia","India","Brazil"),
                    multiple=TRUE, 
                    selectize=TRUE)
    ),
    
    mainPanel(
        plotOutput('gExport'),
        plotOutput('gImport'),
        br(),
        br(),
        h5('The following are the inputs provided: '),
        h6('Countries and Territories:'),
        verbatimTextOutput("Countries"),
        h6('Commodity Tyes:'),
        verbatimTextOutput("Commodities"),
        h6('Year:'),
        verbatimTextOutput("Year")
    )
))
