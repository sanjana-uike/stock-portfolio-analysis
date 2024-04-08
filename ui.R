# importing necessary libraries
library(shiny)
library(shinydashboard)

# this is entire code for ui 
shinyUI(
  # creating dashboard page
  dashboardPage(title = "Stock Portfolio App",
                # the title when we open a new tab in browser
                dashboardHeader(title = "Stock Portfolio"),
                dashboardSidebar(
                  sidebarMenu(
                    # side bar menu options along with icons as well as creating respective pages for each menu option
                    menuItem("Home", tabName = "home", icon = icon("home")),
                    menuItem("Data Preview", tabName = "preview", icon = icon("table")),
                    menuItem("Detailed Analysis", icon = icon("magnifying-glass-chart"), badgeLabel = "New", badgeColor = "green"),
                    menuSubItem("Portfolio Performance", tabName = "portfolio")
                  )
                ),
                dashboardBody(
                  tabItems(
                    # page for home including option to upload csv file
                    tabItem(tabName = "home",
                            fluidRow(
                              wellPanel(title = "Stock Portfolio App",
                                        status = "primary",
                                        solidHeader = TRUE,
                                        width = 7,
                                        tags$h2("Welcome to Stock Portfolio App!"),br(),
                                        tags$p("This app allows you to:"),
                                        tags$ul(
                                          tags$li("Upload your stock portfolio data"),
                                          tags$li("Preview the data"),
                                          tags$li("Analyze your portfolio performance")
                                        ),br(),
                                        tags$h4("Navigate through the tabs to get started!"),br(),
                              ),
                              column(width = 12,
                                     tags$h4("But first, start by uploading a csv file!"),br(),
                                     box(
                                       title = "Upload CSV File",
                                       status = "primary",
                                       solidHeader = TRUE,
                                       width = 5,
                                       fileInput("file", 
                                                 label = "Choose CSV File (Max. 10MB)", 
                                                 accept = c(".csv"),
                                                 multiple = FALSE)
                                     )
                            ),
                            fluidRow(
                              wellPanel(
                                tags$ul(
                                  tags$p("Please make sure that your column names are: Symbol, Quantity, Purchase Price, Purschase Date and Buy/Sell"),
                                  tags$p("The Purchase date should be in yyyy-mm-dd format")
                                )
                              )
                            )  
                    )
                    ),
                    # page to preview the data of uploaded csv file
                    tabItem(tabName = "preview", 
                            box(title = "Data Preview", status = "primary", solidHeader = TRUE, width = 12,
                                dataTableOutput("table"))
                    ),
                    # page to view the analysis
                    tabItem(tabName = "portfolio", 
                            tags$h2("Portfolio Overview"),
                            tags$p("This section provides an overview of your portfolio performance."),
                            tags$ul(
                              tags$li("You can use controls to filter the stocks by symbols as well as select dates."),
                              tags$li("A plot of the analysis will be displayed."),
                              tags$li("You can also visualize the profit and loss according to the filters applied.")
                            ),
                            br(),
                            fluidRow(
                              # this will contain the plot
                              box(title = "Portfolio Performance", status = "info", solidHeader = T, plotOutput("portfolio_plot")),
                              # this will contain the controls for filtering the dates as well as stock symbol
                              box(title = "Controls", status = "info", solidHeader = T,
                                  selectInput("stock_symbol", "Select Stock Symbol", choices = NULL, multiple = TRUE),
                                  dateRangeInput("date_range", "Select Date Range", start = NULL, end = NULL)
                              ),
                              # this will display profit
                              valueBoxOutput("profit"),
                              # this will display loss
                              valueBoxOutput("loss")
                            ),
                            # a button to download the plot
                            fluidRow(
                              downloadButton("downloadPlot", label = "Download Plot")
                            )
                    )
                  )
                )
  )
)
