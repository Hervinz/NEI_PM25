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



## 6. Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

NEI_MS_BC_LA <- NEI[NEI$SCC %in% MobileSources & NEI$fips == "24510" | NEI$fips == "06037", c(1, 4,6)]

##sAVING PLOT IN PNG FILE.
#Open png file
png(filename = "plot6.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE)

#Boxplot creation
p <- ggplot(NEI_MS_BC_LA, aes(x=year, y=log10(Emissions), group=year))+ geom_boxplot()
p <- p + facet_grid(fips ~ .)
p <- p + stat_summary(fun.y=mean, geom="point", shape=20, size=4, color = "red")
p

#Close png file
dev.off()

#Between 1999 and 2008, a greater magnitude of change is observed in the city of LA,
#explained by the reduction that occurred in 2008. However, if the reduction in 2008 
#in California is not taken into account, it is observed a more sustained 
#(albeit gradual) reduction in Baltimore City.