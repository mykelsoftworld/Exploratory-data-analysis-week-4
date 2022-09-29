# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which 
# have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.setwd("./")

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


PM_types<-unique(data_2$type)
sub_data_3<- data_2[data_2$fips == "24510" & data_2$type=="POINT",]
sub_data_4<- data_2[data_2$fips == "24510" & data_2$type=="NONPOINT",]
sub_data_5<- data_2[data_2$fips == "24510" & data_2$type=="ON-ROAD",]
sub_data_6<- data_2[data_2$fips == "24510" & data_2$type=="NON-ROAD",]

sum_data_3 <- lapply(split(sub_data_3,factor(sub_data_3$year)),function(x) {
  colSums(x["Emissions"],
          na.rm = TRUE)})


sum_data_3<-data.frame(sum_data_3)
years<-c("1999","2002","2005","2008")
cname<-c("years","Emissions")


newdata_3 <- data.frame("years"=character(), "Emissions"=numeric())
for(y in years) {
  s<-paste("X",y,sep = "")
  x<-sum_data_3[,s]
  newdata_3 <- rbind(newdata_3, data.frame(y, x))
}
colnames(newdata_3)<- c("years","Emissions")




barplot(newdata_3[, "Emissions"]
        , names = newdata_3[, "years"]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years for Baltimore city and type POINT")


sum_data_4 <- lapply(split(sub_data_4,factor(sub_data_4$year)),function(x) {
  colSums(x["Emissions"],
          na.rm = TRUE)})


sum_data_4<-data.frame(sum_data_4)
years<-c("1999","2002","2005","2008")
cname<-c("years","Emissions")


newdata_4 <- data.frame("years"=character(), "Emissions"=numeric())
for(y in years) {
  s<-paste("X",y,sep = "")
  x<-sum_data_4[,s]
  newdata_4 <- rbind(newdata_4, data.frame(y, x))
}
colnames(newdata_4)<- c("years","Emissions")




barplot(newdata_4[, "Emissions"]
        , names = newdata_4[, "years"]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years for Baltimore city and type NONPOINT")



sum_data_5 <- lapply(split(sub_data_5,factor(sub_data_5$year)),function(x) {
  colSums(x["Emissions"],
          na.rm = TRUE)})


sum_data_5<-data.frame(sum_data_5)
years<-c("1999","2002","2005","2008")
cname<-c("years","Emissions")


newdata_5 <- data.frame("years"=character(), "Emissions"=numeric())
for(y in years) {
  s<-paste("X",y,sep = "")
  x<-sum_data_5[,s]
  newdata_5 <- rbind(newdata_5, data.frame(y, x))
}
colnames(newdata_5)<- c("years","Emissions")




barplot(newdata_5[, "Emissions"]
        , names = newdata_5[, "years"]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years for Baltimore city and type ON-ROAD")



sum_data_6 <- lapply(split(sub_data_6,factor(sub_data_6$year)),function(x) {
  colSums(x["Emissions"],
          na.rm = TRUE)})


sum_data_6<-data.frame(sum_data_6)
years<-c("1999","2002","2005","2008")
cname<-c("years","Emissions")


newdata_6 <- data.frame("years"=character(), "Emissions"=numeric())
for(y in years) {
  s<-paste("X",y,sep = "")
  x<-sum_data_6[,s]
  newdata_6 <- rbind(newdata_6, data.frame(y, x))
}
colnames(newdata_6)<- c("years","Emissions")

png("plot3.png")

ggplot(sub_data_2,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw()+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()