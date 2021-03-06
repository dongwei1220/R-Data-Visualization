# 12. MA散点图图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/12MAplot/")

# 读取示例数据
data <- read.table("demo_maplot.txt",header = T,
                   check.names = F,row.names = 1,sep="\t")
head(data)

# base plot函数绘制MA散点图
attach(data)

# 基础MAplot
plot(x=(log2(R0_fpkm)+log2(R3_fpkm))/2,y=log2FC)

# 设置点的形状，颜色，坐标轴标题
plot(x=(log2(R0_fpkm)+log2(R3_fpkm))/2,y=log2FC,
     pch=20,col=ifelse(significant=="up","red",
                       ifelse(significant=="down","green","gray")),
     main="MAplot of R3-vs-R0",
     xlab = "Log2 mean expression",ylab = "Log2 fold change")

# 添加水平线和图例
abline(h = 0,lty=1,lwd = 2,col="blue")
abline(h = c(-1,1),lty=2,lwd = 2,col="black")
# 添加图例
legend("topright", inset = 0.01, title = "Significant", c("up","no","down"), 
       pch=c(16,16,16),col = c("red","gray","green"))
detach(data)

# ggplot2包绘制MA散点图
library(ggplot2)
head(data)

# 基础MAplot
ggplot(data,aes(x=(log2(R0_fpkm)+log2(R3_fpkm))/2,y=log2FC)) + geom_point()

# 添加点的颜色，坐标轴标题
ggplot(data,aes(x=(log2(R0_fpkm)+log2(R3_fpkm))/2,y=log2FC,color=significant)) + 
  geom_point() + theme_bw() +
  labs(title="MAplot of R3-vs-R0",x="Log2 mean expression", y="Log2 fold change")

# 更改颜色，主题，添加水平线和垂直线，去掉网格线
p <- ggplot(data,aes(x=(log2(R0_fpkm)+log2(R3_fpkm))/2,y=log2FC,color=significant)) + 
  geom_point() + theme_bw() +
  labs(title="MAplot of R3-vs-R0",x="Log2 mean expression", y="Log2 fold change") +
  scale_color_manual(values = c("green","gray","red")) +
  geom_hline(yintercept=0, linetype=1, colour="black") +
  geom_hline(yintercept=c(-1,1), linetype=2, colour="gray30") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())
p

# 添加基因注释信息
library(ggrepel)
gene_selected <- c("OS12T0196300-01","OS01T0239150-00","OS01T0621400-01",
                   "OS02T0577600-00","OS11T0676100-00","OS12T0613150-00",
                   "OS01T0225500-00","OS02T0101900-01")
data_selected <- data[gene_selected,]
head(data_selected)

p + geom_text_repel(data=data_selected, show.legend = F, color="red",
                    aes(label=rownames(data_selected)))

p + geom_label_repel(data=data_selected, show.legend = F,color="blue",
                     aes(label=rownames(data_selected)))

# ggpubr包绘制MAplot
library(ggpubr)
# 加载数据集
data(diff_express)
head(diff_express)

# 基础MAplot
ggmaplot(diff_express, fdr = 0.05, fc = 2, size = 0.4,
         palette = c("red","green","gray"))

# 更改点的颜色，添加标题，更改基因注释名，字体，背景主题
ggmaplot(diff_express, main = expression("Group 1" %->% "Group 2"),
         fdr = 0.05, fc = 2, size = 0.6,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         genenames = as.vector(diff_express$name),
         xlab = "M",ylab = "A",
         legend = "top", top = 20,
         font.label = c("bold", 11),
         font.legend = "bold",
         font.main = "bold",
         ggtheme = ggplot2::theme_minimal())

# 添加基因注释边框，更换top基因筛选标准
ggmaplot(diff_express, main = expression("Group 1" %->% "Group 2"),
         fdr = 0.05, fc = 2, size = 0.4,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         genenames = as.vector(diff_express$name),
         legend = "top", top = 20,
         font.label = c("bold", 11), label.rectangle = TRUE,
         font.legend = "bold", select.top.method = "fc",
         font.main = "bold",
         ggtheme = ggplot2::theme_minimal())
