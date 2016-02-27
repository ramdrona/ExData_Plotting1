
setwd("D:/R_Dec2014/JH_DataSciences");
getwd()

pwrconsumptionfile <- "./DATA/household_power_consumption.txt"

# skip lines till grep("2007-02-01" and read 4500 lines afterwards
myDataTBL <- read.table(pwrconsumptionfile, header = TRUE, sep = ";"
                        ,skip=grep("1/2/2007", readLines("./DATA/household_power_consumption.txt")),nrows=4500
                        ,col.names= c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
                        ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric") )

# getting the logical vector for the conditional Date's required
goodset <-as.Date(myDataTBL$Date,"%d/%m/%Y") %in% c(as.Date("01/02/2007","%d/%m/%Y"), as.Date("02/02/2007","%d/%m/%Y"))
#head(myDataTBL , n=10L)
# Taking the subset of the actual data using conditional Dates logical vector
plotData <- myDataTBL[goodset,]
#head(plotData , n=10L)

# adding new Date file by merging date and Time fields in date format
plotData$newDate <- with(plotData, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

par(new=F)
par(mfrow=c(2,2))
# plot4 - Creating the png device file with rquired height & Width & Resolution
png("plot4new.png",width=6.4,height=6.4,units="in",res=1200)

#Global Active Power(kilowatts)
plot(plotData$Global_active_power~plotData$newDate,type="l", ylim=range(0, 8), ylab="Global Active Power (kilowatts)",xlab="")

#voltage
plot(plotData$Voltage~plotData$newDate,type="l",ylim=range(234, 246), ylab="voltage",xlab="datetime")

# Sub Metering 1 , 2, 3 plot
plot(plotData$Sub_metering_1~plotData$newDate , ylim=range(0, 40), type="l", col="black", ylab="Energy Sub metering",xlab="")
lines(plotData$Sub_metering_2~plotData$newDate, type="l", col = "red")
lines(plotData$Sub_metering_3~plotData$newDate, type="l", col = "blue")
legend("topright", pch=1, col = c("black", "red", "blue") , legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Global reactive power
plot(plotData$Global_reactive_power~plotData$newDate,type="l",ylim=range(0, 0.5), ylab="voltage",xlab="datetime")

dev.off()
