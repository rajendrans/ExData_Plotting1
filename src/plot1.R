    #install.packages("ggplot2")
    library("ggplot2")

    ### Download and extract the data file
    
    
    zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(zip_url, "ex_data_hpc.zip")
    unzip("ex_data_hpc.zip")
    
    td <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
    
    plot_data <- subset(td, as.Date(Date, format="%d/%m/%Y") == as.Date("01/02/2007", format="%d/%m/%Y") 
                    | as.Date(Date, format="%d/%m/%Y") == as.Date("02/02/2007", format="%d/%m/%Y") )

    rm(td)

    dev.new(width = 480, height = 480, unit = "px")
    hist(as.numeric(plot_data$Global_active_power)/1000, col="red",  ylim=c(0, 1200), 
                                        main="Global Active Power", xlab="Global Active Power (kilowatts)" )
    
    dev.copy(png, "plot1.png")
    dev.off()
    
    rm(plot_data)
    file.remove("ex_data_hpc.zip", "household_power_consumption.txt")