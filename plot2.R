##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")

##Subsetting the baltimore data
baltimore <- subset(NEI, fips=="24510")

##Calculating the emissions totals
emission_totals <- tapply(baltimore$Emissions, baltimore$year, sum)

#Plotting the answer
plot(names(emission_totals), emission_totals, pch=20, col="darkgray", type="line", ylab="Total Emissions", xlab="Years", main="Baltimore")
points(names(emission_totals), emission_totals, pch=20, col="red")
