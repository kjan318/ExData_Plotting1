library(data.table)

path <- getwd()

#Loading data from defined file path & file name
dt_poweruse <- fread(file.path(path, "data/household_power_consumption.txt"), na.strings="?")


# Making a POSIXct date capable of being filtered and graphed by time of day
dt_poweruse[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


# To apply Filter to keep data between 2007-02-01 and 2007-02-02
dt_poweruse <- dt_poweruse[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

# setup plot space for 4 plots
par(mfcol = c(2,2))

#plot 1

with(dt_poweruse, plot(x = dateTime, y = Global_active_power,
                          type = "l", 
                          xlab = "",
                          ylab ="Global Active Power"))

#plot 2
with(dt_poweruse, plot(x = dateTime
                          ,y = Sub_metering_1,type = "l"
                          ,xlab = ""
                          ,ylab ="Energy sub metering"))

#draw red color line by using ""Sub_metering_2" variable value   
with(dt_poweruse, lines(x = dateTime, y = Sub_metering_2, col = "red" ))

#draw blue color line by using ""Sub_metering_3" variable value   
with(dt_poweruse, lines(x = dateTime, y = Sub_metering_3, col = "blue" ))

#To Create Legend
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 


#plot 3
with(dt_poweruse, plot(x = dateTime, y = Voltage,
                       type = "l", 
                       xlab = "",
                       ylab ="Voltage"))

#plot 4
with(dt_poweruse, plot(x = dateTime, y = Global_reactive_power,
                       type = "l", 
                       xlab = "",
                       ylab ="Global_reactive_power"))


dev.off()

# Clean enfironment variables
rm(list = ls())

