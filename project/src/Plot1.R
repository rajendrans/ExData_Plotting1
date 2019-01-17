     
     ### Read the data 
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")

     ### Calculate totalPM2.5 for each year

     total_pm25  <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))
     total_pm25 <- data.frame(year=names(total_pm25),total=total_pm25)
     
     rm(NEI)
     rm(SCC)

     ### plot the comparison
     barplot(total_pm25$total/1000, names.arg=total_pm25$year, 
           main="Total PM2.5 Comparison", 
           xlab="Year", 
           ylab="Total PM2.5 ( in thousands )" )
     
     ### copy to png image
     dev.copy(png, "plot1.png")
     dev.off()

     rm(total_pm25)
     