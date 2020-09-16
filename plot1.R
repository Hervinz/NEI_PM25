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
NEI$year <- as.factor(NEI$year)



##########################################################################################
##########################################################################################
## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all
#sources for each of the years 1999, 2002, 2005, and 2008.


NEI_Year <- sapply(split(NEI[,4], NEI$year), sum)

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
barplot(NEI_Year, xlab = "Year",
        ylab = expression("Total PM"['25']*" emissions"), 
        main = expression("Total PM"['25']*" emissions per year in the United States"))


#Close png file
dev.off() 

# Total emissions from PM2.5 have decreased in the United States from 1999 to 2008.
