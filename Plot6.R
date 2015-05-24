##import librarys
library(ggplot2)

## import data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
## merge NEI and SCC together
NEISCC <- merge(NEI, SCC, by="SCC")

## subset by Vehicles
Vehicles <- grepl("vehicles", NEISCC$SCC.Level.Two, ignore.case=TRUE)
VehiclesNEISCC <- NEISCC[Vehicles, ]

## subset to only Baltimore and LA
Baltimore_LA <- VehiclesNEISCC[VehiclesNEISCC$fips=="24510" | VehiclesNEISCC$fips=="06037", ]

## totals for the years by city
total_year_city <- aggregate(Emissions ~ year + fips, Baltimore_LA, sum)

## adding the city names
total_year_city$fips[total_year_city$fips=="24510"] <- "Baltimore"
total_year_city$fips[total_year_city$fips=="06037"] <- "Los Angeles"

png("plot6.png")

ggp <- ggplot(total_year_city, aes(factor(year), Emissions)) +
    geom_bar(stat="identity") + xlab("year") + facet_grid(. ~ fips) +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

dev.off()