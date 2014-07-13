## Get the data from the zipped file
## Assuming the file is in the current working directory

datafile<-unzip("exdata-data-household_power_consumption.zip")

mydata<-read.table(datafile,header=TRUE,sep=";", as.is=FALSE, na.strings=c("",NA,"?"), stringsAsFactors=FALSE)

## Subset the data frame mydata to get the data for 1ts and 2nd February 2007

feb12data <- subset(mydata, grepl("^[1-2]/2/2007", mydata$Date), value = TRUE, perl = TRUE)

## Draw the first plot as a png file

png("plot1.png",width=480,height=480,units='px')
hist(feb12data$Global_active_power, xlab=" Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")
dev.off()

