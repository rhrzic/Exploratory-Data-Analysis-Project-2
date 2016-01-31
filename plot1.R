#We load some useful packages
library(ggplot2)
library(dplyr)

##We read in the files

NEI <- readRDS("summarySCC_PM25.rds")

emission_totals <- tapply(NEI$Emissions, NEI$year, sum)

plot(names(emission_totals), emission_totals, pch=20, col="darkgray", type="line", ylab="Emission Totals", xlab="Years", main="National total emissions")
points(names(emission_totals), emission_totals, pch=20, col="red")