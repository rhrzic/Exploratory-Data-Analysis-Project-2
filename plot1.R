##We read in the files
NEI <- readRDS("summarySCC_PM25.rds")

##Calculating the emissions totals nationwide
emission_totals <- tapply(NEI$Emissions, NEI$year, sum)

#Plotting the answer
plot(names(emission_totals), emission_totals, pch=20, col="darkgray", type="line", ylab="Emission Totals", xlab="Years", main="National total emissions")
points(names(emission_totals), emission_totals, pch=20, col="red")