# read MEE data from http://beijingair.sinaapp.com/ by Rstudio on windows
# Author: Yang Nan
# 2020-03-17

getwd()
setwd("F:/ȫ����������/")

#����վ������ǰ��վ����Ϣ���в���
#�ο���1��sid_20170301.csv��NAS��վ����Ϣ��������ɳû�У�
#�ο���2��http://www.gpsspg.com/maps.htm ֱ�Ӷ�λ����ɳȺ������ѡȡ��Ѷ�ߵ¾�γ����Ϣ


#������������data.frame,ÿ�������ӣ�factor������
Site_info <- read.csv(file="site_list_2020.04.05_vacnt filled.csv", header=T)


#������Ϣ�鿴
class(Site_info)
class(Site_info$�������)#�鿴��������
levels(Site_info$����)#��������Щ����
nlevels(Site_info$����)#�����ж��ٸ����
summary(Site_info)

#ת�����ݸ�ʽ,�����������
Site_info$�������<-as.vector(Site_info$�������)
Site_info$��������<-as.vector(Site_info$��������)
Site_info$����<-as.vector(Site_info$����)
Site_info$����<-as.numeric(as.vector(Site_info$����))
Site_info$γ��<-as.numeric(as.vector(Site_info$γ��))


#�޸�test