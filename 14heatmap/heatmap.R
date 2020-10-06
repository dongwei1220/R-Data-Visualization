# 14. 热图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/14heatmap/")

# 使用heatmap函数绘制热图
# 使用mtcars内置数据集
x  <- as.matrix(mtcars)
head(x)
# 设置行的颜色
rc <- rainbow(nrow(x), start = 0, end = .3)
# 设置列的颜色
cc <- rainbow(ncol(x), start = 0, end = .3)
head(rc)
head(cc)

heatmap(x, #表达矩阵
        col = cm.colors(256), #设置热图颜色
        scale = "column", #对列进行归一化
        RowSideColors = rc, #设置行的颜色
        ColSideColors = cc, #设置列的颜色
        margins = c(5,10),
        xlab = "specification variables", #x轴标题
        ylab =  "Car Models", #y轴标题
        main = "heatmap(<Mtcars data>, ..., scale = \"column\")" #主标题
        )

heatmap(x, #表达矩阵
        col = topo.colors(16), #设置热图颜色
        scale = "column", #对列进行归一化
        Colv = NA, #不对列聚类
        RowSideColors = rc, #设置行的颜色
        ColSideColors = cc, #设置列的颜色
        margins = c(5,10),
        cexRow = 1.2, #设置行名字体大小
        cexCol = 1.5, #设置列名字体大小
        xlab = "specification variables", #x轴标题
        ylab =  "Car Models" #y轴标题
)

# 使用gplots包中的heatmap.2函数绘制热图
library(gplots)
x  <- as.matrix(mtcars)
rc <- rainbow(nrow(x), start=0, end=.3)
cc <- rainbow(ncol(x), start=0, end=.3)

heatmap.2(x, scale="col",
          col=redgreen,
          RowSideColors=rc,
          ColSideColors=cc,
          margin=c(5, 10),
          key=TRUE, # 添加color key
          cexRow = 1.0,
          cexCol = 1.2)

heatmap.2(x, scale="col",
          col= terrain.colors(256),
          RowSideColors=rc,
          ColSideColors=cc,
          margin=c(5, 10),
          colsep = c(7,9), #对列添加分割线
          rowsep = c(16,23), #对行添加分割线
          sepcolor = "white", #设置分割线的颜色
          xlab="specification variables", 
          ylab= "Car Models",
          main="heatmap(<Mtcars data>, ..., scale=\"column\")",
          density.info="density", # color key density info
          trace="none" # level trace
          )

# 使用ggplot2包绘热图
library(ggplot2)

# 构建测试数据集
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))
data <- expand.grid(X=x, Y=y)
data$Z <- runif(400, 0, 5)
head(data)

# 使用geom_tile()函数绘制热图
ggplot(data, aes(X, Y, fill= Z)) + 
        geom_tile()

# 更换填充颜色
# Give extreme colors:
ggplot(data, aes(X, Y, fill= Z)) + 
        geom_tile() +
        scale_fill_gradient(low="white", high="blue") +
        theme_bw() #设置主题

# Color Brewer palette
ggplot(data, aes(X, Y, fill= Z)) + 
        geom_tile() +
        scale_fill_distiller(palette = "RdPu") +
        theme_classic()

# Color Brewer palette
library(viridis)
ggplot(data, aes(X, Y, fill= Z)) + 
        geom_tile() + 
        scale_fill_viridis(discrete=FALSE) +
        theme_minimal() + theme(legend.position = "top")

# 使用lattice包中的levelplot函数绘制热图
library(lattice)

# 构建测试数据集
data <- matrix(runif(100, 0, 5) , 10 , 10)
colnames(data) <- letters[c(1:10)]
rownames(data) <- paste( rep("row",10) , c(1:10) , sep=" ")
head(data)

levelplot(data)

# 更换颜色
levelplot(t(data),cuts=30,
          col.regions=heat.colors(100),
          xlab = "",ylab = "",colorkey = list(space="top",width=2))

# 查看内置数据集
head(volcano)

# try cm.colors() or terrain.colors()
levelplot(volcano, col.regions = terrain.colors(100))

# 使用RColorBrewer包中的配色
library(RColorBrewer)
coul <- colorRampPalette(brewer.pal(8, "PiYG"))(25)
levelplot(volcano, col.regions = coul)

# 使用viridisLite包中的配色
library(viridisLite)
coul <- viridis(100)
levelplot(volcano, col.regions = coul)
