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
power4$Global_active_power <- as.numeric(as.character(power4$Global_active_power))
png(filename = "plot1.png",width = 480, height = 480)
hist(power4$Global_active_power,breaks=12, col="red",main="Global active power",xlab="Global active power(kilowatts)",yaxt="n") 
yticks <- seq(0, 1200, 200)
axis(2, at = yticks, labels = yticks, col.axis="black", las=2)
dev.off()
power4$Clock <- paste(power4$Date,power4$Time)  
timefix <- ymd_hms(power4$Clock)
power4[10] <-c(timefix)
png(filename = "plot2.png",width = 480, height = 480)
plot(power4$Clock,power4$Global_active_power,type="l",na.omit=TRUE,xlab="",ylab="Global_Active_Power(kilowatts)")  
dev.off()
#plot2 finito!
#becuase of our filtering we have some crazy values when using table
#at the variables Sub_metering, so we need to reassign the factor levels
#the values that are now present(in our data of these 2 days)
power4$Sub_metering_1 <- factor(power4$Sub_metering_1)
power4$Sub_metering_2 <- factor(power4$Sub_metering_2)
power4$Sub_metering_3 <- factor(power4$Sub_metering_3)
dev.off()
power4$Sub_metering_3 <- as.numeric(as.character(power4$Sub_metering_3))
png(filename = "plot3.png",width = 480, height = 480)
plot(power4$Clock,power4$Sub_metering_1, type="l", col="black",yaxt="n",pch="o",xlab="",ylab="Energy sub metering",)
yticks <- seq(0, 30, 10)
axis(2, at = yticks, labels = yticks, col.axis="black", las=1)
points(power4$Clock,power4$Sub_metering_2, type="l", col="red", pch="o")
points(power4$Clock, power4$Sub_metering_3, type="l",col="blue",pch="o")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),cex=0.55,lty=1,col=c("black","red","blue"))
dev.off()
table(power4$Sub_metering_1)
table(power4$Sub_metering_2)
power4$Clock
class(power4$Sub_metering_2)
power4$Voltage <- as.numeric(as.character(power4$Voltage))
power4$Global_reactive_power <- as.numeric(as.character(power4$Global_reactive_power))
png(filename = "plot4.png",width = 480, height = 480)
par("mar")
par(mfrow = c(2, 2),oma = c(1, 1, 1, 1),mar = c(2.1, 2.2, 0.0, 1.8),mgp = c(1.2, 0.5, 0.0))
attach(power4)
plot(Clock,Global_active_power,type="l",ylab="Global Active Power",xlab="",cex.lab=0.7,cex.axis=0.6)
plot(Clock,Voltage,xlab="datetime",ylab="Voltage",type="l",cex.lab=0.7,cex.axis=0.6)
plot(power4$Clock, power4$Sub_metering_1, type="l", col="black", pch="o",yaxt="n",xlab="",ylab="Energy sub metering",cex.lab=0.7,cex.axis=0.5)
yticks <- seq(0, 30, 10)
axis(2, at = yticks, labels = yticks, col.axis="black", las=2)
points(power4$Clock,power4$Sub_metering_2, type="l", col="red", pch="o")
points(power4$Clock, power4$Sub_metering_3, type="l",col="blue",pch="o")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),cex=0.4,lty=1,col=c("black","red","blue"))
plot(Clock,Global_reactive_power,type="s",cex.lab=0.7,cex.axis=0.5,xlab="datetime")

dev.off()
                                    
                                    
                                    
                                    
                                    
                                    