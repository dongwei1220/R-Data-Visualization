# 33. 三元图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/33ternary/")

# 使用Ternary包绘制三元图
# 安装并加载所需的R包
#install.packages("Ternary")
library(Ternary)

# 构建示例数据
coords <- list(
  A = c(1, 0, 2),
  B = c(1, 1, 1),
  C = c(1.5, 1.5, 0),
  D = c(0.5, 1.5, 1)
)
color <- c("red","blue","green","orange")
size <- c(2,3,4,5)
coords
color
size

# 使用TernaryPlot函数绘制基础三元图
TernaryPlot(alab = "X",blab = "Y",clab = "Z", lab.offset = 0.1,
            atip = "Top", btip = "Bottom", ctip = "Right", 
            axis.col = "red", grid.col = "gray",grid.minor.lines = F,
            col="gray90")
# 添加箭头
TernaryArrows(coords[1], coords[2:4], col='blue', length=0.2, lwd=1)
# 添加连线
AddToTernary(lines, coords, col='red', lty='dotted', lwd=4)
# 添加散点
TernaryPoints(coords, pch=20, cex=size, col=color)
# 添加文本信息
TernaryText(coords, cex=1.5, col='black', font=2, pos=1)

# 使用vcd包绘制三元图
# 安装并加载所需的R包
#install.packages("vcd")
library(vcd)

# 加载示例数据
data("Arthritis")
## Build table by crossing Treatment and Sex
tab <- as.table(xtabs(~ I(Sex:Treatment) + Improved, data = Arthritis))
head(tab)
## Mark groups
col <- c("red", "red", "blue", "blue")
pch <- c(1, 19, 1, 19)

## 使用ternaryplot函数绘制三元图
ternaryplot(
  tab,
  col = col,
  pch = pch,
  prop_size = TRUE,
  bg = "lightgray",
  grid_color = "white",
  labels_color = "black",
  dimnames_position = "edge",
  border = "red",
  main = "Arthritis Treatment Data"
)
## 添加图例
grid_legend(x=0.8, y=0.7, pch, col, labels = rownames(tab), title = "GROUP")

# 使用ggtern包绘制三元图
# 安装并加载所需的R包
#install.packages("ggtern")
library(ggtern)
library(ggplot2)

# 加载并查看示例数据
data(Feldspar)
head(Feldspar)

#使用ggtern函数绘制基础三元图
ggtern(data=Feldspar,aes(x=An,y=Ab,z=Or)) + 
  geom_point()

# 设置点的形状、大小和颜色
ggtern(Feldspar,aes(Ab,An,Or)) + 
  geom_point(size=5,aes(shape=Feldspar,fill=Feldspar),color='black') +
  scale_shape_manual(values=c(21,24)) + #自定义形状和颜色
  theme_rgbg() + #更换主题
  labs(title = "Demonstration of Raster Annotation")

ggtern(Feldspar,aes(Ab,An,Or)) + 
  geom_point(size=5,aes(shape=Feldspar,fill=Feldspar),color='black') +
  scale_shape_manual(values=c(21,24)) + #自定义形状和颜色
  theme_bvbw() + #更换主题
  labs(title = "Demonstration of Raster Annotation") +
  geom_smooth_tern() #添加拟合曲线

# 加载并查看示例数据
data(Fragments)
head(Fragments)

# 添加密度曲线，进行分面
ggtern(Fragments,aes(Qm+Qp,Rf,M,colour=Sample)) +
    geom_point(aes(shape=Position,size=Relief)) + 
    theme_bw(base_size=8) + 
    theme_showarrows() + # 更换主题
    geom_density_tern(h=2,aes(fill=..level..),
                    expand=0.75,alpha=0.5,bins=5) + 
    custom_percent('%') + 
    labs(title = "Grantham and Valbel Rock Fragment Data",
         x = "Q_{m+p}", xarrow = "Quartz (Multi + Poly)",
         y = "R_f",     yarrow = "Rock Fragments",
         z = "M",       zarrow = "Mica") + 
    theme_latex() + 
    facet_wrap(~Sample)

library(plyr)
#Load the Data.
data(USDA)
head(USDA)

#Put tile labels at the midpoint of each tile.
USDA.LAB <- ddply(USDA,"Label",function(df){
  apply(df[,1:3],2,mean)
})

#Tweak
USDA.LAB$Angle = sapply(as.character(USDA.LAB$Label),function(x){
  switch(x,"Loamy Sand"=-35,0)
})
head(USDA.LAB)

#Construct the plot.
ggtern(data=USDA,aes(Sand,Clay,Silt,color=Label,fill=Label)) +
  geom_polygon(alpha=0.75,size=0.5,color="black") +
  geom_mask() +  
  geom_text(data=USDA.LAB,aes(label=Label,angle=Angle),
            color="black",size=3.5) +
  theme_rgbw() + 
  theme_showsecondary() +
  theme_showarrows() +
  weight_percent() + 
  #guides(fill='none') + 
  theme_legend_position("topright") + 
  labs(title = "USDA Textural Classification Chart",
       fill  = "Textural Class",
       color = "Textural Class")

sessionInfo()
