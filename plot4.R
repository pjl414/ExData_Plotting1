#############
## Plot 1 ###
#############

# IMPORTANT! If you have not run the code in `GetAndCleanData.R`,
# please do that now so that you create the data we need for this
# plot!  Your working directory, if you've run the appropriate 
# code, should contain a text-file called `plot_data.txt`.

# Read data and format data
# In our next step, we pull in this data and do some 
# processing before writing to a csv.
feb_data<-read.table("plot_data.txt",sep=";",
                     header =TRUE)

#Some file processessing
library(lubridate)
library(tidyr)

# Combine the Date and Time variables, and format as a 
# Date-time variable using lubridate and tidyr.
feb_data<-unite(feb_data,
                "Date_time", 
                Date, Time,
                sep=",")
feb_data$Date_time<-dmy_hms(feb_data$Date_time)


# Plot 4
png("plot4.png",
    width = 480, height = 480)
par(mfrow = c(2,2))
par(mar=c(5,4,2,1))
with(feb_data,
     plot(Date_time, Global_active_power,
          type = 'l',
          ylab = "Global Active Power",
          xlab=""))
with(feb_data,
     plot(Date_time, Voltage,
          type = 'l',
          ylab = "Voltage",
          xlab="datetime"))
with(feb_data,{
  plot(Date_time, Sub_metering_1,
       type = 'n',
       ylab = "Energy sub metering",
       xlab= "")
  lines(Date_time, Sub_metering_1,
        col='black')
  lines(Date_time, Sub_metering_2,
        col='red')
  lines(Date_time, Sub_metering_3,
        col='blue')
  legend("topright",lty=1,
         legend=c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
         col=c('black','red','blue'),
         bty="n")
}
)
with(feb_data,
     plot(Date_time, Global_reactive_power,
          type = 'l',
          ylab = "Global_reactive_power",
          xlab="datetime"))
dev.off()
