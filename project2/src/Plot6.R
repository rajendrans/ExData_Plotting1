     library(dplyr)
     library("ggplot2")

     ### Read the data 
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     
     vehi_pm25 <- NEI %>% filter((fips=="06037" | fips=="24510") &  ( type == "ON-ROAD" | type == "NON-ROAD" )) %>% 
                  group_by(fips, year, type) %>% summarise(total=sum(Emissions))
     
     cities <- c( "06037" = "Los Angeles County",
                   "24510"  = "Baltimore city")
                  
   
     ggplot(vehi_pm25, aes(x=year, y=total, colour=type))+
                geom_line()+
                geom_point()+
                facet_wrap(~fips, labeller = as_labeller(cities))+
                labs(x = "Year", 
                     y = "PM2.5", 
                     title="Vehicle PM2.5")
     
     ### copy to png image
     dev.copy(png, "plot6.png")
     dev.off()

     rm(NEI,SCC, BWI_pm25  )
     