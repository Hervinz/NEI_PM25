####This code reads a data set from he National Emissions Inventory (NEI).
#This database is known as the National Emissions Inventory (NEI).
#this is the information about emissions of fine particulate matter PM2.5.
#The goal is to explore the National Emissions Inventory database 
#and see what it say about fine particulate matter pollution in the United states 
#over the 10-year period 1999-2008.  


####DONWLOADING, UNZIPPING AND READING FILES
if(!file.exists("./summarySCC_PM25.rds")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url = fileUrl, destfile = "data_PM25_emissions.zip")
        unzip(zipfile = "data_PM25_emissions.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



##########################################################################################
##########################################################################################
## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all
#sources for each of the years 1999, 2002, 2005, and 2008.

yr1999 <- NEI[with(NEI, year == 1999),4]
yr2002 <- NEI[with(NEI, year == 2002),4]
yr2005 <- NEI[with(NEI, year == 2005),4]
yr2008 <- NEI[with(NEI, year == 2008),4]

summary(yr1999)
summary(yr2002)
summary(yr2005)
summary(yr2008)

##Both the mean and the maximum value of the different samples
#allow us to supous that there is a reduction in the total PM25 
#particulate material in the course of 1999, 2002, 2005 and 2008, 
#it is possible also be seen in the boxplot, especially in the logarithmic base 10 boxplot.

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
#boxplot(yr1999, yr2002, yr2005, yr2008)
boxplot(log10(yr1999), log10(yr2002), log10(yr2005), log10(yr2008))

#Close png file
dev.off() 


