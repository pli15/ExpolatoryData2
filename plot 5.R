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

summarySCC_data_BalVH<-summarySCC_data[summarySCC_data$type %in% c("ON-ROAD")&summarySCC_data$fips=="24510",]
head(summarySCC_data_BalVH)
summarySCC_data_BalVH<-aggregate(Emissions~year,summarySCC_data_BalVH,sum)
head(summarySCC_data_BalVH)


library(ggplot2)

png("plot5.png",width=480,height=480)
plot5<-ggplot(aes(year,Emissions),data=summarySCC_data_BalVH,width = 30, height = 20)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions")+
  expand_limits(y=c(0,350))+
  ggtitle("Baltimore Total Motor Vehicle Related PM2.5 Emissions by Year")+
  geom_line()+
  expand_limits(y=c(0,400))
print(plot5)
dev.off()




