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

##Group data by year and fips
NEIgrouped <- group_by(NEI, year, fips)

##Filter data to Baltimore and LA
NEIgrouped <- filter(NEIgrouped, fips == "24510" | fips == "06037")

##Get total emissions for each year
NEItotal <- summarize(NEIgrouped, Emissions = sum(Emissions, na.rm = TRUE))

##Replace fips numbers with labels
NEItotal$fips <- gsub("24510", "Baltimore City", NEItotal$fips)
NEItotal$fips <- gsub("06037", "Los Angeles County", NEItotal$fips)
                      
##Generate bar plot of total emissions over time with a facet of they cities
g <- ggplot(NEItotal, aes(year, Emissions))
g <- g + geom_line() + geom_smooth(method="lm")
g <- g + facet_grid(fips  ~ ., scales="free")
g <- g + ylab(expression("Total Emissions (PM"[2.5]*" in tons)"))
g <- g + xlab("Year")
g <- g + ggtitle("Total Annual Emissions from Motor Vehicles")
g

##save to png file
dev.copy(png, file = "plot6.png")
dev.off()