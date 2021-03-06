# 25. 曼哈顿图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/25manhattan/")

# 使用qqman包绘制曼哈顿图
# 安装并加载所需的R包
# install.packages("qqman")
library(qqman)

# 查看内置示例数据
head(gwasResults)

# 使用manhattan函数绘制曼哈顿图
manhattan(gwasResults)

# 调整参数
manhattan(gwasResults, 
          main = "Manhattan Plot", #设置主标题
          ylim = c(0, 10), #设置y轴范围
          cex = 0.6, #设置点的大小
          cex.axis = 0.9, #设置坐标轴字体大小
          col = c("blue4", "orange3","red"), #设置散点的颜色
          suggestiveline = F, genomewideline = F, #remove the suggestive and genome-wide significance lines
          chrlabs = c(paste0("chr",c(1:20)),"P","Q") #设置x轴染色体标签名
          )

# 提取特定染色体的数据绘图
manhattan(subset(gwasResults, CHR == 1))

# 查看感兴趣的snp信息
head(snpsOfInterest)
## [1] "rs3001" "rs3002" "rs3003" "rs3004" "rs3005" "rs3006"

# 使用highlight参数高亮感兴趣的snp位点
manhattan(gwasResults, highlight = snpsOfInterest)

# 注释pval超过指定阈值的snp位点
manhattan(gwasResults, annotatePval = 0.001, annotateTop = F)

# 使用CMplot包绘制曼哈顿图
# 安装并加载所需的R包
# install.packages("CMplot")
library(CMplot)

#加载并查看示例数据
data(pig60K)
head(pig60K)

# 使用CMplot函数绘制曼哈顿图
# 绘制圆形曼哈顿图
CMplot(pig60K,plot.type="c",r=0.5,
       threshold=c(0.01,0.05)/nrow(pig60K),cex = 0.5, 
       threshold.col = c("red","orange"), threshold.lty = c(1,2),amplify = T, cir.chr.h = 2,
       signal.cex = c(2,2), signal.pch = c(19,20), signal.col=c("red","green"),outward=TRUE)

# 绘制单性状曼哈顿图
CMplot(pig60K,plot.type = "m",
       threshold = c(0.01,0.05)/nrow(pig60K),
       threshold.col=c('grey','black'),
       threshold.lty = c(1,2),threshold.lwd = c(1,1), amplify = T,
       signal.cex = c(1,1), signal.pch = c(20,20),signal.col = c("red","orange"))

# 绘制多性状曼哈顿图
CMplot(pig60K,plot.type = "m",
       threshold = c(0.01,0.05)/nrow(pig60K),
       threshold.col=c('grey','black'),
       threshold.lty = c(1,2),threshold.lwd = c(1,1), amplify = T, 
       multracks = T,
       signal.cex = c(1,1), signal.pch = c(20,20),signal.col = c("red","orange"))

sessionInfo()

