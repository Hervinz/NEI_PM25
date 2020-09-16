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
## 2. Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008?
#Use the base plotting system to make a plot answering this question.


BC_Mryld <- NEI[with(NEI, fips == "24510"),]
BC_Mryld_Year <- sapply(split(BC_Mryld[,4], BC_Mryld$year), sum)



##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
barplot(BC_Mryld_Year, xlab = "Year",
        ylab = expression("Total PM"['25']*" emissions"), 
        main = expression("Total PM"['25']*" emissions per year in Baltimore City"))

#Close png file
dev.off() 


