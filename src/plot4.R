    #install.packages("ggplot2")
    library("ggplot2")


    ### Download and extract the data file
    
    
    zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(zip_url, "ex_data_hpc.zip")
    unzip("ex_data_hpc.zip")
    
    td <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
    
    plot_data <- subset(td, as.Date(Date, format="%d/%m/%Y") == as.Date("01/02/2007", format="%d/%m/%Y") 
                    | as.Date(Date, format="%d/%m/%Y") == as.Date("02/02/2007", format="%d/%m/%Y") )
    plot_data$DT <- as.POSIXct(paste0(plot_data$Date, ":", plot_data$Time),format='%d/%m/%Y:%H:%M:%S')
    
    rm(td)

    dev.new(width = 480, height = 480, unit = "px")
    par(mar=c(5.1, 5.1, 4.1, 2.1))
    par(mfrow=c(2,2))
    plot(plot_data$DT, as.numeric(plot_data$Global_active_power)/1000, 
                             type = "l", lty = 1,  xlab="", ylab="Global Active Power (Kilowatts)")

    plot(plot_data$DT, as.numeric(plot_data$Voltage), type = "l", lty = 1,  xlab="datetime", ylab="Voltage")

    
    plot(plot_data$DT, as.numeric(plot_data$Sub_metering_1), type = "n", lty = 1, xlab="", ylab="Energy sub metering")

    lines(plot_data$DT, as.numeric(plot_data$Sub_metering_1),  lty = 1,  col="black")
    lines(plot_data$DT, as.numeric(plot_data$Sub_metering_2),  lty = 1,  col="red")
    lines(plot_data$DT, as.numeric(plot_data$Sub_metering_3),  lty = 1,  col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"), lty=1, bty = "n")    

    
    plot(plot_data$DT, as.numeric(plot_data$Global_reactive_power)/1000, type = "l", lty = 1,  xlab="datetime", ylab="Global_reactive_power")

     


    dev.copy(png, "plot4.png")
    dev.off()
    
    rm(plot_data)
    file.remove("ex_data_hpc.zip", "household_power_consumption.txt")