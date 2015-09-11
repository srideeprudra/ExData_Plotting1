
## Reading data from source for the required dates.
## Downloading data to temp file, unzipping & subsetting for required dates.

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
UCI <- subset(read.table(unz(temp, "household_power_consumption.txt"),sep = ";", header = TRUE),
              Date=="1/2/2007"|Date=="2/2/2007")
unlink(temp)

head(UCI)

## Concatenate Date/Time for appropriate/continuous plotting

UCI$DateTime <- with(UCI, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

## Setting plotting grid & margins

par(mfcol= c(2,2))

## Plotting Time Series - DateTime vs. Global Active Power

plot(UCI$DateTime, UCI$Global_active_power, typ = "l", 
     ylab = "Global Active Power", xlab = "")

## Plotting Time Series - DateTime vs Sub metering

plot(UCI$DateTime, UCI$Sub_metering_1, 
     typ = "l", ylab = "Energy Sub Metering", xlab = "", ylim = c(0,40))
par(new=TRUE)
plot(UCI$DateTime, UCI$Sub_metering_2, 
     typ = "l", ylab = "Energy Sub Metering", xlab = "", ylim = c(0,40), col="Red")
par(new=TRUE)
plot(UCI$DateTime, UCI$Sub_metering_3, 
     typ = "l", ylab = "Energy Sub Metering", xlab = "", ylim = c(0,40), col="Blue")

legend("topright",
       col = c("black", "Red", "Blue"),
       pch = "-",
       cex = 0.4,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

## Plotting Time Series - DateTime vs. Voltage

plot(UCI$DateTime, UCI$Voltage, typ = "l", 
     ylab = "voltage", xlab = "datetime")

## Plotting Time Series - DateTime vs. Global Reactive Power

plot(UCI$DateTime, UCI$Global_reactive_power, typ = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, "plot4.png")
dev.off()