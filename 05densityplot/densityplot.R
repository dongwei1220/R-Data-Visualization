# 05.密度分布图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/05densityplot/")

# 基础plot函数绘制密度分布图
data <- read.table("demo_density.txt",header = T,row.names = 1,check.names = F)
head(data)
data <- as.data.frame(t(data))
gene_num <- ncol(data)
# 绘制第一个基因的密度分布图
plot(density(data[,1]), col=rainbow(gene_num)[1], lty=1, 
     xlab = "Expression level", main = names(data)[1])
polygon(density(data[,1]),col=rainbow(gene_num)[1])

# 绘制所有基因的密度分布图
plot(density(data[,1]), col=rainbow(gene_num)[1], lty=1, 
     xlab = "Expression level", ylim = c(0,1.5), main = "")
#polygon(density(data[,1]),col=rainbow(gene_num)[1])
# 添加其他基因的密度曲线
for (i in seq(2,gene_num)){
  lines(density(data[,i]), col=rainbow(gene_num)[i], lty=i)
  #polygon(density(data[,i]),col=rainbow(gene_num)[i])
}
# 添加图例
legend("topright", inset = 0.02, title = "Gene", names(data), 
       col = rainbow(gene_num), lty = seq(1,gene_num), 
       bg = "gray")

# ggplot2包绘制密度分布图
library(ggplot2)
library(reshape2)
data <- read.table("demo_density.txt",header = T,check.names = F)
data <- melt(data)
head(data)
# 使用geom_density函数绘制密度分布曲线
ggplot(data,aes(value,fill=gene, color=gene)) + 
  xlab("Expression level") + 
  geom_density(alpha = 0.6) + 
  geom_rug() + theme_bw()

# 使用geom_line函数绘制密度分布曲线
ggplot(data,aes(value,..density.., color=gene))  +
  geom_line(stat="density") + 
  theme_bw() + facet_wrap(.~gene) +
  theme(axis.title = element_text(size=14),
        axis.text=element_text(size=14))

# ggpubr包绘制密度分布图
data <- read.table("demo_density.txt",header = T,check.names = F)
data <- melt(data)
head(data)
library(ggpubr)
# 使用ggdensity函数绘制密度分布曲线
ggdensity(data, x = "value", 
          rug = TRUE, xlab = "Expression level",
          color = "gene", fill = "gene")
# 添加分面
ggdensity(data, x = "value", 
          facet.by = "gene", linetype = "gene",
          rug = TRUE, xlab = "Expression level",
          color = "gene", fill = "gene")
