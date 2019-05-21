##*******************************************************************************##


## Loading ggplot2 package
library(dplyr)
library(ggplot2)

## Loading datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering Baltimore City data only
NEI<-filter(NEI,fips=="24510")

## Filtering rows related to motor vehicle related data
SCC<-filter(SCC,EI.Sector %in% c(" Mobile - On-Road Gasoline Light Duty Vehicles"," Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Diesel Heavy Duty Vehicles "))

## Merging NEI and SCC based on SCC
newNEI<-merge(NEI,SCC,by="SCC")

## Converting year and type to factor and storing the result in a data frame
df<-data.frame(Emissions=newNEI$Emissions,Year=factor(newNEI$year),na.rm=TRUE)

## Plotting the graph in a png file
png(filename = "plot5.png",width=600,height=480,units = "px")
g<-ggplot(df) +geom_col(aes(x=Year,y=Emissions,fill=Year),na.rm = TRUE)+labs(x="Year", y=expression("Total PM2.5 Emission (in Tons)")) +labs(title=expression("PM2.5 Emissions in Baltimore City From Motor Vehicle Sources"))
print(g)

## Closing png device
dev.off()


##*******************************************************************************##
