##***************************************************************************##

## Loading dplyr package
library(dplyr)

## Loading datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Converting year from numeric to factor type
newNEI<-mutate(NEI,year=factor(year))

## Grouping data based on year
yearWise<-group_by(newNEI,year)

## Calculating total pm2.5 emission per year
total_emission<-summarize(yearWise,total=sum(Emissions,na.rm = TRUE)/1000000)

## Plotting the graph in a png file
png(filename = "plot1.png",width=480,height=480,units = "px")
barplot(total_emission$total,xlab="Year",ylab="PM2.5 (in million tons)",names.arg = c("1999","2002","2005","2008"),col=c("yellowgreen", "lightblue2", "seagreen2","hotpink1"),ylim=c(0,8),main = "Total Emission",border = "blue")

## Closing png device
dev.off()

##****************************************************************************##