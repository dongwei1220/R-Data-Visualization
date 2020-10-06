# 02.折线图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/02lineplot/")

# base plot函数绘制普通折线图
# 读取示例数据
data <- read.table("demo1_lineplot.txt", header = T, check.names = F)
# 查看数据
head(data)
dim(data)

attach(data)
plot(x, y1, type = "b", pch = 15, lty = 1, col = "red", xlab = "时间", ylab = "反应强度", ylim = c(-1,30))
lines(x, y2, type = "b", pch = 16, lty = 2, col = "blue")
lines(x, y3, type = "b", pch = 17, lty = 3, col = "purple")
legend("topleft", inset = 0.02, title = "样品", c("y1","y2","y3"), 
       lty = c(1,2,3), pch = c(15,16,17), col = c("red","blue","purple"),
       bg = "gray")
detach(data)

# ggplot2包绘制带误差棒的折线图
library(ggplot2)
# 读取示例数据
data2 <- read.table("demo2_lineplot.txt", header = T, row.names = 3, sep="\t", check.names = F)
data2$Stage <- factor(data2$Stage,levels = c("0 min","10 min","20 min","30 min","45 min","60 min","90 min","120 min"))
# 查看数据
head(data2)

#+++++++++++++++++++++++++
# Function to calculate the mean and the standard deviation
# for each group
#+++++++++++++++++++++++++
# data : a data frame
# varname : the name of a column containing the variable
#to be summariezed
# groupnames : vector of column names to be used as
# grouping variables
# 定义函数计算平均值和标准差
data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum <- ddply(data, groupnames, .fun=summary_func, varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

data2 <- data_summary(data2, varname="Expression", 
                      groupnames=c("Stage"))
head(data2)

# Standard deviation of the mean
ggplot(data2, aes(x=Stage, y=Expression, group=1, color=Stage)) + 
  geom_errorbar(aes(ymin=Expression-sd, ymax=Expression+sd), width=.1) +
  geom_line() + geom_point()+
  scale_color_brewer(palette="Paired")+theme_bw()

# ggplot2包绘制聚类趋势折线图
# 读取示例数据
data3 <- read.table("demo3_lineplot.txt",header = T,check.names = F)
# 查看数据
head(data3)

library(reshape2)
data3 = melt(data3)
head(data3)
names(data3) <- c("Gene","Group","Stage","Expression")

ggplot(data3,aes(x=Stage, y=Expression, group=Gene)) + geom_line(color="gray90",size=0.8) + 
  geom_hline(yintercept =0,linetype=2) +
  stat_summary(aes(group=1),fun.y=mean, geom="line", size=1.2, color="#c51b7d") + 
  facet_wrap(.~Group) + theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text = element_text(size=8, face = "bold"),
        strip.text = element_text(size = 10, face = "bold"))


