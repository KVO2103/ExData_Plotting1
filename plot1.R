## Neccessary Packages
library(plyr)
library(dplyr)

## Read in Data

## create a folder for the data
if(!file.exists("./ExploratoryDataAnalysis")){dir.create("./ExploratoryDataAnalysis")}

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./ExploratoryDataAnalysis/exdata_data_household_power_consumption.zip")
unzip("./ExploratoryDataAnalysis/exdata_data_household_power_consumption.zip", exdir = "./Data")


##Check size of the file
file.info("./Data/household_power_consumption.txt")

hpc<-read.table("./Data/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## combine date and time as Dates
hpc$dt<- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

## save Date as Date
hpc$Date<-as.Date(hpc$Date, "%d/%m/%Y")

##Create a subset for the 1st and 2nd February 2007
data<-subset(hpc, Date=="2007-02-01"| Date=="2007-02-02")

## create the Plot1

pic<-hist(data$Global_active_power, col="red", main=" Global Acitve Power", xlab=" Global Active Power (kilowatts)", ylab="Frequency")

##create the png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()