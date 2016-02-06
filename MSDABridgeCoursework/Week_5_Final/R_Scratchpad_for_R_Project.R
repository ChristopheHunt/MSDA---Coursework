
library(plyr)
library(lubridate)
library(ggplot2)

#set the data frame
df <- data.frame(hflights)

#sub set of observations where the flight was cancelled
cancelled_df <- subset(df, Cancelled == 1)

#create date column and drop redundant columns
cancelled_df$Date <- mdy(sprintf('%s %s %s', cancelled_df$Month, cancelled_df$DayofMonth,
                                 cancelled_df$Year))

#drop columns not needed
drop_col <- names(cancelled_df) %in% c("Year","Month", "DayofMonth",      
                                       "DepTime","ArrTime","ActualElapsedTime","AirTime",
                                       "ArrDelay","DepDelay","TaxiIn","TaxiOut","Diverted",
                                       "FlightNum","TailNum")

new_df <- cancelled_df[!drop_col]

#Maps the days to the name of the day
day_name <- c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
day_number <- c(1:7)
new_df$DayOfWeek <- as.factor(mapvalues(new_df$DayOfWeek, day_number, day_name))

#Map CancellationCode to factor
CCode <- c("A","B","C","D")
CName <- c("carrier","weather","national air system","security")
new_df$CancellationCode <- as.factor(mapvalues(new_df$CancellationCode, CCode,CName))

#verification of the data transformation
head(new_df)
summary(new_df)
colnames(new_df)

#cancellations over the year
sumdf <- data.frame(new_df$Date, new_df$Cancelled)
colnames(sumdf) <- c("Date","Cancelled")
head(sumdf)

x <- ddply(sumdf,~Date,summarise,"Count" = sum(Cancelled))

#plot the number of cancelled flights over 2011
ggplot(x, aes(x = Date, y = Count)) + geom_line() + xlab("Date of Flight") + ylab("# of Cancelled Flights") 

summary(x)

y <- subset(x, x$Count > 100) ###
y

#this brings up the question, what happened in feburary of 2011? Could it be weather related?
