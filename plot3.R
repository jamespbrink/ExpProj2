##Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Group data by year and type
NEIgrouped <- group_by(NEI, year, type)

##Filter data to Baltimore
NEIgrouped <- filter(NEIgrouped, fips == "24510")

##Get total emissions for each year
NEItotal <- summarize(NEIgrouped, Emissions = sum(Emissions, na.rm = TRUE))
                      
##Generate plot of total emissions over time
qplot(year, Emissions, data = NEItotal, group = type, color = type, geom = "line", xlab = "Year", 
      ylab = expression("Total Emissions (PM"[2.5]*" in tons)"), main = "Total Annual Emissions in Baltimore by Source Type")

##save to png file
dev.copy(png, file = "plot3.png")
dev.off()