library(dplyr)
library(lubridate)
library(tidyr)
library(datasets)


Energy<- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      "./energy", mode="wb")

consumption <- read.csv("C:/Users/yakir/Downloads/household_power_consumption.txt",quote="",na.strings="?",sep=";", header=TRUE,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

consumption1 <- consumption %>% mutate(Date=as.Date(Date,format="%d/%m/%Y"))

consumption2 <- consumption1 %>%
  filter(Date=="2007-02-02" | Date == "2007-02-01")

consumption3 <- transform(consumption2, Date_Time=paste(Date, Time, sep=" "))

consumption4 <- consumption3 %>% mutate(Date_Time=as.POSIXct(strptime(Date_Time, format = "%Y-%m-%d %H:%M:%S", tz = "")))


##plot 4
par(mfrow=c(2,2))
with(consumption4, {
  plot(consumption4$Date_Time,consumption4$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
  plot(consumption4$Date_Time,consumption4$Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(consumption4$Date_Time,consumption4$Sub_metering_1,type="l",ylab="Energy sub Metering",xlab="",col="black")+
    points(consumption4$Date_Time,consumption4$Sub_metering_2,col="red",type="l")+
    points(consumption4$Date_Time,consumption4$Sub_metering_3,col="blue",type="l")+
    legend("topright", cex=0.7,lwd= c(1,1,1),col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(consumption4$Date_Time,consumption4$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
  
})
dev.copy(png, file="Plot 4.png")





dev.off()

