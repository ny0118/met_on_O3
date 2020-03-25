# read MEE data from 000 file by R
# Author: Yang Nan
# 2020-03-24

dir='F:/AQI/2014/'

#(1)read 000 file and get data------------------------
#set the working directory
getwd()
setwd("F:/AQI/2014/")

#find all files in this directory
dirname<-list.files(dir,full.names=T,all.files=T,recursive=T)
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

day_in_month<-c(31,28,31,30,31,30,31,31,30,31,30,31)#非闰年
day_in_month_leap<-c(31,29,31,30,31,30,31,31,30,31,30,31)#非闰年
#chek if year is leap year (2016 is leap year in 2014-2019)
if (year== 2016){
  days=366 
  day_in_month<-day_in_month_leap
} else{
  days=365
}

#derive day_file_num_flag
dayID<-c(1:days)
dayID_start<-dayID
dayID_start[]<-NA
dayID_end<-dayID
dayID_end[]<-NA

day_file_num_flag<-data.frame(dayID,dayID_start,dayID_end)


#derive all day_file_num_flag in a year
for (m in 1:12) {
  for (n in 1:day_in_month[m]) {
    floor_file<-m*10000+100*n
    ceiling_file<-m*10000+100*(n+1)
    day_num<-file_num[MMDDHH>=(floor_file) &MMDDHH<(ceiling_file)]
    if (day_num >=1){
      flag=n
      if (m==1) flag=n
      if (m > 1){
        for (k in 1:(m-1)) {
          flag=flag+day_in_month[k]
        }
      }
      day_file_num_flag$dayID_start[flag]<-day_num[1]
      day_file_num_flag$dayID_end[flag]<-day_num[length(day_num)]   
    }
  }
}

print(year)
