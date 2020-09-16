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
## 3. Of the four types of sources indicated by the type
#(point, nonpoint, onroad, nonroad) variable, which of these four sources
#have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 
#plotting system to make a plot answer this question.

library(ggplot2)
BC_Mryld$type <- as.factor(BC_Mryld$type)
BC_Mryld <- NEI[with(NEI, fips == "24510"),]
BC_Mryld_Year <- aggregate(Emissions ~ year + type, BC_Mryld, sum)

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
p <- ggplot(BC_Mryld_Year, aes(x=year, y=Emissions, color=type)) + geom_line() + geom_point() + ylab(expression("Total PM"['25']*" Emissions"))+ ggtitle(expression("Total emissions by type of source in Baltimore City"))
p

#Close png file
dev.off() 


## It seems the "ON_ROAD", "NON_POINT" and "NON_ROAD" sources have seen decreases
#in emissions from 1999-2008 for Baltimore City.

