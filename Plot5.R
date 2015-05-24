##import librarys
library(ggplot2)

## import data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
## merge NEI and SCC together
NEISCC <- merge(NEI, SCC, by="SCC")

## subset to Baltimore
Baltimore  <- NEISCC[NEISCC$fips=="24510", ]

## subset by Vehicles
Vehicles <- grepl("vehicles", Baltimore$SCC.Level.Two, ignore.case=TRUE)
Baltimore_Vehicles <- Baltimore[Vehicles, ]

png("plot5.png")

ggp <- ggplot(Baltimore_Vehicles,aes(factor(year),Emissions)) +
    geom_bar(stat="identity") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

dev.off()