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

aggr_PM25_MD<-aggregate(Emissions~year,summarySCC_data_MD,sum)
png("plot2.png",width=480,height=480)
barplot(aggr_PM25_MD$Emissions,names.arg=aggr_PM25$year,xlab="year",ylab="PM2.5 Emissions",main=" Baltimore City Total PM2.5 Emissions by Year")
dev.off()
