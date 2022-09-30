# Question 4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?setwd("./")

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



# search for combustion related sources by search for "comb" string in SCC.level.one column and search for 
# the string "coal" for coal related sources in the SCC.level.four column
# v<-data_1[,"SCC.Level.One"]
combustion_Related <- grepl("comb", data_1$`SCC.Level.One`, ignore.case=TRUE)
coal_Related <- grepl("coal", data_1$SCC.Level.Four, ignore.case=TRUE) 

# select SCC code for rows with both combustion related and coal related sources

comb_coal_SCC <- data_1[combustion_Related & coal_Related, "SCC"]

# extract rows in the summary dataset with coal combustion-related sources
coal_combustion_SCC_rows <-data_2[,"SCC"] %in% comb_coal_SCC
coal_combustion_subset <- data_2[coal_combustion_SCC_rows,]

png("plot4.png")

ggplot(coal_combustion_subset,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill ="#AA9900") +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, from coal combustion sources"))
dev.off()


# ssc_file <- "Source_Classification_Code.rds"
# data_ssc <- readRDS(ssc_file)
# 
# data_coal <- data_ssc[grepl("Comb.*Coal", data_ssc$EI.Sector), ]
# coal_scc <- unique(data_coal$SCC)
# coal_emi <- data[(data$SCC %in% coal_scc), ]
# coal_year <- coal_emi %>% group_by(year) %>% summarise(total = sum(Emissions))
# 
# ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
#   geom_bar(stat = "identity", fill = "darkred") + 
#   ggtitle("Total coal combustion related PM2.5 Emissions") + 
#   xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
#   ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
#   theme(plot.title = element_text(hjust = 0.5))