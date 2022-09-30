## Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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

sub_data_2<- data_2[data_2$fips == "24510",]

sum_data_1 <- lapply(split(sub_data_2,factor(sub_data_2$year)),function(x) {
  colSums(x["Emissions"],
          na.rm = TRUE)})


sum_data_1<-data.frame(sum_data_1)
years<-c("1999","2002","2005","2008")
cname<-c("years","Emissions")


newdata_1 <- data.frame("years"=character(), "Emissions"=numeric())
for(y in years) {
  s<-paste("X",y,sep = "")
  x<-sum_data_1[,s]
  newdata_1 <- rbind(newdata_1, data.frame(y, x))
}
colnames(newdata_1)<- c("years","Emissions")

png("plot2.png")


barplot(newdata_1[, "Emissions"]
        , names = newdata_1[, "years"]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years for Baltimore")
dev.off()

# library(dplyr)
# library(ggplot2)
# 
# file_name <- "summarySCC_PM25.rds"
# data <- readRDS(file_name)
# 
# pm25_emi_balt <- data %>% group_by(year) %>% filter(fips == "24510") %>% 
#   summarise(total = sum(Emissions))
# 
# plot2 <- barplot(pm25_emi_balt$total, 
#                     main = "Total PM2.5 Emissions in Baltimore City, Maryland", 
#                     xlab = "Year", ylab = "PM2.5 Emissions in Tons", 
#                     names.arg = pm25_emi_balt$year, col = "darkred", ylim = c(0,3600))
# 
# text(plot2, round(pm25_emi_balt$total), label = round(emi_balt$total), 
#      pos = 3, cex = 1.2)