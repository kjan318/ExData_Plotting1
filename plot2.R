library(data.table)

path <- getwd()

#to extract specific variables from file
featuresWanted <- c("Date","Time","Global_active_power")
dt_activepower <- fread(file.path(path, "data/household_power_consumption.txt"), na.strings="?")[, featuresWanted, with = FALSE]


# Making a POSIXct date capable of being filtered and graphed by time of day
dt_activepower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


# To apply Filter to keep data between 2007-02-01 and 2007-02-02
dt_activepower <- dt_activepower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#covert "Global_active_power" to numberic 
dt_activepower$Global_active_power <- as.numeric(dt_activepower$Global_active_power)


png("plot2.png", width=480, height=480)

## Plot 2
with(dt_activepower, plot(x = dateTime, y = Global_active_power,
                          type = "l", 
                          xlab = "",
                          ylab ="Global Active Power (kilowatts)"))

dev.off()

# Clean enfironment variables
rm(list = ls())
