##***************************************************************************##

## Loading ggplot2 package
library(dplyr)
library(ggplot2)

## Loading datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering Baltimore City data only
NEI<-filter(NEI,fips=="24510")

## Converting year and type to factor and storing the result in a data frame
df<-data.frame(Emissions=NEI$Emissions,type=factor(NEI$type),Year=factor(NEI$year))

## Plotting the graph in a png file
png(filename = "plot3.png",width=720,height=480,units = "px")
g<-ggplot(df) +geom_col(aes(x=Year,y=Emissions,fill=Year))+facet_grid(.~type)+labs(x="Year", y=expression("Total PM2.5 Emission (in Tons)")) +labs(title=expression("PM2.5 Emissions, Baltimore City 1999-2008 by Source Type"))
print(g)

## Closing png device
dev.off()

##****************************************************************************head##