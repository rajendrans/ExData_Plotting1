     library(dplyr)

     ### Read the data 
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")

     ### Calculate totalPM2.5 for each year for Baltimore city

     BWI_pm25  <- NEI %>% filter(fips=="24510") %>% 
                          with(tapply(Emissions, year, sum, na.rm=TRUE))
     BWI_pm25 <- data.frame(year=names(BWI_pm25),total=BWI_pm25)
     
     rm(NEI)
     rm(SCC)

     ### plot the comparison
     barplot(BWI_pm25$total, names.arg=BWI_pm25$year, 
           main="Total PM2.5 in Baltimore city", 
           xlab="Year", 
           ylab="Total PM2.5" )
     
     ### copy to png image
     dev.copy(png, "plot2.png")
     dev.off()

     rm(BWI_pm25)
     