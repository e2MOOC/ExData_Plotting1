# custom casting method
setClass("setNumeric")
setAs("character","setNumeric",function(from) as.numeric(from))

# read between line 66637 to 66636+2880, which has the Date 2007-1-1 to 2007-1-2
dd = read.csv2("../household_power_consumption.txt",skip=66636,nrows=2880,skipNul=TRUE,comment.char = "",na.strings='?',stringsAsFactors=FALSE, colClasses=c(NA,NA,rep("setNumeric",7)),col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

for (i in 1:length(dd$Date) ) 
{
  dd$Date[i] = paste(dd$Date[i],dd$Time[i])[1]
  
}

dd$Date = strptime(dd$Date,"%m/%d/%Y %H:%M:%S")

# Open PNG device
png(file="plot3.png", width=480, height=480, units="px")

# get the range for the x and y axis 
xrange = range(0,2880) 
yrange = range(dd$Sub_metering_1,dd$Sub_metering_3,dd$Sub_metering_3)
  
# plot graph
plot(xrange, yrange, type="n", xaxt="n", xlab="", ylab="Energy sub metering") 

# plot lines
lines(dd$Sub_metering_1, col="black", xlab="", ylab="Global_reactive_power")
lines(dd$Sub_metering_2, col="red")
lines(dd$Sub_metering_3, col="blue")

# add axis
axis(1, at=c(1, as.integer(nrow(dd)/2), nrow(dd)), labels=c("Thu", "Fri", "Sat"))

# add a legend 
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Write to file
dev.off()