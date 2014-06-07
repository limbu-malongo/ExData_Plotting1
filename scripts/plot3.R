#This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for 
#machine learning datasets. In particular, we will be using the “Individual household electric power 
#consumption Data Set” which I have made available on the course web site:
#Dataset: Electric power consumption [20Mb]
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
#Unzip the downloaded data to the working folder and make sure the file name is
#household_power_consumption.txt


#Loading the data
#Calculating Memory Requirements
#https://github.com/jtleek/modules/blob/master/02_RProgramming/reading_data_I/index.md

#Data frame with 2,075,259 rows and 9 columns, 
#assumption ==> all of which are numeric and as.Date (each numeric data and as.Date occupy 8 bytes of memory). Roughly, 
#how much memory is required to store this data frame?


#2,075,259 × 9 × 8 bytes/numeric

#Uncomment the following if you want to prove the value above
#2075259*9*8 #bytes

# = 149,418,648 bytes

#2075259*9*8/2^{20} ## Megabytes

#Hence the space in memory required to handle the data frame is 142.4967 Megabytes

#Reading large tables into R
#If you are interested to know how this trick works follow the link below
#http://www.biostat.jhsph.edu/~rpeng/docs/R-large-tables.html
#
#Reading the first 5 rows so that to determine the classes of the columns
#Missing values are coded as ? hence the option ==> na.strings = '?'

housepowercons5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?', nrows = 5)
classes <- sapply(housepowercons5rows, class)

#Reading all the rows with colClasses option to improve perfomance of reading

housepowercons <- read.table("household_power_consumption.txt", header = TRUE, colClasses = classes, sep = ";", na.strings = '?')

#Remove housepowercons5rows, its job is over
rm("housepowercons5rows")

#Examining the data frame housepowercons

#The dataset has 2,075,259 rows and 9 columns.
dim(housepowercons)

names(housepowercons)
str(housepowercons)
head(housepowercons)
summary(housepowercons)
head(housepowercons)
tail(housepowercons)

#We will only be using data from the dates 2007-02-01 and 2007-02-02
#Coverting the Date variable to Date class
housepowercons$Date <- as.Date(housepowercons$Date, format='%d/%m/%Y')
class(housepowercons$Date)

#Subsetting data for dates 2007-02-01 and 2007-02-02
sub_housepowercons = housepowercons[(housepowercons$Date==as.Date('2007-02-01')|housepowercons$Date==as.Date('2007-02-02')),]
head(sub_housepowercons)
tail(sub_housepowercons)

#Creating the variable for x-axis
#Create another variable datetime which combines Date and Time
sub_housepowercons$datetime = paste(sub_housepowercons$Date, sub_housepowercons$Time)
class(sub_housepowercons$datetime)
head(sub_housepowercons$datetime)

#Setting the class of datetime variable to POSIX date/time
sub_housepowercons$datetime = strptime(sub_housepowercons$datetime, format = '%Y-%m-%d %H:%M:%S')
class(sub_housepowercons$datetime)
head(sub_housepowercons$datetime)

timeintervals=as.POSIXct(sub_housepowercons$datetime)
timeintervals=seq(as.POSIXct("2007-02-01 00:00:00"),by="min",length.out=length(sub_housepowercons$datetime))
tail(timeintervals)


#Ploting the plot3 on screen device
with(sub_housepowercons, plot(timeintervals, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(sub_housepowercons, points(timeintervals, Sub_metering_2, type='l', col = "red"))
with(sub_housepowercons, points(timeintervals, Sub_metering_3, type='l', col = "blue"))
legend("topright",lty="solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#Generating and Saving to png fomart
png(file = "plot3.png", width = 480, height = 480) ## Open PDF device; create 'plot1.png' in my working directory
with(sub_housepowercons, plot(timeintervals, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(sub_housepowercons, points(timeintervals, Sub_metering_2, type='l', col = "red"))
with(sub_housepowercons, points(timeintervals, Sub_metering_3, type='l', col = "blue"))
legend("topright",lty="solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the PDF file device