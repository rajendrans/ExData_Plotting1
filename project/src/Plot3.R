     library(dplyr)
     library("ggplot2")

     ### Read the data 
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     
     BWI_pm25 <- NEI %>% dplyr::filter(fips=="24510") %>% 
                  group_by(year, type) %>% summarise(total=sum(Emissions))
   
     ggplot(BWI_pm25, aes(x=year, y=total))+
                geom_line()+
                geom_point()+
                facet_wrap(~type)+
                labs(x = "Year", 
                     y = "Total PM2.5", 
                     title="Total PM2.5 in Baltimore city")
     
     ### copy to png image
     dev.copy(png, "plot3.png")
     dev.off()

     rm(NEI,SCC, BWI_pm25  )
     