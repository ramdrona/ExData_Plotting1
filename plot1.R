setwd("D:/R_Dec2014/JH_DataSciences");
getwd()

pwrconsumptionfile <- "./DATA/household_power_consumption.txt"

# skip lines till grep("2007-02-01" and read 4500 lines afterwards
pwrconsumptionTBL <- read.table(pwrconsumptionfile, header = TRUE, sep = ";"
                                ,skip=grep("1/2/2007", readLines("./DATA/household_power_consumption.txt")),nrows=4500
                                ,col.names= c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
                                ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric") )

pwrconsumptionTBL$Date <- as.Date(pwrconsumptionTBL$Date,"%d/%m/%Y")

# Taking exact subset from the data table for teh two days requested
PowerConsumptionPlotData <- subset(pwrconsumptionTBL, ((Date > "2007-01-31" )) & (Date < "2007-02-03"))

# creating the png device file for plotting
png("plot1.png",width=6.4,height=6.4,units="in",res=1200)
hist(pwrconsumptionTBL$Global_active_power, main="Global Active Power"
     , xlab="Global Active Power(kilowatts)",     col="red")
dev.off()
