# 17. tSNE图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/17tsne/")

# 查看示例数据
head(iris)

# 使用tsne包进行tSNE降维可视化分析
# 加载tsne包
library(tsne)

colors = rainbow(length(unique(iris$Species)))
names(colors) = unique(iris$Species)
head(colors)

# 使用tsne函数进行tSNE降维分析
tsne_iris = tsne(iris[,1:4],k=2,perplexity=50)
# 查看tSNE降维后的结果
head(tsne_iris)

# 使用基础plot函数可视化tSNE降维后的结果
plot(tsne_iris,col=colors[iris$Species],pch=16,
     xlab = "tSNE_1",ylab = "tSNE_2",main = "tSNE plot")
# 添加分隔线
abline(h=0,v=0,lty=2,col="gray")
# 添加图例
legend("topright",title = "Species",inset = 0.01,
       legend = unique(iris$Species),pch=16,
       col = unique(colors[iris$Species]))

# 使用Rtsne包进行tSNE降维可视化分析
# 加载Rtsne包
library(Rtsne)

iris_unique <- unique(iris) # Remove duplicates
iris_matrix <- as.matrix(iris_unique[,1:4])
head(iris_matrix)

# Set a seed if you want reproducible results
set.seed(42)
# 使用Rtsne函数进行tSNE降维分析
tsne_out <- Rtsne(iris_matrix,pca=FALSE,dims=2,
                  perplexity=30,theta=0.0) # Run TSNE
head(tsne_out)
# Show the objects in the 2D tsne representation
plot(tsne_out$Y,col=iris_unique$Species, asp=1,pch=20,
     xlab = "tSNE_1",ylab = "tSNE_2",main = "tSNE plot")
# 添加分隔线
abline(h=0,v=0,lty=2,col="gray")
# 添加图例
legend("topright",title = "Species",inset = 0.01,
       legend = unique(iris_unique$Species),pch=16,
       col = unique(iris_unique$Species))

# data.frame as input
set.seed(42)
# 更改perplexity和theta值
tsne_out <- Rtsne(iris_unique,pca=FALSE,
                  perplexity = 20,theta=0.5)
head(tsne_out)

# 使用ggplot2包可视化tSNE降维的结果
library(ggplot2)

tsne_res <- as.data.frame(tsne_out$Y)
colnames(tsne_res) <- c("tSNE1","tSNE2")
head(tsne_res)

# 使用ggplot2可视化tSNE降维的结果
ggplot(tsne_res,aes(tSNE1,tSNE2,color=iris_unique$Species)) + 
  geom_point() + theme_bw() + 
  geom_hline(yintercept = 0,lty=2,col="red") + 
  geom_vline(xintercept = 0,lty=2,col="blue",lwd=1) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  labs(title = "tSNE plot",color="Species")
