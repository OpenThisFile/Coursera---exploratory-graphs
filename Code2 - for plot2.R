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
power4$Clock <- paste(power4$Date,power4$Time)  
timefix <- ymd_hms(power4$Clock)
power4[10] <-c(timefix)
png(filename = "plot2.png",width = 480, height = 480)
plot(power4$Clock,power4$Global_active_power,type="l",na.omit=TRUE,xlab="",ylab="Global_Active_Power(kilowatts)")  
dev.off()