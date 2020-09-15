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
## 2. Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510" | fips == "24510") from 1999 to 2008?
#Use the base plotting system to make a plot answering this question.

BC_Mryld <- NEI[with(NEI, fips == "24510"),]
BMyr1999 <- BC_Mryld[with(BC_Mryld, year == 1999),4]
BMyr2002 <- BC_Mryld[with(BC_Mryld, year == 2002),4]
BMyr2005 <- BC_Mryld[with(BC_Mryld, year == 2005),4]
BMyr2008 <- BC_Mryld[with(BC_Mryld, year == 2008),4]

summary(BMyr1999)
summary(BMyr2002)
summary(BMyr2005)
summary(BMyr2008)

##Both the mean and the maximum value of the different samples
# don´t allow us to supous that there is a reduction in the total PM25 
#particulate material in the course of 1999, 2002, 2005 and 2008-
#It seems in year 2005 there wasn't a reduction with respect to year 2002.

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
boxplot(BMyr1999, BMyr2002, BMyr2005, BMyr2008)
boxplot(log10(BMyr1999), log10(BMyr2002), log10(BMyr2005), log10(BMyr2008))

#Close png file
dev.off() 


