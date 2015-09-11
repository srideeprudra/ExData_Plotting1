
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

## Plotting Time Series

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
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.copy(png, "plot3.png")
dev.off()