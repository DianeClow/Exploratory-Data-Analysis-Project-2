## import data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## subset to Baltimore
Baltimore  <- NEI[NEI$fips=="24510", ]

## Balt subsets and sums by year
Baltimore_total_by_year <- aggregate(Emissions ~ year, Baltimore,sum)

## creating and printing the plot
png("plot2.png")

barplot(
    Baltimore_total_by_year$Emissions,
    names.arg=Baltimore_total_by_year$year,
    xlab="Year",
    ylab="PM2.5 Emissions (Tons)",
    main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()