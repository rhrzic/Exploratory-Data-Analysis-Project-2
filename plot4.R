##We load some useful packages
require(ggplot2)

##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Then merge the datasets
dataset <- merge(NEI, SCC, by="SCC")

##Subsetting the Coal burning activities from SCC file
filter <- grep("Coal", dataset$EI.Sector)
coal_combustion <- dataset[filter,]

##We calculate the aggregate emissions totals by year and by type
coal_sums <- with(coal_combustion, aggregate(coal_combustion$Emissions, by=list(year), sum, na.rm=TRUE))
names(coal_sums) <- c("year", "emissions")

##We create the plot of emissiom totals for coal combustion nationwide
png("plot4.png")

ggplot(coal_sums, aes(x=factor(year), y=emissions))+geom_bar(stat="identity")+ylab("Total PM2.5 emitted (tons)")+xlab("Year")+ggtitle("Total PM2.5 emitted from Coal combustion, nationally")

dev.off()