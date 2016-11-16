# Coursera: Exploratory Data Analysis, Project 1

# 1. Setup 
# ------------------------------------------------------------

# Clean up workspace, set wd
rm(list=ls())
setwd("~/.Coursera/04 Exploratory Data Analysis/Project 1/")

# 2. Get Data into R
# ------------------------------------------------------------

# Download the zip file from the web to destfile called "temp"
# **Use mode="wb"** when downloading zip files!!!!
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "temp", mode="wb")

# Unzip "temp". This produces the file "household_power_consumption.txt"
unzip("temp")

# Read "household_power_consumption.txt" into R. Assign to H
H <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE)

# 3. Wrangle the Data
# ------------------------------------------------------------

# View STRUCTURE of H
str(H)
# We see this is a data.frame of 2075259 obs of 9 vars
# All vars are class chr (except one)
# The first 2 cols are Date and Time, both are class chr

# SUBSET obs from just the two dates we want from H. Assign to S.
S <- H[H$Date %in% c("1/2/2007","2/2/2007"), ]
# Using dim() we see that the subset has just 2880 obs
dim(S)

# We need to change the CLASS of several vars 
# from to char to numeric in order to build necessary plots
GAP <- as.numeric(S$Global_active_power)
GRP <- as.numeric(S$Global_reactive_power)
Volt <- as.numeric(S$Voltage)
SM1 <- as.numeric(S$Sub_metering_1)
SM2 <- as.numeric(S$Sub_metering_2)
SM3 <- as.numeric(S$Sub_metering_3)

# Paste together the Date and Time cols,
# then change its CLASS to POSIXlt with strptime,
# then assign to DT
DT <- strptime(paste(S$Date, S$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
class(DT)

# 4. Build Plots
# ------------------------------------------------------------

# Build 3-line plot of 3 submetering vectors with png device
png("plot3.png", width=480, height=480)
plot(DT, SM1, type="l", ylab="Energy sub metering", xlab="")
lines(DT, SM2, type="l", col="red")
lines(DT, SM3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=1, col=c("black", "red", "blue"))
dev.off()
