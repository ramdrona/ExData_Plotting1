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
png("plot3.png",width=6.4,height=6.4,units="in",res=1200)

PlotDataPlot3 <- PowerConsumptionPlotData
with(PlotDataPlot3 , plot(factor(weekdays(as.Date(PlotDataPlot3$Date))), PlotDataPlot3$Sub_metering_1
                          , ylim=range(0, 40), col="black", ylab="Energy Sub metering"))
with(PlotDataPlot3 ,  points(factor(weekdays(as.Date(PlotDataPlot3$Date))), PlotDataPlot3$Sub_metering_2, col = "red"))
with(PlotDataPlot3, points(factor(weekdays(as.Date(PlotDataPlot3$Date))), PlotDataPlot3$Sub_metering_3, col = "blue"))
legend("topright", pch=1, col = c("black", "red", "blue") , legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
#++++++++++++++++++++++++++++++++++++++++++++