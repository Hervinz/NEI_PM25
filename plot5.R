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
## 5. How have emissions from motor vehicle sources changed from 
#1999-2008 in Baltimore City?

library(ggplot2)
MobileSources <- SCC[grep("Mobile", SCC$EI.Sector),1]
NEI_MS <- NEI[NEI$SCC %in% MobileSources & NEI$fips == "24510", c(4,6)]
NEI_MS <- aggregate(Emissions ~ year, NEI_MS, sum)


##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot5.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
p <- ggplot(NEI_MS, aes(x=year, y=Emissions, group=year))+ geom_bar(stat = "identity")
p <- p + ylab(expression("Total PM"['25']*" Emissions"))+ ggtitle(expression("Total emissions from motor vehicle sources in Baltimore City"))
p

#Close png file
dev.off()

##Emissions from motor vehicle sources from 1999-2008 in Baltimore City
#have had this behavior: A considerable reduction after 1999,
#and an increase in 2008.

