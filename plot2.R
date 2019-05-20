##***************************************************************************##

## Loading dplyr package
library(dplyr)

## Loading datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Selecting observations with specified county number
newNEI<-filter(NEI,fips=="24510")

## Converting year from numeric to factor type
newNEI<-mutate(newNEI,year=factor(year))

## Grouping data based on year
yearWise<-group_by(newNEI,year)

## Calculating total pm2.5 emission per year for county with fips equal to 24510
total_emission<-summarize(yearWise,total=sum(Emissions,na.rm = TRUE))

## Plotting the graph in a png file
png(filename = "plot2.png",width=480,height=480,units = "px")
barplot(total_emission$total,xlab="Year",ylab="PM2.5 (in tons)",names.arg = c("1999","2002","2005","2008"),col=c("steelblue", "salmon3","azure","orchid"),main = "Total Emission in Baltimore City",border = "gold",ylim = c(0,4000))

## Closing png device
dev.off()
