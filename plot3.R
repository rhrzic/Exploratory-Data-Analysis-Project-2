#We load some useful packages
require(ggplot2)

##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")

##We manipulate the dataset to set the factors
baltimore <- subset(NEI, fips=="24510")
baltimore$type <- as.factor(baltimore$type)

##We calculate the aggregate emissions totals by year and by type
baltimore_aggregate <- with(baltimore, aggregate(baltimore$Emissions, by=list(year, type), FUN=sum, na.rm=FALSE))
names(baltimore_aggregate) <- c("year", "type", "emissions")

##We plot a facet grid plot using type as disciminator
png("plot3.png")

ggplot(baltimore_aggregate, aes(x=factor(year), y=emissions))+geom_bar(stat="identity",aes(fill=type))+facet_grid(type~.)+ylab("Total PM2.5 emitted (tons)")+xlab("Year")+ggtitle("Total PM2.5 emitted by type, Baltimore City")

dev.off()