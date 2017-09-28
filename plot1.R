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

### reading the file
PartData<-read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?",  nrows = 100)
classes<-sapply(PartData, class)
# classes[[1]]<-"character"
# classes[[2]]<-"character"
AllData<-tbl_df(read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes))


### converting dates into POSIXlt
AllData <- mutate(AllData, Date=dmy(Date))
# AllData <- mutate(AllData, Time=hms(Time))

### subset the portion of data frame
fdata<- filter(AllData, Date=="2007-02-01"|Date=="2007-02-02")

### creatin plot for file device
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(fdata$Global_active_power, main="Global active power", xlab="Global active power (kilowatts)", col="red")
dev.off()







