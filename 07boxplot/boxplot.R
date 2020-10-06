# 07.箱线图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/07boxplot/")

# 基础boxplot函数绘制箱线图
## boxplot on a formula:
# 查看内置数据集
head(InsectSprays)
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")

boxplot(count ~ spray, data = InsectSprays,
        notch = TRUE, col = "blue")

## boxplot on a matrix:
mat <- cbind(Uni05 = (1:100)/21, Norm = rnorm(100),
             `5T` = rt(100, df = 5), Gam2 = rgamma(100, shape = 2))
head(mat)
boxplot(mat) # directly, calling boxplot.matrix()

## boxplot on a data frame:
df <- as.data.frame(mat)
par(las = 1) # all axis labels horizontal
boxplot(df, main = "boxplot(*, horizontal = TRUE)", 
        col = "red", notch = T, horizontal = TRUE)

## Using 'at = ' and adding boxplots -- example idea by Roger Bivand :
head(ToothGrowth)
boxplot(len ~ dose, data = ToothGrowth,
        subset = supp == "VC", 
        at = 1:3 - 0.2,
        boxwex = 0.25, 
        col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")
boxplot(len ~ dose, data = ToothGrowth, 
        add = TRUE,
        subset = supp == "OJ", 
        at = 1:3 + 0.2,
        boxwex = 0.25,
        col = "orange")
legend("topleft", c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))

## With less effort (slightly different) using factor *interaction*:
boxplot(len ~ dose:supp, data = ToothGrowth,
        boxwex = 0.5, col = c("orange", "yellow"),
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg", ylab = "tooth length",
        sep = ":", lex.order = TRUE, ylim = c(0, 35), yaxs = "i")

# ggplot2包绘制箱线图
library(ggplot2)

data <- read.table("demo1_boxplot.txt",header = T)
head(data)

ggplot(data,aes(sample_type,BRCA1,fill=sample_type)) + 
        geom_boxplot()

# 添加扰动点，更改离群点的颜色，形状和大小
ggplot(data,aes(sample_type,BRCA1,fill=sample_type)) + 
        geom_boxplot(width=0.5,outlier.color = "red",outlier.shape = 2,outlier.size = 3) + 
        geom_jitter(shape=16, position=position_jitter(0.2))

# 添加notch，更改颜色
ggplot(data,aes(sample_type,BRCA1,fill=sample_type)) + 
        geom_boxplot(notch = T,width=0.5,alpha=0.8) + 
        scale_fill_brewer(palette="Set1")

# 添加均值点
ggplot(data,aes(sample_type,BRCA1,fill=sample_type)) + 
        geom_boxplot(notch = T,width=0.5,alpha=0.8) + 
        scale_fill_brewer(palette="Set1") + 
        stat_summary(fun.y="mean",geom="point",shape=23,
                     size=4,fill="white")

# 添加误差棒
ggplot(data,aes(sample_type,BRCA1,fill=sample_type)) + 
        geom_boxplot(notch = T,width=0.5,alpha=0.8) + 
        stat_boxplot(geom = "errorbar",width=0.1) +
        scale_fill_brewer(palette="Set1") + 
        stat_summary(fun.y="mean",geom="point",shape=23,
                     size=4,fill="white")

# 更换主题背景，旋转坐标轴
ggplot(data,aes(sample_type,BRCA1,fill=sample_type)) + 
        stat_boxplot(geom = "errorbar",width=0.1) +
        geom_boxplot(notch = T,width=0.5,alpha=0.8) + 
        scale_fill_brewer(palette="Set1") + 
        stat_summary(fun.y="mean",geom="point",
                     shape=23,size=4,fill="white") +
        theme_bw() + coord_flip()

# ggpubr包绘制箱线图
library(ggpubr)

data <- read.table("demo1_boxplot.txt",header = T)
head(data)

ggboxplot(data,x="sample_type",y="BRCA1",
          width = 0.6,fill="sample_type")

# 添加notch，扰动点，更改颜色
ggboxplot(data,x="sample_type",y="BRCA1",
          width = 0.6,fill="sample_type",
          notch = T,palette = c("#00AFBB", "#E7B800"),
          add = "jitter",shape="sample_type")

# 添加误差棒和均值
ggboxplot(data,x="sample_type",y="BRCA1",
          width = 0.6,fill="sample_type",
          bxp.errorbar = T, bxp.errorbar.width = 0.2,
          add = "mean",add.params = list(size=1,color="white"))

# 旋转坐标轴
ggboxplot(data,x="sample_type",y="BRCA1",
          width = 0.6,fill="sample_type",
          add = "mean",add.params = list(size=1,color="white"),
          notch = T,orientation = "horizontal")



