# 08.小提琴图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/08vioplot/")

# vioplot包绘制小提琴图
library(vioplot)

# formula input
# 加载示例数据iris
data("iris")
head(iris)

vioplot(Sepal.Length~Species, data = iris, 
        main = "Sepal Length", # 设置标题
        col=c("lightgreen", "lightblue", "palevioletred")) # 设置小提琴颜色
# 添加图例
legend("topleft", legend=c("setosa", "versicolor", "virginica"),
       fill=c("lightgreen", "lightblue", "palevioletred"), cex = 1.2)

# 加载示例数据
data("diamonds", package = "ggplot2")
head(diamonds)

# 设置画板颜色
palette <- RColorBrewer::brewer.pal(9, "Pastel1")
palette
par(mfrow=c(3, 1))
vioplot(price ~ cut, data = diamonds, las = 1, col = palette)
vioplot(price ~ clarity, data = diamonds, las = 2, col = palette)
vioplot(price ~ color, data = diamonds, las = 2, col = palette)

#generate example data
data_one <- rnorm(100)
data_two <- rnorm(50, 1, 2)
head(data_one)
head(data_two)
par(mfrow=c(2,2))

#colours can be customised separately, with axis labels, legends, and titles
vioplot(data_one, data_two, 
        col=c("red","blue"), #设置小提琴颜色
        names=c("data one", "data two"),
        main="data violin", 
        xlab="data class", ylab="data read")
legend("topleft", fill=c("red","blue"), legend=c("data one", "data two"))

#colours can be customised for the violin fill and border separately
vioplot(data_one, data_two, 
        col="grey85", border="purple", 
        names=c("data one", "data two"),
        main="data violin", 
        xlab="data class", ylab="data read")

#colours can also be customised for the boxplot rectange and lines (border and whiskers)
vioplot(data_one, data_two, 
        col="grey85", rectCol="lightblue", lineCol="blue",
        border="purple", names=c("data one", "data two"),
        main="data violin", xlab="data class", ylab="data read")

#these colours can also be customised separately for each violin
vioplot(data_one, data_two, 
        col=c("skyblue", "plum"), 
        rectCol=c("lightblue", "palevioletred"),
        lineCol="blue", border=c("royalblue", "purple"), 
        names=c("data one", "data two"), 
        main="data violin", xlab="data class", ylab="data read")

par(mfrow=c(1,1))
#this applies to any number of violins, given that colours are provided for each
vioplot(data_one, data_two, rnorm(200, 3, 0.5), rpois(200, 2.5),  rbinom(100, 10, 0.4),
        col=c("red", "orange", "green", "blue", "violet"), horizontal = T,
        rectCol=c("palevioletred", "peachpuff", "lightgreen", "lightblue", "plum"),
        lineCol=c("red4", "orangered", "forestgreen", "royalblue", "mediumorchid"),
        border=c("red4", "orangered", "forestgreen", "royalblue", "mediumorchid"),
        names=c("data one", "data two", "data three", "data four", "data five"),
        main="data violin", xlab="data class", ylab="data read")

# ggplot2包绘制小提琴图
library(ggplot2)
# 查看示例数据
head(diamonds)

# Basic plot
ggplot(diamonds,aes(cut,log(price),fill=cut)) + 
  geom_violin()

ggplot(diamonds,aes(cut,log(price),fill=cut)) + 
  geom_violin() + 
  scale_fill_manual(values = c("palevioletred", "peachpuff", "lightgreen", "lightblue", "plum")) +
  facet_wrap(.~clarity,ncol = 4)

ggplot(diamonds,aes(cut,log(price),fill=cut)) + 
  geom_violin() + 
  geom_boxplot(width=0.1,position = position_identity(),fill="white") +
  stat_summary(fun.y="mean",geom="point",shape=23, size=4,fill="red") +
  theme_bw() + theme(legend.position = "top")

# ggpubr包绘制小提琴图
library(ggpubr)

# 加载示例数据
data("ToothGrowth")
df <- ToothGrowth
head(df)

# Basic plot
ggviolin(df, x = "dose", y = "len", color = "supp")
# Change the plot orientation: horizontal
ggviolin(df, "dose", "len", fill = "supp",orientation = "horiz")

# Add box plot
ggviolin(df, x = "dose", y = "len", fill = "dose",
         add = "boxplot",add.params = list(fill="white"))

ggviolin(df, x = "dose", y = "len", fill = "supp",
         add = "dotplot")

# Add jitter points and
# change point shape by groups ("dose")
ggviolin(df, x = "dose", y = "len", fill = "supp",
         add = "jitter", shape = "dose")

# Add mean_sd + jittered points
ggviolin(df, x = "dose", y = "len", fill = "dose",
         add = c("jitter", "mean_sd"))

# Change error.plot to "crossbar"
ggviolin(df, x = "dose", y = "len", fill = "dose",
         add = "mean_sd", error.plot = "crossbar")

# Change colors
# Change outline colors by groups: dose
# Use custom color palette and add boxplot
ggviolin(df, "dose", "len",  color = "dose",
         palette = c("#00AFBB", "#E7B800", "#FC4E07"),
         add = "boxplot")

# Change fill color by groups: dose
# add boxplot with white fill color
ggviolin(df, "dose", "len", fill = "dose",
         palette = c("#00AFBB", "#E7B800", "#FC4E07"),
         add = "boxplot", add.params = list(fill = "white"))

ggviolin(df, "dose", "len", facet.by = "supp", color = "supp",
         palette = c("#00AFBB", "#E7B800"), add = "boxplot")


