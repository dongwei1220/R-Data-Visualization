# 03.条形图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/03barplot//")

# barplot函数绘制条形图
# 使用mtcars内置数据集
head(mtcars)
# 使用table函数进行计数
counts <- table(mtcars$cyl)
counts

# 默认条形图垂直放置
barplot(counts,xlab = "mtcars$cyl", ylab = "counts", 
        col = heat.colors(3))
# 设置horiz = T参数进行水平放置
barplot(counts,xlab = "mtcars$cyl", ylab = "counts", 
        col = heat.colors(3), horiz = T)

# 绘制分组条形图
counts <- table(mtcars$cyl,mtcars$carb)
counts
# 默认为堆砌条形图
barplot(counts, xlab = "cyl", ylab = "carb", legend = T,
        col = c("red","blue","green"), main = "Group of cyl and carb")
# 设置beside = T参数绘制并列分组条形图
barplot(counts, xlab = "cyl", ylab = "carb", beside = T, legend = T,
        col = c("red","blue","green"), main = "Group of cyl and carb")

# ggplot2包绘制分组条形图
# 读取示例数据
data <- read.table("demo1_barplot.txt",header = T, check.names = F, sep = "\t")
# 查看数据
head(data)
library(ggplot2)
library(reshape2)
data <- melt(data,variable.name = "Cluster", value.name = "Count")
head(data)
# 设置position = "stack"参数绘制堆砌条形图
ggplot(data, aes(Cluster, Count, fill=Annotation)) + 
  geom_bar(stat = "identity", position = "stack") + theme_bw() + theme(legend.position = "top")
# 设置position = "dodge"参数绘制并列条形图
ggplot(data, aes(Cluster, Count, fill=Annotation)) + 
  geom_bar(stat = "identity", position = "dodge") + theme_bw() + theme(legend.position = "top")
# 设置position = "fill"参数绘制填充条形图
ggplot(data, aes(Cluster, Count, fill=Annotation)) + 
  geom_bar(stat = "identity", position = "fill") + theme_bw() + theme(legend.position = "top")
# 添加coord_flip参数进行水平翻转
ggplot(data, aes(Cluster, Count, fill=Annotation)) + 
  geom_bar(stat = "identity", position = "fill") + 
  theme_bw() + theme(legend.position = "top") + coord_flip()

# ggpubr包绘制带误差棒的条形图
# 读取示例数据
data <- read.table("demo2_barplot.txt",header = T,row.names = 1, check.names = F, sep = "\t")
# 查看数据
head(data)

library(ggpubr)
ggbarplot(data, x = "Stage", y = "TPM", 
          color = "Gender", fill = "Gender", 
          add = c("mean_se","dotplot"), width = 0.6,
          position = position_dodge())

ggbarplot(data, x = "Stage", y = "TPM", orientation = "horiz",
          color = "Gender", fill = "Gender", 
          add = c("mean_se","jitter"), width = 0.6,
          palette = c("#00AFBB", "#E7B800"),
          position = position_dodge())


