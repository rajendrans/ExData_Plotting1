     library(stats)
     library(dplyr)
     library("ggplot2")

     ### Read the data 
     NEI <- readRDS("summarySCC_PM25.rds")
     SCC <- readRDS("Source_Classification_Code.rds")
     
     coal_comb_scc <- SCC %>% 
            filter(grepl('Combustion', SCC.Level.One) & 
                   grepl('Coal', EI.Sector) ) %>% select(SCC, EI.Sector) 

     coal_comb_pm25 <- NEI %>% filter(SCC %in% coal_comb_scc$SCC) %>% 
                     group_by(SCC, year) %>% summarise(total=sum(Emissions))
    
     coal_comb_pm25 <- merge(coal_comb_pm25, coal_comb_scc, by = "SCC")
     coal_comb_pm25$EI.Sector <- gsub("-", "-\n", coal_comb_pm25$EI.Sector)
 
     dev.new(width = 1100, height = 900, unit = "px")
     ggplot(coal_comb_pm25, aes(x=year, y=total/1000))+
        geom_point(aes(shape = factor(EI.Sector), colour = factor(EI.Sector)), size = 4) + 
        labs(main="TERRE", color = "Coal combustion type", shape = "Coal combustion type")+
        theme(legend.spacing.x = unit(0.4, 'cm'),legend.spacing.y = unit(0.7, 'cm'),legend.text = element_text(margin = margin(t = 10))) +
        xlab("Year")+ylab("SCC PM2.5  ( in thousands ) ") +              
        ggtitle("Coal combustion PM2.5 in USA")
     
     ### copy to png image
     dev.copy(png, "plot4.png")
     dev.off()

     rm(NEI,SCC, coal_comb_pm25, coal_comb_scc  )
     