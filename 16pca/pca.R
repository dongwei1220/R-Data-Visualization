# 16. PCA图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/16pca/")

# 加载示例数据
data <- read.table("demo_pca.txt",header = T,row.names = 1,sep="\t",check.names = F)
head(data)

# 数据转置，转换成行为样本，列为基因的矩阵
data <- t(data)

# 使用prcomp函数进行PCA分析
data.pca <- prcomp(data)
# 查看PCA的分析结果
summary(data.pca)
#----Standard deviation 标准差   其平方为方差=特征值
#----Proportion of Variance  方差贡献率
#----Cumulative Proportion  方差累计贡献率

# 绘制主成分的碎石图
screeplot(data.pca, npcs = 10, type = "lines")

# 查看主成分的结果
head(data.pca$x)

# 使用基础plot函数绘制PCA图
plot(data.pca$x,cex = 2,main = "PCA analysis", 
     col = c(rep("red",3),rep("blue",3)),
     pch = c(rep(16,3),rep(17,3)))
# 添加分隔线
abline(h=0,v=0,lty=2,col="gray")
# 添加标签
text(data.pca$x,labels = rownames(data.pca$x),pos = 4,offset = 0.6,cex = 1)
# 添加图例
legend("bottomright",title = "Sample",inset = 0.01,
       legend = rownames(data.pca$x),
       col = c(rep("red",3),rep("blue",3)),
       pch = c(rep(16,3),rep(17,3)))

# 使用ggplot2包绘制PCA图
library(ggplot2)

# 查看示例数据
head(USArrests)

# 使用princomp函数进行PCA分析
data.pca <- princomp(USArrests,cor = T)
# 查看PCA的结果
summary(data.pca)

# 绘制主成分碎石图
screeplot(data.pca,npcs = 6,type = "barplot")

#查看主成分的结果
pca.scores <- as.data.frame(data.pca$scores)
head(pca.scores)

# 绘制PCA图
ggplot(pca.scores,aes(Comp.1,Comp.2,col=rownames(pca.scores))) + 
  geom_point(size=3) + 
  geom_text(aes(label=rownames(pca.scores)),vjust = "outward") + 
  geom_hline(yintercept = 0,lty=2,col="red") + 
  geom_vline(xintercept = 0,lty=2,col="blue",lwd=1) +
  theme_bw() + theme(legend.position = "none") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  labs(x="PCA_1",y="PCA_2",title = "PCA analysis")

# 使用scatterplot3d包绘制三维PCA图
library(scatterplot3d)

# 加载示例数据
data <- read.table("demo_pca.txt",header = T,row.names = 1,sep="\t",check.names = F)
head(data)

# 数据转置，转换成行为样本，列为基因的矩阵
data <- t(data)

# 使用prcomp函数进行PCA分析
data.pca <- prcomp(data)

# 绘制三维PCA图
scatterplot3d(data.pca$x[,1:3],
              pch = c(rep(16,3),rep(17,3)),
              color= c(rep("red",3),rep("blue",3)),
              angle=45, main= "3D PCA plot",
              cex.symbols= 1.5,,mar=c(5, 4, 4, 5))
# 添加图例
legend("topright",title = "Sample",
       xpd=TRUE,inset= -0.01,
       legend = rownames(data.pca$x),
       col = c(rep("red",3),rep("blue",3)),
       pch = c(rep(16,3),rep(17,3)))

# 使用factoextra包绘制PCA图
library(factoextra)

# 查看示例数据
head(iris)

# 使用prcomp函数进行PCA分析
res.pca <- prcomp(iris[, -5],  scale = TRUE)
res.pca

#绘制主成分碎石图
fviz_screeplot(res.pca, addlabels = TRUE)

# 可视化PCA分析的结果
# Graph of individuals
# +++++++++++++++++++++
fviz_pca_ind(res.pca, col.ind="cos2", 
             geom = "point", # show points only
             gradient.cols = c("white", "#2E9FDF", "#FC4E07" ))

fviz_pca_ind(res.pca, label="none", habillage=iris$Species,
             addEllipses=TRUE, ellipse.level=0.95,
             palette = c("#999999", "#E69F00", "#56B4E9"))

# Graph of variables
# +++++++++++++++++++++
# Default plot
fviz_pca_var(res.pca, col.var = "steelblue")

# Control variable colors using their contributions
fviz_pca_var(res.pca, col.var = "contrib", 
             gradient.cols = c("white", "blue", "red"),
             ggtheme = theme_minimal())


# Biplot of individuals and variables
# +++++++++++++++++++++
# Keep only the labels for variables
# Change the color by groups, add ellipses
fviz_pca_biplot(res.pca, label = "var", habillage=iris$Species,
                addEllipses=TRUE, ellipse.level=0.95,
                ggtheme = theme_minimal())

sessionInfo()

