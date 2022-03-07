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

## create the Plot4

##create a 4x4 field for the chart
par(mfrow=c(2,2))
plot(data$dt, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="" )

plot(data$dt, data$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(data$dt, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="" )
points(data$dt,data$Sub_metering_2, col="red", type="l")
points(data$dt,data$Sub_metering_3, col="blue", type="l")
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))

plot(data$dt, data$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")
##create the png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()