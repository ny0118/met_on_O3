# read MEE data from http://beijingair.sinaapp.com/ by Rstudio on windows
# Author: Yang Nan
# 2020-03-17

getwd()
setwd("F:/全国空气质量/")

#读入站点数据前对站点信息进行补充
#参考（1）sid_20170301.csv，NAS上站点信息，除了西沙没有；
#参考（2）http://www.gpsspg.com/maps.htm 直接定位“西沙群岛”，选取腾讯高德经纬度信息


#读出的数据是data.frame,每列是因子（factor）类型
Site_info <- read.csv(file="site_list_2020.04.05_vacnt filled.csv", header=T)


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
