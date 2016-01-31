##We load some useful packages
require(ggplot2)

##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for baltimore
baltimore <- subset(NEI, fips=="24510")

#Then merge the datasets
dataset <- merge(baltimore, SCC, by="SCC")

##Subsetting the Vehicular activities from SCC file
filter <- grep("Vehicles", dataset$EI.Sector)
vehicles <- dataset[filter,]

##We calculate the aggregate emissions totals by year and by type
vehicle_sums <- with(vehicles, aggregate(Emissions, by=list(year), sum, na.rm=TRUE))
names(vehicle_sums) <- c("year", "emissions")

##We create the plot of emissiom totals for coal combustion nationwide
png("plot5.png")

ggplot(vehicle_sums, aes(x=factor(year), y=emissions))+geom_bar(stat="identity")+ylab("Total PM2.5 emitted (tons)")+xlab("Year")+ggtitle("Total PM2.5 emitted by Vehicles, Baltimore City")

dev.off()