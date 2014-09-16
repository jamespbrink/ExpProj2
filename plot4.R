##Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##find coal combustion source codes
filter1 <- grep("Comb", SCC$Short.Name)
SCCfiltered <- SCC[filter1,]
filter2 <- grep("Coal", SCCfiltered$Short.Name)
SCCfiltered <- SCCfiltered[filter2,]
SCCcodes <- SCCfiltered$SCC

##filter NEI to the SCC codes for coal combustion
NEIfiltered <- filter(NEI, SCC %in% SCCcodes)

##Group data by year
NEIgrouped <- group_by(NEIfiltered, year)

##Get total emissions for each year
NEItotal <- summarize(NEIgrouped, Emissions = sum(Emissions, na.rm = TRUE))
                      
##Generate plot of total emissions over time
qplot(year, Emissions, data = NEItotal, geom = "line", xlab = "Year", 
      ylab = expression("Total Emissions (PM"[2.5]*" in tons)"), main = "Total Annual Coal Combustion Emissions in the US")

##save to png file
dev.copy(png, file = "plot4.png")
dev.off()