# read MEE data from http://beijingair.sinaapp.com/ by Rstudio on windows
# Author: Yang Nan
# 2020-03-17

getwd()
setwd("F:/全国空气质量/")

#读出的数据是data.frame,每列是因子（factor）类型
Site_info <- read.csv(file="站点列表-2020.01.01起.csv", header=T,fileEncoding = "utf-8")

#数据信息查看
class(Site_info)
class(Site_info$监测点编码)#查看数据类型
levels(Site_info$城市)#具体有哪些类型
nlevels(Site_info$城市)#具体有多少个类别
summary(Site_info)

#转换数据格式,方便后续处理
Site_info$监测点编码<-as.vector(Site_info$监测点编码)
Site_info$监测点名称<-as.vector(Site_info$监测点名称)
Site_info$城市<-as.vector(Site_info$城市)
Site_info$经度<-as.numeric(as.vector(Site_info$经度))
Site_info$纬度<-as.numeric(as.vector(Site_info$纬度))


#修改test