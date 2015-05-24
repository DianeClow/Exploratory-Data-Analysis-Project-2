## import data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#subsets and sums by year
total_by_year <- aggregate(Emissions ~ year,NEI, sum)


## creating and printing the plot
png("plot1.png")

barplot(
    (total_by_year$Emissions),
    names.arg=total_by_year$year,
    xlab="Year",
    ylab="PM2.5 Emissions (Tons)",
    main="Total PM2.5 Emissions From All US Sources"
)

dev.off()