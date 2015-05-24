##import librarys
library(ggplot2)

## import data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
## merge NEI and SCC together
NEISCC <- merge(NEI, SCC, by="SCC")

## subset NEISCC by coal and combustion
coal <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
NEISCC_coal <- NEISCC[coal, ]
combustion <- grepl("combustion", NEISCC_coal$SCC.Level.Four, ignore.case=TRUE)
NEISCC_coal_combustion <- NEISCC_coal[combustion, ]

png("plot4.png")

ggp <- ggplot(NEISCC_coal_combustion,aes(factor(year),Emissions)) +
    geom_bar(stat="identity") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off()