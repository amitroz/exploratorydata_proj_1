library(chron)

#Unzip and read file
zip <- "exdata_data_household_power_consumption.zip"
txt <- "household_power_consumption.txt"

unzip(zip)
data <- read.table(txt,sep = ";",header = TRUE,stringsAsFactors = FALSE)

#clean Date for subsetting
data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")

#subsetting to required data
subdata <- subset(data,
                  Date == as.Date("01/02/2007",format = "%d/%m/%Y") 
                  | 
                      Date == as.Date("02/02/2007",format = "%d/%m/%Y")
)
#cleaning data
subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
subdata$Time <- chron(times = subdata$Time)
subdata$Fulldate <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%Y-%m-%d %H:%M:%S")

#plot 1
#create png device
png(file="plot1.png",width=480,height=480)

#create plot
hist(
    subdata$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red"
)
#switch device off
dev.off()