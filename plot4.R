##*******************************************************************************##

## Loading ggplot2 and dplyr package
library(dplyr)
library(ggplot2)

## Loading datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filtering rows related to Coal combustion-related data
SCC<-filter(SCC,EI.Sector %in% c("Fuel Comb - Electric Generation - Coal"," Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Comm/Institutional - Coal"))

## Merging NEI and SCC based on SCC
newNEI<-merge(NEI,SCC,by="SCC")

## Converting year and type to factor and storing the result in a data frame
df<-data.frame(Emissions=newNEI$Emissions,Type=factor(newNEI$type),Year=factor(newNEI$year),na.rm=TRUE)
  
  
  
## Plotting the graph in a png file
png(filename = "plot4.png",width=720,height=480,units = "px")
g<-ggplot(df) +geom_col(aes(x=Year,y=Emissions,fill=Year),na.rm = TRUE)+facet_grid(.~Type)+labs(x="Year", y=expression("Total PM2.5 Emission (in Tons)")) +labs(title=expression("PM2.5 Emissions From Coal Combustion-Related Sources by Source Type"))+ylim(c(0.00,14274.48))
print(g)

## Closing png device
dev.off()