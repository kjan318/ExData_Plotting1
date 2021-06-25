library(data.table)


#Attribute Information:
  
#1.Date: Date in format dd/mm/yyyy
#2.time: time in format hh:mm:ss
#3.global_active_power: household global minute-averaged active power (in kilowatt)
#4.global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#5.voltage: minute-averaged voltage (in volt)
#6.global_intensity: household global minute-averaged current intensity (in ampere)
#7.sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#8.sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#9.sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

path <- getwd()

#to extract specific variables from file
featuresWanted <- c("Date","Global_active_power")
dt_activepower <- fread(file.path(path, "data/household_power_consumption.txt"))[, featuresWanted, with = FALSE]

# Change Date Column to Date Type
dt_activepower[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#Creating subset by applying criteria of date between 2007-02-01 and 2007-02-02
dt_07Feb_F2D <- subset(dt_activepower, Date >= ("2007-02-01") & (Date <= "2007-02-02"))

#covert "Global_active_power" to numberic 
dt_07Feb_F2D$Global_active_power <- as.numeric(dt_07Feb_F2D$Global_active_power)

png("plot1.png", width=480, height=480)

#Plotting with specific title, X lable, y lable 
hist(dt_07Feb_F2D$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

dev.off()
