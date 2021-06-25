library(data.table)

path <- getwd()

#to extract specific variables from file
featuresWanted <- c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3")
dt_EnergyMeter <- fread(file.path(path, "data/household_power_consumption.txt"), na.strings="?")[, featuresWanted, with = FALSE]


# Making a POSIXct date capable of being filtered and graphed by time of day
dt_EnergyMeter[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


# To apply Filter to keep data between 2007-02-01 and 2007-02-02
dt_EnergyMeter <- dt_EnergyMeter[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]


png("plot3.png", width=480, height=480)

# Plot 3

with(dt_EnergyMeter, plot(x = dateTime
                          ,y = Sub_metering_1,type = "l"
                          ,xlab = ""
                          ,ylab ="Energy sub metering"))

#draw red color line by using ""Sub_metering_2" variable value   
with(dt_EnergyMeter, lines(x = dateTime, y = Sub_metering_2, col = "red" ))

#draw blue color line by using ""Sub_metering_3" variable value   
with(dt_EnergyMeter, lines(x = dateTime, y = Sub_metering_3, col = "blue" ))

#To Create Legend
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))


dev.off()

# Clean enfironment variables
rm(list = ls())

