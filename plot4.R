setwd("~/Data Science/Coursera/Data Science Foundation/Course 4 - Exploratory Data Analysis")

# Read in data file
household_power_consumption <- read.csv("~/Data Science/Coursera/Data Science Foundation/Course 4 - Exploratory Data Analysis/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

# take rows where the date is 1/2/2007 and 2/2/2007

Power_data<-household_power_consumption[(household_power_consumption$Date=="1/2/2007"|household_power_consumption$Date=="2/2/2007"),]

# DATA PREP

library("lubridate", lib.loc="~/R/win-library/3.1")

# Coerce Date and Time to respective date and time formats
Power_data$Date<-dmy(Power_data$Date)
Power_data$Time<-hms(Power_data$Time)

# Coerce remaining fields as numeric
Power_data$Voltage<-as.numeric(Power_data$Voltage)
Power_data$Global_active_power<-as.numeric(Power_data$Global_active_power)
Power_data$Global_reactive_power<-as.numeric(Power_data$Global_reactive_power)
Power_data$Global_intensity<-as.numeric(Power_data$Global_intensity)
Power_data$Sub_metering_1<-as.numeric(Power_data$Sub_metering_1)
Power_data$Sub_metering_2<-as.numeric(Power_data$Sub_metering_2)
Power_data$Sub_metering_3<-as.numeric(Power_data$Sub_metering_3)

# Create Day Column
Power_data$Day<-wday(Power_data$Date, label=TRUE)

# Create Date Time Column
Power_data$Date_Time<-Power_data$Date+Power_data$Time

# PLOTTING

# send plot to png device
png(file="Plot4.png", width = 480, height = 480)

# Set 2 by 2 plot multiplot
par(mfrow=c(2,2))

# Set margin default
par(mar=c(4,4,4,2))

# Set font size to .7 of magnitude of default
par(cex=.70)

# Start ploting
with(Power_data, {
  
  # Top Left Plot
  plot(Date_Time, Global_active_power, ylab="Global Active Power",xlab="",type = "n")
  lines(Date_Time, Global_active_power)
  
  # Top Right Plot
  plot(Date_Time, Voltage, ylab="Voltage",xlab="datetime",type = "n")
  lines(Date_Time, Voltage)
  
  # Bottom Left Plot 
  plot(Date_Time, Sub_metering_1, ylab="Energy sub metering",xlab="",type = "n")
  lines(Date_Time, Sub_metering_1)
  lines(Date_Time, Sub_metering_2, col="red")
  lines(Date_Time, Sub_metering_3, col="blue")
  # Add legend - bty controls border and text.width controls where text starts relative to right hand side
  legend("topright",lwd=1,col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty='n',cex=0.8, text.width = 60000)
  
  # Bottom Right Plot
  plot(Date_Time, Global_reactive_power, ylab="Global_reactive_power",xlab="datetime",type = "n")
  lines(Date_Time, Global_reactive_power)
})

# Turn PNG device off
dev.off()
