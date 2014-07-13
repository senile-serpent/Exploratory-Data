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


png("plot2.png",width=480,height=480,units='px')
plot(feb12data$DateTime, feb12data$Global_active_power, main = "", xlab = "", ylab=" Global Active Power (kilowatts)", type = "l", col = "Black")
dev.off()