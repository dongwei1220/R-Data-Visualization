# 30. TreeMap树图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/30treemap/")

# 使用treemap包绘制矩形树状图
# 安装并加载所需的R包
#install.packages("treemap")
library(treemap)

# 加载并查看示例数据
data(GNI2014)
head(GNI2014)

# 使用treemap函数绘制矩形树状图
treemap(GNI2014,
        index="continent", #指定分组的列
        vSize="population", #指定面积大小的列
        vColor="GNI", #指定颜色深浅的列
        type="value", #指定颜色填充数据的类型
        format.legend = list(scientific = FALSE, big.mark = " "))

# colors indicate density (like a population density map)
treemap(GNI2014,
        index=c("continent","country"), #指定多个分组的列，先按continent分组，再按country分组
        vSize="population", #指定面积大小的列
        vColor="GNI", #指定颜色深浅的列
        type="dens")

# manual set the color palettes
treemap(GNI2014,
        index=c("continent","country"), #指定多个分组的列
        vSize="population", #指定面积大小的列
        vColor="GNI", #指定颜色深浅的列
        type="manual", #自定义颜色类型
        palette = terrain.colors(10))

treemap(GNI2014,
        index=c("continent","country"), #指定多个分组的列
        vSize="population", #指定面积大小的列
        vColor="GNI", #指定颜色深浅的列
        type = "value",
        palette = "RdYlBu", #自定义颜色画板
        #range = c(100,10000), #设置颜色的范围值
        fontsize.labels=c(12, 10), #设置标签字体大小
        align.labels=list(c("center", "center"), c("left", "top")), #设置标签对齐的方式
        border.col=c("black","red"), #设置边框的颜色  
        border.lwds=c(4,2), #设置边框的线条的宽度
        title = "My TreeMap" #设置主标题
        )


# 使用treemapify包绘制矩形树状图
# 安装并加载所需的R包
#install.packages("treemapify")
library(treemapify)
library(ggplot2)

# 查看内置示例数据
head(G20)

# 使用geom_treemap函数绘制矩形树状图
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi)) +
  geom_treemap()

# 添加label标签，设置字体大小和类型
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi, label = country)) +
  geom_treemap() +
  geom_treemap_text(fontface = "italic", colour = "white", 
                    size = 16, place = "centre")

# 添加多个分组信息
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi,
                label = country,
                subgroup = region)) +
  geom_treemap() +
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(place = "centre", alpha = 0.5, 
                             colour = "black", fontface = "italic") +
  geom_treemap_text(colour = "white", place = "topleft", reflow = T) +
  scale_fill_gradientn(colours = c("blue","white","tomato"))

sessionInfo()
