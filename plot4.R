## Get the data from the zipped file
## Assuming the file is in the current working directory

datafile<-unzip("exdata-data-household_power_consumption.zip")

mydata<-read.table(datafile,header=TRUE,sep=";", as.is=FALSE, na.strings=c("",NA,"?"), stringsAsFactors=FALSE)

## Subset the data frame mydata to get the data for 1ts and 2nd February 2007

feb12data <- subset(mydata, grepl("^[1-2]/2/2007", mydata$Date), value = TRUE, perl = TRUE)

## A very very very stupid way top build a DateTime column!!!

## Force factors to columns
feb12data$Date <- as.character(feb12data$Date)
feb12data$Time <- as.character(feb12data$Time)

## Build a DataTime column       <===========  very very dumb but it works!!
datecol <- dmy(feb12data$Date)
feb12data$Posixdate <- datecol
datecol <- paste(datecol, feb12data$Time)
feb12data$DateTime <- strptime(datecol, "%Y-%m-%d %H:%M:%S" )



## Plot all four plots on one set of axes.

png("plot4.png",width=480,height=480,units='px')

## Set the four plot areas
par(mfrow = c(2,2))

##Plot the Active Power
plot(feb12data$DateTime, feb12data$Global_active_power, main = "", xlab = "", ylab=" Global Active Power (kilowatts)", type = "l", col = "Black")

##Plot the Voltage
plot(feb12data$DateTime, feb12data$Voltage, main = "", xlab = "datetime", ylab="Voltage", type = "l", col = "Black")

## Plot the three Sub metering plots
plot(feb12data$DateTime, feb12data$Sub_metering_1, main = "", xlab = "datetime", ylab="Energy sub metering", type = "l", col = "Black")
lines(x = feb12data$DateTime, y = feb12data$Sub_metering_2, type = "l",  col ="Red" ) ## Add the Sub 2 metering
lines(x = feb12data$DateTime, y = feb12data$Sub_metering_3, type = "l",  col ="Blue" ) ## Add the Sub 3 metering

##Put in a legend with no border
legend("topright" , c("Sub_metering_1 ","Sub_metering_2","Sub_metering_3"),        
       lty=c(1,1,1), bty="n", lwd=c(2.5,2.5,2.5),col=c("black", "red","blue")) 

##The Reactive Power plot
plot(feb12data$DateTime, feb12data$Global_reactive_power, main = "", xlab = "datetime", ylab="Global_reactive_power", type = "l", col = "Black")


dev.off()



