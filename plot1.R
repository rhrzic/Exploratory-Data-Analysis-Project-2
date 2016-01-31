##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")

##Calculating the emissions totals nationwide
emission_totals <- tapply(NEI$Emissions, NEI$year, sum)

#Plotting the answer
png("plot1.png")

plot(names(emission_totals), emission_totals, pch=20, col="darkgray", type="line", ylab="Total PM2.5 emitted (tons)", xlab="Year", main="Total PM2.5 emitted, nationally")
points(names(emission_totals), emission_totals, pch=20, col="red")

dev.off()