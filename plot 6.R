setwd("D:/exploratory data/project 2")
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile="./data.zip")
unzip("data.zip")
library(data.table)
SourceClasssi_data<-readRDS("./Source_Classification_Code.rds")
head(SourceClasssi_data)

summarySCC_data<-readRDS("./summarySCC_PM25.Rds")
head(summarySCC_data)

unique(summarySCC_data$year)
unique(summarySCC_data$type)

summarySCC_data_BalLAVH<-summarySCC_data[summarySCC_data$type %in% c("ON-ROAD")&summarySCC_data$fips %in% c("24510","06037"),]
head(summarySCC_data_BalLAVH)
summarySCC_data_BalVH<-aggregate(Emissions~year,summarySCC_data_BalLAVH,sum)
head(summarySCC_data_BalLAVH)
summarySCC_data_BalLAVH$County[summarySCC_data_BalLAVH$fips =="06037"]<-"LA"
summarySCC_data_BalLAVH$County[summarySCC_data_BalLAVH$fips =="24510"]<-"Baltimore"
head(summarySCC_data_BalLAVH)

aggr_summarySCC_data_County<-aggregate(Emissions~year+County,summarySCC_data_BalLAVH,sum)

library(ggplot2)

png("plot6.png",width=480,height=480)
plot6<-ggplot(aes(year,Emissions,color=County),data=aggr_summarySCC_data_County,width = 30, height = 20)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions")+
  expand_limits(y=c(0,350))+
  ggtitle("Baltimore/LA Total Motor Vehicle Related PM2.5 Emissions by Year")+
  geom_line()
print(plot6)
dev.off()




