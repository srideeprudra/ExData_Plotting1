
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

plot(UCI$DateTime, UCI$Global_active_power, typ = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, "plot2.png")
dev.off()