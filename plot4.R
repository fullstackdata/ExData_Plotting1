download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip");
hhAll <- read.table(unz("power.zip", "household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE);
datetime <- paste(hhAll$Date, hhAll$Time);
strptime(datetime, "%d/%m/%Y %H:%M:%S");
hhAll$datetime <- datetime;

hhAll$Date <- as.Date(hhAll$Date, format="%d/%m/%Y");

tgtDates <- as.Date(c('01/02/2007', '02/02/2007'), format="%d/%m/%Y");

hh <- with(hhAll, subset(hhAll, Date %in% tgtDates));
hh$datetime <- as.POSIXlt(hh$datetime, format="%d/%m/%Y %H:%M:%S"); 

png("plot1.png", width=480, height=480);
par(mfrow=c(2,2));
with(hh, plot(datetime,Global_active_power, type="o", col='black', pch="", xlab="", ylab="Global Active Power"));

with(hh, plot(datetime, Voltage, type="o", col='black', pch="", ylab="Voltage"));

with(hh, plot(datetime, Sub_metering_1,type="o", pch="", xlab="", ylab="Energy sub metering" , col="black"));
with(hh, lines(datetime, Sub_metering_2, type="o", pch="", col="red"));
with(hh, lines(datetime, Sub_metering_3, type="o", pch="", col="blue"));
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n");

with(hh, plot(datetime,Global_reactive_power, type="o", col='black', pch=""));

dev.off();


