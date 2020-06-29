# Download and unzip dataset if the dataset is not in the working directory
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata_data_household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"


if (!file.exists(zipFile)) {
    download.file(url = zipURL, destfile = zipFile, method = "curl")}
if (!file.exists(dataFile)) {
    unzip(zipFile)}

# Load dataset - only rows ranging from 2007-02-01 and 2007-02-02
    # 60 min * 24 hours * 2 days = 2880 rows
data <- read.table("household_power_consumption.txt", 
                   sep = ";", header=FALSE, na.strings = "?", skip = 66637, nrows = 2880)

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                 "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Set Date and Time format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date,data$Time), format="%Y-%m-%d %H:%M:%S")

# Create a 4-panel plot
par(mfrow = c(2,2), mar=c(4,4,2,2))

# plot1
plot(data$Time, data$Global_active_power, type="l", xlab = "", ylab="Global Active Power")

#plot2
plot(data$Time, data$Voltage, type="l", xlab = "datetime", ylab="Voltage")

#plot3
plot(data$Time, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(data$Time, data$Sub_metering_2, type="l", col="red")
lines(data$Time, data$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       bty ="n", lty = 1, col = c("black","red","blue"))

#plot4
plot(data$Time, data$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power")

# print plot
dev.print(png, "plot4.png", width = 480, height = 480)
