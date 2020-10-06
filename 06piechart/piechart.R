# 06.饼图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/06piechart/")

# 基础pie函数绘制饼图
data <- read.table("demo1_piechart.txt",header = T)
head(data)

pie(data$value)

pie(data$value,
    labels = data$group, # 添加标签
    col = c("purple", "violetred1", "green3",
            "cornsilk", "cyan") # 设置颜色
)

pie(data$value,
    labels = data$group, 
    col = c("purple", "violetred1", "green3",
            "cornsilk", "cyan"),
    clockwise = T, # 逆时针排布
    init.angle = 45 # 设置第一个扇区的初始角度
    )

pie(data$value,
    labels = data$group, # 添加标签
    col = c("purple", "violetred1", "green3",
            "cornsilk", "cyan"), # 设置颜色
    density = 20, # 设置阴影线密度
    angle = 20 + 10 * 1:5 # 设置阴影线角度
)

per.labs <- paste0(data$group,": ",round(100 * data$value / sum(data$value),2),"%")
pie(data$value,
    labels = per.labs, # 添加标签
    col = c("purple", "violetred1", "green3",
            "cornsilk", "cyan"),
    main = "pie(*, clockwise = TRUE)"
)
# 添加图例
legend("topright",legend = data$group, cex=1.0,
       fill = c("purple", "violetred1", "green3", "cornsilk", "cyan")
       )

n <- 200
pie(rep(1, n), labels = "", col = rainbow(n), border = NA,
    main = "pie(*, labels=\"\", col=rainbow(n), border=NA,..)")

# ggplot2包绘制饼图
library(ggplot2)
data <- read.table("demo1_piechart.txt",header = T)
# 计算百分比
data$percent <- paste0(round(100 * data$value / sum(data$value),2),"%")
head(data)

ggplot(data,aes(x="", y= value, fill = group)) + 
  geom_bar(stat = "identity",color="white") + theme_bw() +
  scale_fill_manual(values = c("purple", "violetred1", "green3", "cornsilk", "cyan")) +
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank()) +
  labs(x="", y="") + 
  geom_text(aes(y = value/2 + c(0, cumsum(value)[-length(value)]),
                label = paste0(group,": ", percent)), size=5) +
  coord_polar(theta = "y")

# ggpubr包绘制饼图
library(ggpubr)
data <- read.table("demo1_piechart.txt",header = T)
# 添加百分比标签列
data$labs <- paste0(data$group,": ",round(100 * data$value / sum(data$value),2),"%")
head(data)

ggpie(data,x="value", label = "labs",
      lab.pos = "in", lab.font = "5",
      fill="group", color="white",
      palette = c("purple", "violetred1", "green3", "cornsilk", "cyan"))

# pie3D函数绘制三维饼图
# 加载plotrix包
library(plotrix)
data <- read.table("demo1_piechart.txt",header = T)
# 添加百分比标签列
data$labs <- paste0(data$group,": ",round(100 * data$value / sum(data$value),2),"%")
head(data)

pie3D(data$value, labels = data$labs, 
      theta = pi/5, labelcex=1.2,
      explode = 0.1, main = "3D pie chart", 
      col = c("purple", "violetred1", "green3", "cornsilk", "cyan"))
# 添加图例
legend("topright",legend = rev(data$group), cex=1.0, inset = 0.01,
       fill = rev(c("purple", "violetred1", "green3", "cornsilk", "cyan"))
)

