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
## 4. Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?

CoalSources <- SCC[grep("Coal", SCC$EI.Sector),1]
NEI_CS <- NEI[NEI$SCC %in% CoalSources, c(4,6)]

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
p <- ggplot(NEI_CS, aes(x=year, y=log10(Emissions), group=year))+ geom_boxplot()
p

#Close png file
dev.off()

# Across the United States and among the years 1999–2008, the emissions from 
# coal combustion-related sources have increased.
