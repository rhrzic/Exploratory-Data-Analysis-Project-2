#We load some useful packages
library(ggplot2)

##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")

##We manipulate the dataset to set the factors
baltimore <- subset(NEI, fips=="24510")
baltimore$type <- as.factor(baltimore$type)

##We calculate the aggregate emissions totals by year and by type
baltimore_aggregate <- with(baltimore, aggregate(baltimore$Emissions, by=list(year, type), FUN=sum, na.rm=FALSE))
names(baltimore_aggregate) <- c("year", "type", "emissions")

##We plot a facet plot using type as disciminator
ggplot(baltimore_aggregate, aes(x=year, y=emissions))+geom_point(aes(colour=type), size=3)+facet_grid(type~.)+ylab("Total Emissions")+xlab("Year")