# stock-portfolio-analysis

Application Operation Instructions:
For the execution you will be needing a csv file with certain columns and I have uploaded that under the name “stocks_sample.csv”. So please use that while executing the application.

1. Installation:
To use the Stock Portfolio Analysis Application, follow these steps:

•	Ensure you have R and RStudio installed on your system.

•	Download the application files from [GitHub repository link].

•	Open the R script file seperate for ui as well as server(ui.R) and (server.R) in RStudio.

•	Install the required packages using the following command:
 	install.packages(c("shiny", "shinydashboard", "dplyr", "ggplot2"))

•	Run the R script (ui.R) and (server.R) by using the “Run App” button on top right of your ui.R or server.R file.

2. Home and Uploading Portfolio Data:

•	Once the application is launched, you will be welcomed on the Home page.

•	Navigate to the “Upload Portfolio Data” tab on the same home page.

•	Click on the “Choose CSV File” button to select your portfolio data file in CSV format.

•	The application supports uploading portfolio data containing columns for stock symbols, dates, and prices in the same column names as:

–	“Symbol” for stock symbol.

–	“Quantity” for the quantity of particular stock purchased.

–	“Purchase Price” for the price of stocks.

–	“Purchase Date” for the date on which the stocks were bought.

–	“Buy/Sell” indicating whether you bought or sold the stock.

•	Please feel free to use the “stocks_sample.csv” file which is short and easy to understand when using the application for the first time. It will be really feasible to understand the visualization as well as the working of profit and loss. You can even cross check it manually.

3. Data Preview:

•	After uploading the portfolio data, switch to the “Data Preview” tab to view a summary of the uploaded data.

•	The table displays the first few rows of the portfolio data, allowing users to verify the uploaded information.

•	There is also a search button to view for the selected data which enhances the user experience.

•	You can also choose the number of data rows to view on a single page from multiple options.

4. Portfolio Analysis:

•	Move to the “Portfolio Analysis” tab to perform comprehensive analysis of your stock portfolio.

•	The application provides interactive plot and metrics to evaluate portfolio performance, including:

–	Filters to be applied:

–	stock_symbol: Dropdown menu with unique stock symbols from the uploaded file.

–	date_range: Date range input based on the earliest and latest purchase dates in the uploaded file.

–	Plotting Portfolio Value: The app plots the portfolio value over time based on the selected stock symbol(s) and date range. It calculates the portfolio value by summing the product of quantity and purchase price for each purchase date.

–	Profit and Loss Calculation: The app calculates the total profit and total loss based on the selected stock symbol(s) and date range. It sums the purchase prices for buy and sell transactions separately, calculates the difference between total sell and total buy, and computes the profit/loss percentage.

5. Exporting Results:

•	Optionally, export the analysis results and visualizations in PNG format.

•	The app provides a download link to download the plot as a PNG image. When you click on the “Download Plot” button, it generates the plot based on the selected stock symbol(s) and date range, saves it as a PNG file, and prompts you to download it.

In summary:

To use the app:

•	Run the Shiny app.

•	Upload your CSV file containing the required data.

•	Preview the data of the uploaded .csv file.

•	Select the stock symbol(s) and date range.

•	View the portfolio plot, profit and loss as per the filters.

•	Download the portfolio plot as a PNG image if needed.
