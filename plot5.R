##Read the data and load libraries
library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##find motor vehicle source codes
filter <- grep("Motor Vehicles", SCC$Short.Name)
SCCfiltered <- SCC[filter,]
SCCcodes <- SCCfiltered$SCC

##filter NEI to the SCC codes for motor vehicles
NEIfiltered <- filter(NEI, SCC %in% SCCcodes)

##Group data by year
NEIgrouped <- group_by(NEI, year)

##Filter data to Baltimore
NEIgrouped <- filter(NEIgrouped, fips == "24510")

##Get total emissions for each year
NEItotal <- summarize(NEIgrouped, Emissions = sum(Emissions, na.rm = TRUE))
                      
##Generate plot of total emissions over time
qplot(year, Emissions, data = NEItotal, geom = "line", xlab = "Year", 
      ylab = expression("Total Emissions (PM"[2.5]*" in tons)"), main = "Total Annual Emissions in Baltimore from Motor Vehicles")

##save to png file
dev.copy(png, file = "plot5.png")
dev.off()