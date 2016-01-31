#We load some useful packages
library(ggplot2)
library(dplyr)

##We read in the files

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips=="24510")
emission_totals <- tapply(baltimore$Emissions, baltimore$year, sum)

plot(names(emission_totals), emission_totals, pch=20, col="darkgray", type="line", ylab="Emission Totals", xlab="Years", main="Baltimore total emissions")
points(names(emission_totals), emission_totals, pch=20, col="red")
