#Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles, California fips == "06037".Which city has seen greater changes over time in motor vehicle emissions?

setwd("./")
path<-"./"
if(!require("data.table")){
  install.packages("data.table")
  library(data.table)
}

if(!require("ggplot2")){
  install.packages("ggplot2")
  library(ggplot2) 
}

# download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fdata_2_data.zip"
#               , destfile = paste(path, "dataFiles.zip", sep = "/"))
# unzip(zipfile = "dataFiles.zip")

data_1 = readRDS(file = "Source_Classification_Code.rds")
data_2 = readRDS(file = "summarySCC_PM25.rds")



# search for motor vehicle sources by search for "vehicle" string in SCC.level.two column
motor_vehicle_related_sources <- grepl("vehicle", data_1$`SCC.Level.Two`, ignore.case=TRUE)

# select SCC code for rows motor vehicle related sources

motor_vehicle_SCC <- data_1[motor_vehicle_related_sources, "SCC"]

# extract rows in the summary dataset with motor_vehicle_related_sources
motor_vehicle_SCC_rows <-data_2[,"SCC"] %in% motor_vehicle_SCC
motor_vehicle_subset <- data_2[motor_vehicle_SCC_rows,]
# extract motor vehicle sources for Baltimore city(fips == "24510") and  Los Angeles county, California fips == "06037"
motor_vehicle_subset_Baltimore<-motor_vehicle_subset[motor_vehicle_subset$fips == "24510",]

#create a new column city and initialise to Baltimore
motor_vehicle_subset_Baltimore$city<-c("Baltimore")
motor_vehicle_subset_LA<-motor_vehicle_subset[motor_vehicle_subset$fips == "06037",]
#create a new column city and initialise to Los Angeles
motor_vehicle_subset_LA$city <- c("Los Angeles")

motor_vehicle_subset_both_cities<-rbind(motor_vehicle_subset_Baltimore,motor_vehicle_subset_LA)
#create a png screen for plotting
png("plot6.png")

ggplot(motor_vehicle_subset_both_cities,aes(factor(year),Emissions,fill=city)) +
  geom_bar(stat="identity") +
  facet_grid(.~city,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" motor vehicle Emissions,1999-2008 for Baltimore and Los Angeles"))
dev.off()

# ssc_file <- "Source_Classification_Code.rds"
# data_ssc <- readRDS(ssc_file)
# 
# balti_la_year <- motor_emi %>% filter(fips == "24510" | fips == "06037") %>% 
#   group_by(fips, year) %>% summarise(total = sum(Emissions))
# balti_la_year <- mutate(balti_la_year, 
#                            Unit = ifelse(fips == "24510", "Baltimore City", 
#                                          ifelse(fips == "06037", "Los Angeles County")))
# ggplot(balti_la_year, aes(factor(year), total, 
#                           fill = Unit, label = round(total))) + 
#   geom_bar(stat = "identity") + facet_grid(. ~ Unit) + 
#   ggtitle("Total Motor Vehicle Emissions") +
#   xlab("Year") + ylab("Pm2.5 Emissions in Tons") +
#   theme(plot.title = element_text(hjust = 0.5)) + ylim(c(0, 8000)) +
#   theme_classic() + geom_text(size = 4, vjust = -1)

# library(dplyr)
# library(ggplot2)
# # Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
# # California (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
# 
# NEI <- readRDS("summarySCC_PM25.rds")
# nei_baltimore_la <- subset(NEI, fips == "24510" | fips == "06037")
# SCC <- readRDS("Source_Classification_Code.rds")
# 
# SCC_mv <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]
# merged <- merge(x=nei_baltimore_la, y=SCC_mv, by.x = 'SCC', by.y='SCC')
# 
# get_county = function(x){
#   if (x == '24510'){
#     val = "Baltimore"
#   }
#   else{
#     val = "Los Angeles"
#   }
#   val
# }
# merged$county = sapply(merged$fips, get_county)
# nei_grouped <- merged %>% group_by(county, year) %>% summarise_at(vars(c("Emissions")), list(emissions = sum))
# 
# png("plot6.png")
# 
# qplot(
#   x = year, 
#   y = emissions,
#   data = nei_grouped,
#   color = county,
#   xlab = 'year',
#   ylab = 'emissions',
#   main = 'Emissions from motor vehicles per Year in Los Angeles and Baltimore',
#   geom=c("line")
# )
# 
# dev.off()