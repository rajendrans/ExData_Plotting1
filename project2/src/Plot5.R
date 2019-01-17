     library(dplyr)
     library("ggplot2")

     ### Read the data 
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     
     BWI_pm25 <- NEI %>% filter(fips=="24510" &  ( type == "ON-ROAD" | type == "NON-ROAD" )) %>% 
                  group_by(year, type) %>% summarise(total=sum(Emissions))
   
     ggplot(BWI_pm25, aes(x=year, y=total))+
                geom_line()+
                geom_point()+
                facet_wrap(~type)+
                labs(x = "Year", 
                     y = "Total PM2.5", 
                     title="Vehicle PM2.5 in Baltimore city")
     
     ### copy to png image
     dev.copy(png, "plot5.png")
     dev.off()

     rm(NEI,SCC, BWI_pm25  )
     