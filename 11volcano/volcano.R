# 11.火山图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/11volcano/")

# 读取示例数据
data <- read.table("demo_volcano.txt",header = T,
                   check.names = F,row.names = 1,sep="\t")
head(data)

# base plot函数绘制火山图
attach(data)
# 基础火山图
plot(x=`log2_Ratio(WT0/LOG)`,y=-1*log10(FDR))
# 添加颜色和标题
plot(x=`log2_Ratio(WT0/LOG)`,y=-1*log10(FDR),
     type = "p", pch=20, col=significant,
     main="Volcano plot",
     xlab="log2(FC)",ylab="-log10(FDR)")
# 添加水平线和垂直线
abline(v=c(-1,1),lty=2,lwd = 2,col="red")
abline(h=-log10(0.05),lty=2,lwd=2,col="blue")
# 添加图例
legend("topright", inset = 0.01, title = "Significant", c("yes","no"), 
       pch=c(16,16),col = c("red","black"))
# 添加gene注释信息
gene_selected <- c("Unigene0034898","Unigene0038455","Unigene0003997",
                   "Unigene0026444","Unigene0039482","Unigene0028163"
                   )
data_selected <- data[gene_selected,]
text(x=data_selected$`log2_Ratio(WT0/LOG)`,y=-1*log10(data_selected$FDR),
     labels = rownames(data_selected),col="red",adj = 0.5)
detach(data)

# ggplot2包绘制火山图
library(ggplot2)
head(data)

# 基础火山图
ggplot(data,aes(`log2_Ratio(WT0/LOG)`,-log10(FDR))) + geom_point()
# 添加颜色和标题
ggplot(data,aes(`log2_Ratio(WT0/LOG)`,-log10(FDR),color=significant)) + 
  geom_point() + 
  labs(title="Volcano plot",x=expression(log[2](FC)), y=expression(-log[10](FDR)))
# 更改颜色，主题，添加水平线和垂直线，去掉网格线
p <- ggplot(data,aes(`log2_Ratio(WT0/LOG)`,-log10(FDR),color=significant)) + 
  geom_point() + theme_bw() + 
  labs(title="Volcano plot",x=expression(log[2](FC)), y=expression(-log[10](FDR))) +
  scale_color_manual(values = c("blue","red")) +
  geom_vline(xintercept=-1, linetype=2, colour="gray30") +
  geom_vline(xintercept=1, linetype=2, colour="gray30") +
  geom_hline(yintercept=-log(0.05), linetype=2, colour="gray30") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())
p
# 添加基因注释信息
library(ggrepel)
p + geom_text_repel(data=data_selected, show.legend = F,
                    aes(label=rownames(data_selected)))

p + geom_label_repel(data=data_selected, show.legend = F,
                     aes(label=rownames(data_selected)))

# ggpubr包绘制火山图
library(ggpubr)
data$FDR <- -log10(data$FDR)
data$FC <- data$`log2_Ratio(WT0/LOG)`
head(data)

# 基础火山图
ggscatter(data,x="FC",y="FDR")
# 添加颜色，标题，坐标轴标签
ggscatter(data,x="FC",y="FDR",size = 1.5,
          color = "significant", palette = c("#BBBBBB","#CC0000"),
          title = "Volcano plot",xlab = "log2(FC)",ylab = "-log10(FDR)")
# 添加水平线和垂直线，标题居中
ggscatter(data,x="FC",y="FDR",size = 1.5,
          color = "significant", palette = c("#BBBBBB","#CC0000"),
          title = "Volcano plot",xlab = "log2(FC)",ylab = "-log10(FDR)") +
  geom_vline(xintercept=c(-1,1), linetype=2, colour="gray30") +
  geom_hline(yintercept=-log(0.05), linetype=2, colour="gray30") +
  theme(plot.title = element_text(hjust = 0.5))
