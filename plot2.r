# set working directory - Change it to match yours
setwd("C:/Users/jbuehler/Desktop/Coursera/04 Exploratory Data Analysis/Projects")


# make sure the Files folder exists
if (!file.exists("Files")) {
  dir.create("Files")
}

# check to see if the zip file exists
if (!file.exists("Files/power_consumption.zip")) {
  
  # download power_consumption.zip file and unzip
  file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file.url,destfile="Files/power_consumption.zip")
  unzip("Files/power_consumption.zip", exdir="Files", overwrite=TRUE)
}


  # read the raw table and limit to 2 designated days
  hpc <- read.table("Files/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")  
  hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
 
  hpc_subset <- hpc[(hpc$Date=="2007-02-01") | (hpc$Date=="2007-02-02"),] 
  
  hpc_subset$Global_active_power <- as.numeric(as.character(hpc_subset$Global_active_power))
  hpc_subset$Global_reactive_power <- as.numeric(as.character(hpc_subset$Global_reactive_power))
  hpc_subset$Voltage <- as.numeric(as.character(hpc_subset$Voltage))
  hpc_subset <- transform(hpc_subset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
  hpc_subset$Sub_metering_1 <- as.numeric(as.character(hpc_subset$Sub_metering_1))
  hpc_subset$Sub_metering_2 <- as.numeric(as.character(hpc_subset$Sub_metering_2))
  hpc_subset$Sub_metering_3 <- as.numeric(as.character(hpc_subset$Sub_metering_3))



# Generating Plot 2
  plot(hpc_subset$timestamp,hpc_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="Files/plot2.png", width=480, height=480)
  dev.off()
