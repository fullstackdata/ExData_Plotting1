download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip");
hhAll <- read.table(unz("power.zip", "household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE);
datetime <- paste(hhAll$Date, hhAll$Time);
strptime(datetime, "%d/%m/%Y %H:%M:%S");
hhAll$datetime <- datetime;

hhAll$Date <- as.Date(hhAll$Date, format="%d/%m/%Y");

tgtDates <- as.Date(c('01/02/2007', '02/02/2007'), format="%d/%m/%Y");

hh <- with(hhAll, subset(hhAll, Date %in% tgtDates));
hh$datetime <- as.POSIXlt(hh$datetime, format="%d/%m/%Y %H:%M:%S"); 

png("plot2.png", width=480, height=480);
with(hh, plot(datetime,Global_active_power, type="o", col='black', pch="", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off();

