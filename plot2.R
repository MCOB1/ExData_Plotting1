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

# Build 1-line plot of GAP with png device
png("plot2.png", width=480, height=480)
plot(DT, GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

