##Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Group data by year
NEIgrouped <- group_by(NEI, year)

##Get total emissions for each year
NEItotal <- summarize(NEIgrouped, Emissions = sum(Emissions, na.rm = TRUE))

##set plot rows
par(mfcol=c(1,1))
                      
##Generate plot of total emissions over time
plot(NEItotal$year, NEItotal$Emissions, type="l", xlab="Year", ylab = expression("Total Emissions (PM"[2.5]*" in tons)"), main= "Total Annual Emissions")

##save to png file
dev.copy(png, file = "plot1.png")
dev.off()