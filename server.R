# importing libraries
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

# server part of the code
shinyServer(function(input, output, session) {
  data <- reactiveValues(df = NULL)
  
  # fetching data from csv file and storing into respective variables
  observeEvent(input$file, {
    req(input$file$datapath)
    data$df <- read.csv(input$file$datapath, stringsAsFactors = FALSE)
    data$df$Purchase.Date <- as.Date(data$df$Purchase.Date, format = "%d-%m-%Y")
    data$df$Buy.Sell <- as.factor(data$df$Buy.Sell)
    
    # the control section for filtering dates and stock symbol
    updateSelectInput(session, "stock_symbol", choices = unique(data$df$Symbol))
    updateDateRangeInput(session, "date_range", start = min(data$df$Purchase.Date), end = max(data$df$Purchase.Date))
  })
  
  # server section for displaying the plot as per the filters selected by user
  output$portfolio_plot <- renderPlot({
    req(data$df)  # Ensure that data is available
    
    # Filter data for the selected stock symbol
    filtered_data <- data$df %>% 
      filter(Symbol %in% input$stock_symbol, 
             Purchase.Date >= input$date_range[1], 
             Purchase.Date <= input$date_range[2])
    
    # Calculate total buy and sell values for each stock symbol
    stock_summary <- filtered_data %>%
      group_by(Symbol, Buy.Sell) %>%
      summarise(Total_Value = sum(Quantity * Purchase.Price))
    
    # Plotting the bar plot for buy and sell transactions
    ggplot(stock_summary, aes(x = Symbol, y = Total_Value, fill = Buy.Sell)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Stock Symbol", y = "Total Value", fill = "Transaction Type") +
      scale_fill_manual(values = c("Buy" = "red", "Sell" = "green")) +
      theme_minimal()
  })
  
  
  
  
  
  output$profit <- renderValueBox({
    req(data$df)
    filtered_data <- data$df %>% 
      filter(Symbol %in% input$stock_symbol, 
             Purchase.Date >= input$date_range[1], 
             Purchase.Date <= input$date_range[2])
    
    # Calculate total profit
    total_profit <- sum(ifelse(filtered_data$Buy.Sell == "Sell", filtered_data$Quantity * filtered_data$Purchase.Price, -filtered_data$Quantity * filtered_data$Purchase.Price))
    
    # Calculate profit percentage
    total_buy <- sum(filtered_data$Quantity[filtered_data$Buy.Sell == "Buy"] * filtered_data$Purchase.Price[filtered_data$Buy.Sell == "Buy"])
    profit_percent <- if (total_buy > 0) total_profit / total_buy * 100 else 0
    
    # Display the profit
    if(total_profit > 0){
      valueBox(paste("$", total_profit, ", ", formatC(profit_percent, format = "f", digits = 2), "%"), "Total Profit", icon = icon("thumbs-up"), color = "green")
    } else {
      valueBox("$ 0", "Total Profit", icon = icon("thumbs-up"), color = "green")
    }
  })
  

  output$loss <- renderValueBox({
    req(data$df)
    filtered_data <- data$df %>% 
      filter(Symbol %in% input$stock_symbol, 
             Purchase.Date >= input$date_range[1], 
             Purchase.Date <= input$date_range[2])
    
    # Calculate total loss
    total_loss <- sum(ifelse(filtered_data$Buy.Sell == "Buy", -filtered_data$Quantity * filtered_data$Purchase.Price, filtered_data$Quantity * filtered_data$Purchase.Price))
    
    # Calculate loss percentage
    total_sell <- sum(filtered_data$Quantity[filtered_data$Buy.Sell == "Buy"] * filtered_data$Purchase.Price[filtered_data$Buy.Sell == "Buy"])
    loss_percent <- if (total_sell > 0) total_loss / total_sell * 100 else 0
    
    # Display the loss
    if(total_loss < 0){
      valueBox(paste("$", total_loss, ", ", formatC(loss_percent, format = "f", digits = 2), "%"), "Total Loss", icon = icon("thumbs-down"), color = "red")
    } else {
      valueBox("$ 0", "Total Loss", icon = icon("thumbs-down"), color = "red")
    }
  })
  
  
  
  # server section for displaying the preview of data imported from the excel file
  output$table <- renderDataTable({
    if (!is.null(data$df)) {
      data$df
    }
  })
  
  # server section for downloading the plot which is displayed after analysis in a .png extension
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste("plot", "png", sep = ".")
    },
    content = function(file) {
      png(file)
      req(data$df)
      filtered_data <- data$df %>% 
        filter(Symbol %in% input$stock_symbol, 
               Purchase.Date >= input$date_range[1], 
               Purchase.Date <= input$date_range[2])
      
      # Calculate total buy and sell values for each stock symbol
      stock_summary <- filtered_data %>%
        group_by(Symbol, Buy.Sell) %>%
        summarise(Total_Value = sum(Quantity * Purchase.Price))
      
      # Plotting the bar plot for buy and sell transactions
      p <- ggplot(stock_summary, aes(x = Symbol, y = Total_Value, fill = Buy.Sell)) +
        geom_bar(stat = "identity", position = "dodge") +
        labs(x = "Stock Symbol", y = "Total Value", fill = "Transaction Type") +
        scale_fill_manual(values = c("Buy" = "red", "Sell" = "green")) +
        theme_minimal()
      print(p)
      dev.off()
    }
  )
  
})
