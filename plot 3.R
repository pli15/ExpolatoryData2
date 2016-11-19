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

summarySCC_data_MD<-summarySCC_data[summarySCC_data$fips=="24510",]

aggr_PM25_MD<-aggregate(Emissions~year+type,summarySCC_data_MD,sum)

library(ggplot2)

png("plot3.png",width=480,height=480)
plot3<-ggplot(aes(year,Emissions,color=type),data=aggr_PM25_MD,width = 30, height = 20)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions")+
  ggtitle("Baltimore Total PM2.5 Emissions by Year & Type")+
  geom_line()
print(plot3)
dev.off()

