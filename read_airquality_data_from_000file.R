# read MEE data from 000 file by R
# Author: Yang Nan
# 2020-03-24

#(1)read 000 file and get data------------------------
#set the working directory
getwd()
setwd("F:/AQI/2014/")

#find all files in this directory
dirname<-list.files('F:/AQI/2014/',full.names=T,all.files=T,recursive=T)
dirname[1]
length(dirname)

#read 000 file and skip line 1
#mydata1<-read.table(dirname[1],fill=T,sep = "",skip = 1) 

#read aqi data info
data_000info = read.csv("F:/AQI/aqi数据说明.csv")


#(2)find daily monthly files-------------------
#get int YYYYMMDDHH from dirname 
YYYYMMDDHH<-dirname
YYYYMMDDHH<-as.integer(YYYYMMDDHH)
file_num<-c(1:length(dirname))

for (n in 1:length(dirname)) {
  file_str<-strsplit(dirname[n],split = "/")
  YYYYMMDDHH[n]<-as.integer(file_str[[1]][4])
}

#filter year
year<-floor(YYYYMMDDHH[1]/1000000)
MMDDHH<-YYYYMMDDHH-year*1e6

#chek if year is leap year (2016 is leap year in 2014-2019)
if (year== 2016) days=366 else  days=365

#derive day_file_num_flag
dayID<-c(1:days)
dayID_start<-dayID
dayID_start[]<-NA
dayID_end<-dayID
dayID_end[]<-NA

day_file_num_flag<-data.frame(dayID,dayID_start,dayID_end)

#Jan 31 days
for (n in 1:31) {
  day_num<-file_num[MMDDHH>=(10000+100*n) &MMDDHH<(10100+100*n)]
  if (day_num >=1){
    day_file_num_flag$dayID_start[n]<-day_num[1]
    day_file_num_flag$dayID_end[n]<-day_num[length(day_num)]   
  }
}
#Feb 28 days
for (n in 1:28) {
  day_num<-file_num[MMDDHH>=(20000+100*n) &MMDDHH<(20100+100*n)]
  if (day_num >=1){
    day_file_num_flag$dayID_start[31+n]<-day_num[1]
    day_file_num_flag$dayID_end[31+n]<-day_num[length(day_num)]   
  }
}

