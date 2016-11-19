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

summarySCC_data_Combustion<- grepl("Combustion", SourceClasssi_data$SCC.Level.One, ignore.case=TRUE)
summarySCC_data_Coal<- grepl("Coal", SourceClasssi_data$SCC.Level.Three, ignore.case=TRUE)
SourceClasssi_data_Combustion<-SourceClasssi_data[summarySCC_data_Combustion,]
SourceClasssi_data_Coal<-SourceClasssi_data_Combustion[summarySCC_data_Coal,]$SCC
summarySCC_data_Coal<-summarySCC_data[summarySCC_data$SCC %in% SourceClasssi_data_Coal,]
head(summarySCC_data_Coal)

aggr_summarySCC_data_Coal<-aggregate(Emissions~year,summarySCC_data_Coal,sum)
head(summarySCC_data_Coal)


library(ggplot2)

png("plot4.png",width=480,height=480)
plot4<-ggplot(aes(year,Emissions),data=aggr_summarySCC_data_Coal,width = 30, height = 20)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions")+
  expand_limits(y=c(0,550000))+
  ggtitle("Total Coal Combustion Related PM2.5 Emissions by Year & Type")+
  geom_line()+
  expand_limits(y=c(0,600000))
print(plot4)
dev.off()

