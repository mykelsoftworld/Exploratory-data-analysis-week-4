setwd("./")
path<-"./"
if(!require("data.table")){
  install.packages("data.table")
  library(data.table)
}

# download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fdata_2_data.zip"
#               , destfile = paste(path, "dataFiles.zip", sep = "/"))
# unzip(zipfile = "dataFiles.zip")

data_1 = readRDS(file = "Source_Classification_Code.rds")
data_2 = readRDS(file = "summarySCC_PM25.rds")

data_2[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

sum_data_2 <- data_2[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

barplot(sum_data_2[, Emissions]
        , names = sum_data_2[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")
