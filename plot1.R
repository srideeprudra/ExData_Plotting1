
## Reading data from source for the required dates.
## Downloading data to temp file, unzipping & subsetting for required dates.

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
UCI <- subset(read.table(unz(temp, "household_power_consumption.txt"),sep = ";", header = TRUE),
              Date=="1/2/2007"|Date=="2/2/2007")
unlink(temp)

head(UCI)

## Creating Histogram 

hist((as.numeric(UCI$Global_active_power)), 
     col = "Red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power"
      )

dev.copy(png, "plot1.png")
dev.off()