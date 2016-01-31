##We load some useful packages
require(ggplot2)
require(gridExtra)

##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for baltimore
baltimore <- subset(NEI, fips=="24510")
la <- subset(NEI, fips=="06037")

#Then merge the datasets
dataset_baltimore <- merge(baltimore, SCC, by="SCC")
dataset_la <- merge(la, SCC, by="SCC")

##Subsetting the vehicular activities from SCC file
filter <- grep("Vehicles", dataset_baltimore$EI.Sector)
vehicles_baltimore <- dataset_baltimore[filter,]

filter <- grep("Vehicles", dataset_la$EI.Sector)
vehicles_la <- dataset_la[filter,]

##We calculate the aggregate emissions totals by year and by type and calculate the annual differences in emissions totals
vehicle_sums_baltimore <- with(vehicles_baltimore, aggregate(Emissions, by=list(year), sum, na.rm=TRUE))
names(vehicle_sums_baltimore) <- c("year", "emissions")
for (i in 2:length(vehicle_sums_baltimore$emissions)) {
  print(i)
  diff <- vehicle_sums_baltimore$emissions[i] - vehicle_sums_baltimore$emissions[i-1]
  vehicle_sums_baltimore$annual_change[i] <- diff
}

vehicle_sums_la <- with(vehicles_la, aggregate(Emissions, by=list(year), sum, na.rm=TRUE))
names(vehicle_sums_la) <- c("year", "emissions")
for (i in 2:length(vehicle_sums_la$emissions)) {
  print(i)
  diff <- vehicle_sums_la$emissions[i] - vehicle_sums_la$emissions[i-1] 
  vehicle_sums_la$annual_change[i] <- diff
}

##We merge the datasets back together for plotting

vehicle_sums <- rbind(vehicle_sums_baltimore, vehicle_sums_la)
vehicle_sums <- cbind(vehicle_sums, rep(c("Baltimore City", "Los Angeles County"),each= 4))
names(vehicle_sums) <- c("year", "emissions", "annual_difference", "city")

##We create the plot of emissiom totals of vehicles for Baltimore and LA County and the annual difference in emissions in the row below
png("plot6.png")
p1 <- ggplot(vehicle_sums, aes(x=factor(year), y=emissions))+geom_bar(stat="identity")+facet_grid(.~city)+ylab("Total PM2.5 emitted (tons)")+xlab("Year")+ggtitle("Total PM2.5 emitted by Vehicles, Baltimore City vs Los Angeles County")
p2 <- ggplot(vehicle_sums, aes(x=factor(year), y=annual_difference))+geom_bar(stat="identity")+facet_grid(.~city)+ylab("Annual difference (tons)")+xlab("Year")
grid.arrange(p1, p2, nrow=2, ncol=1)
dev.off()
