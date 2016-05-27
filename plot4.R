## Read data

library(sqldf)



DATA<-read.csv.sql("household_power_consumption.txt", sep=";",
                   sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')


## Transform time and date columns


dates<-DATA[,1]
times<-DATA[,2]
DateTime<-paste(dates,times)
DateTime<-strptime(DateTime, "%d/%m/%Y %H:%M:%S")

DATA<-cbind(DATA, DateTime)
DATA<-DATA[,-c(1,2)]

## Plotting
plot4.png<-png(file ="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
with(DATA, {
plot(DateTime, Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=" ")
plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering")
lines(DATA$DateTime, DATA$Sub_metering_2, col="red")
lines(DATA$DateTime, DATA$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})
dev.off()

