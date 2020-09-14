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





##########################################################################################
##########################################################################################
## 3. Of the four types of sources indicated by the type
#(point, nonpoint, onroad, nonroad) variable, which of these four sources
#have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 
#plotting system to make a plot answer this question.

library(ggplot2)
unique(BC_Mryld$type)
BC_Mryld$type <- as.factor(BC_Mryld$type)

PM25_S.POINT <- BC_Mryld[BC_Mryld[,5]=="POINT",c(4,6)]
PM25_S.NONPOINT <- BC_Mryld[BC_Mryld[,5]=="NONPOINT",c(4,6)]
PM25_S.ON_ROAD <- BC_Mryld[BC_Mryld[,5]=="ON-ROAD",c(4,6)]
PM25_S.NON_ROAD <- BC_Mryld[BC_Mryld[,5]=="NON-ROAD",c(4,6)]

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
p <- ggplot(BC_Mryld, aes(x=year, y=log10(Emissions), group=year)) + geom_boxplot()
p <- p + facet_grid(type ~ .)
p <- p + stat_summary(fun.y=mean, geom="point", shape=20, size=4, color = "red")
p

#Close png file
dev.off() 


## It seems the "NON_ROAD" and "NON_POINT" sources have seen decreases
#in emissions from 1999–2008 for Baltimore City, but It is hard to appreciate the
# differences among the four years in the charts...
#...so let's see the values of the means
sapply(split(PM25_S.NON_ROAD, PM25_S.NON_ROAD$year),summary)
sapply(split(PM25_S.NONPOINT, PM25_S.NONPOINT$year),summary)
sapply(split(PM25_S.ON_ROAD, PM25_S.ON_ROAD$year),summary)
sapply(split(PM25_S.POINT, PM25_S.POINT$year),summary)

##An analitically observation shows that the sources that had a reduction between
#the years were the "NONPOINT" and "ON_ROAD" sources.



##########################################################################################
##########################################################################################
## 4. Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?



