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

#data_2[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]


sum_data <- lapply(split(data_2,factor(data_2$year)),function(x) {
  colSums(x["Emissions"],
           na.rm = TRUE)})


sum_data<-data.frame(sum_data)
years<-c("1999","2002","2005","2008")
cname<-c("years","Emissions")


newdata <- data.frame("years"=character(), "Emissions"=numeric())
for(y in years) {
  s<-paste("X",y,sep = "")
  x<-sum_data[,s]
  newdata <- rbind(newdata, data.frame(y, x))
}
colnames(newdata)<- c("years","Emissions")

png("plot1.png")

  
#data_2[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

barplot(newdata[, "Emissions"]
        , names = newdata[, "years"]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()


# library(dplyr)
# library(ggplot2)
# 
# file_name <- "summarySCC_PM25.rds"
# data <- readRDS(file_name)
# 
# pm25_emi_year <- data %>% group_by(year) %>% summarise(total = sum(Emissions))
# 
# plot1 <- barplot(pm25_emi_year$total/1000, main = "Total PM2.5 Emissions", 
#                     xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
#                     names.arg = pm25_emi_year$year, col = "darkred", ylim = c(0,8300))
# 
# text(plot1, round(emi_year$total/1000), label = round(emi_year$total/1000), 
#      pos = 3, cex = 1.2)