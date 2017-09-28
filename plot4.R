library(dplyr)
library(tidyr)
library(lubridate)

### check of directory
# setwd("C:/R&Data")
# if (!file.exists("CourseProject")) {dir.create("CourseProject")}
# setwd("./CourseProject/")

### download and unzip data file
# fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileUrl, destfile = "./exdata%2Fdata%2Fhousehold_power_consumption")
# dateDownloaded<-date()
# unzip("./exdata%2Fdata%2Fhousehold_power_consumption")

### Set English language
# Sys.setlocale("LC_ALL", "English")

### reading the file
PartData<-read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?",  nrows = 100)
classes<-sapply(PartData, class)
# classes[[1]]<-"character"
# classes[[2]]<-"character"
AllData<-tbl_df(read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes))

### converting dates
AllData <- mutate(AllData, Date=dmy(Date))
# AllData <- mutate(AllData, Time=hms(Time))

### subset the portion of data frame
fdata<- filter(AllData, Date=="2007-02-01"|Date=="2007-02-02") %>%
  mutate(Time=hms(Time)) %>%
  mutate(datetime=as.POSIXct(Date+Time))


### creatin plot for file device

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

#1
plot(fdata$datetime, fdata$Global_active_power, xlab=NA, ylab="Global active power", type="l")

#2
plot(fdata$datetime, fdata$Voltage, xlab="datetime", ylab="Voltage", type="l")

#3
plot(fdata$datetime, fdata$Sub_metering_1, xlab=NA, ylab="Energy sub metering", type="l")
lines(fdata$datetime, fdata$Sub_metering_2, type="l", col="red")
lines(fdata$datetime, fdata$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")

#4
plot(fdata$datetime, fdata$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()







