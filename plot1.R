library(data.table)

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
