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
