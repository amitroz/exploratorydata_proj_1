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

#plot 4
#create png device
png(file="plot4.png",width=480,height=480)

#set up 2x2 plot grid
par(mfrow=c(2,2))

with(subdata, plot(Global_active_power~Fulldate, type="n",ylab = "Global Active Power (kilowatts)"))
with(subdata,lines(Global_active_power~Fulldate))

with(subdata, plot(Voltage~Fulldate, type="n",ylab = "Voltage",xlab = "datetime"))
with(subdata,lines(Voltage~Fulldate))

with(subdata, plot(Sub_metering_1~Fulldate, type="n",ylab = "Energy sub metering"))
with(subdata,lines(Sub_metering_1~Fulldate))
with(subdata,lines(Sub_metering_2~Fulldate,col="red"))
with(subdata,lines(Sub_metering_3~Fulldate,col="blue"))
legend("topright",bty="n",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1)

with(subdata, plot(Global_reactive_power~Fulldate, type="n",xlab = "datetime"))
with(subdata,lines(Global_reactive_power~Fulldate))

#switch device off
dev.off()