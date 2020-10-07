# 21. 雷达图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/21radar/")

# 使用fmsb包绘制雷达图
# 安装并加载所需的R包
#install.packages("fmsb")
library(fmsb)

# 构建数据集
# Data must be given as the data frame, where the first cases show maximum.
# 用于生成雷达图的最大最小值，第一行为最大值，第二行为最小值
maxmin <- data.frame(
  total=c(5, 1),
  phys=c(15, 3),
  psycho=c(3, 0),
  social=c(5, 1),
  env=c(5, 1))
head(maxmin)

set.seed(123)
dat <- data.frame(
  total=runif(3, 1, 5),
  phys=rnorm(3, 10, 2),
  psycho=c(0.5, NA, 3),
  social=runif(3, 1, 5),
  env=c(5, 2.5, 4))
head(dat)

# combine data
dat <- rbind(maxmin,dat)
head(dat)

# 使用radarchart函数绘制雷达图
radarchart(dat, 
           axistype=1, #设定axes的类型,1 means center axis label only
           seg=5, #设定网格的数目
           plty=1, #设定point连线的线型
           vlabels=c("Total\nQOL", "Physical\naspects", 
                     "Phychological\naspects", "Social\naspects", 
                     "Environmental\naspects"), 
           title="(axis=1, 5 segments, with specified vlabels)", 
           vlcex=1 #设置标签的字体粗细大小
           )

radarchart(dat, 
           axistype=2, 
           pcol=topo.colors(3), 
           plty=1, pdensity=c(5, 10, 30), 
           pangle=c(10, 45, 120), 
           pfcol=topo.colors(3), 
           title="(topo.colors, fill, axis=2)")

radarchart(dat, 
           axistype=3, pty=16, plty=2, 
           axislabcol="grey", na.itp=FALSE,
           title="(no points, axis=3, na.itp=FALSE)")

radarchart(dat, 
           axistype=1, plwd=1:5, pcol=1, centerzero=TRUE, 
           seg=4, caxislabels=c("worst", "", "", "", "best"),
           title="(use lty and lwd but b/w, axis=1,\n centerzero=TRUE, with centerlabels)")

# 使用ggradar包绘制雷达图
# 安装并加载所需的R包
#devtools::install_github("ricardo-bion/ggradar", dependencies=TRUE)
library(ggradar)

# 构建示例数据
library(dplyr)
library(scales)
library(tibble)

mtcars_radar <- mtcars %>% 
  as_tibble(rownames = "group") %>% 
  mutate_at(vars(-group), rescale) %>% 
  tail(4) %>% 
  select(1:10)
# 查看示例数据
mtcars_radar

# 使用ggradar函数绘制雷达图
ggradar(mtcars_radar)

ggradar(mtcars_radar,base.size = 12,
        values.radar = c("0%","25%","50%","75%","100%"),
        legend.title = "group",legend.text.size = 12,
        legend.position = "right")
