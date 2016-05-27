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
plot2.png<-png(file ="plot2.png", width=480, height=480, units="px")
plot(DATA$DateTime, DATA$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=" ")
dev.off()
