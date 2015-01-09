# custom casting method to numerics
setClass("setNumeric")
setAs("character","setNumeric",function(from) as.numeric(from))

# read between line 66637 to 66636+2880, which has the Date 2007-1-1 to 2007-1-2
dd = read.csv2("../household_power_consumption.txt",skip=66636,nrows=2880,skipNul=TRUE,comment.char = "",na.strings='?',stringsAsFactors=FALSE, colClasses=c("Date",NA,rep("setNumeric",7)),col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Open PNG device
png(file="plot1.png", width=480, height=480, units="px")

# Generate Histogram
hist(dd$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

# Write to file
dev.off()
