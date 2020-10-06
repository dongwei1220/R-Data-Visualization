# 04.直方图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/04histogram/")

# hist函数绘制普通直方图
# 使用内置mtcars数据集
head(mtcars)
head(mtcars$mpg)

hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10, col = "red",
     xlab = "Miles per Gallon")
hist(mtcars$mpg, breaks = 10, col = "blue", 
     freq = F, # 表示不按照频数绘图
     xlab = "Miles per Gallon")
# 添加密度曲线
lines(density(mtcars$mpg),col= "red",lwd=2)
# 添加轴须线
rug(jitter(mtcars$mpg))

# ggplot2包绘制直方图
library(ggplot2)
# 使用diamonds内置数据集
head(diamonds)

ggplot(diamonds, aes(carat)) +
  geom_histogram()

# 设置bin的数目
ggplot(diamonds, aes(carat)) +
  geom_histogram(bins = 200)

# 设置bin的宽度
ggplot(diamonds, aes(carat)) +
  geom_histogram(binwidth = 0.05)

# 添加填充色
ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)

# You can specify a function for calculating binwidth, which is
# particularly useful when faceting along variables with
# different ranges because the function will be called once per facet
mtlong <- reshape2::melt(mtcars)
head(mtlong)
ggplot(mtlong, aes(value, fill=variable)) + facet_wrap(~variable, scales = 'free_x') +
  geom_histogram(binwidth = function(x) 2 * IQR(x) / (length(x)^(1/3)))

# 读取示例数据
data <- read.table("demo_histgram.txt")
names(data) <- "length"
head(data)

ggplot(data,aes(length,..density..)) + xlim(c(0,1000)) + 
  geom_histogram(binwidth = 2, fill="red") + 
  xlab("Insertion Size (bp)") + 
  theme_bw()

# ggpubr包绘制直方图
library(ggpubr)
# Create some data format
set.seed(1234)
wdata = data.frame(
  sex = factor(rep(c("F", "M"), each=200)),
  weight = c(rnorm(200, 55), rnorm(200, 58)))
head(wdata)

# Basic density plot
# Add mean line and marginal rug
gghistogram(wdata, x = "weight", 
            fill = "lightgray", # 设置填充色
            add = "mean", # 添加均值线
            rug = TRUE # 添加轴须线
            )

# Change outline and fill colors by groups ("sex")
# Use custom color palette
gghistogram(wdata, x = "weight",
            add = "mean", rug = TRUE,
            color = "sex", fill = "sex",
            palette = c("#00AFBB", "#E7B800") # 设置画板颜色
            )

# Combine histogram and density plots
gghistogram(wdata, x = "weight",
            add = "mean", rug = TRUE,
            fill = "sex", palette = c("#00AFBB", "#E7B800"),
            add_density = TRUE # 添加密度曲线
            )

