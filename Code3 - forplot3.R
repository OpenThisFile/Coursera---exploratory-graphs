setwd("E:/ljubi/edukacija/Coursera/John Hopkins - Data Science Specialization/Exploratory data anaylsis")
list.files()
library(dplyr)
library(plyr)
library(tidyr)
library(lubridate)
library(xlsx)
power2 <- read.csv2("household_power_consumption.txt")
#with read.csv2 the colnames are automately separated, as with the values
#in other columns, which were separated by ;, this may vary depending
#on the table or file
colnames(power2)
power3 <-as.Date(parse_date_time(power2$Date,"dmy"))
#by parsing date time we can easily manipulate it by later filtering
#this may not be the best solution(because of reading all of the data
#multiple times)
power2[1] <- c(power3)
power4 <-power2 %>% filter(power2$Date >="2007-02-01" & power2$Date <="2007-02-02")
power4$Clock <- paste(power4$Date,power4$Time)  
timefix <- ymd_hms(power4$Clock)
power4[10] <-c(timefix)
power4$Sub_metering_1 <- factor(power4$Sub_metering_1)
power4$Sub_metering_2 <- factor(power4$Sub_metering_2)
power4$Sub_metering_3 <- factor(power4$Sub_metering_3)
power4$Sub_metering_1 <- as.numeric(as.character(power4$Sub_metering_1))
power4$Sub_metering_2 <- as.numeric(as.character(power4$Sub_metering_2))
power4$Sub_metering_3 <- as.numeric(as.character(power4$Sub_metering_3))
png(filename = "plot3.png",width = 480, height = 480)
plot(power4$Clock,power4$Sub_metering_1, type="l", col="black",yaxt="n",pch="o",xlab="",ylab="Energy sub metering",)
yticks <- seq(0, 30, 10)
axis(2, at = yticks, labels = yticks, col.axis="black", las=1)
dev.off()

points(power4$Clock,power4$Sub_metering_2, type="l", col="red", pch="o")
points(power4$Clock, power4$Sub_metering_3, type="l",col="blue",pch="o")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),cex=0.55,lty=1,col=c("black","red","blue"))






