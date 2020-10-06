# 13. 富集气泡图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/13bubble/")

# 读取示例数据
data <- read.table("demo_bubble.tsv",header = T,
                   check.names = F,sep="\t")
head(data)

# 基础symbols函数绘制气泡图
head(mtcars)
attach(mtcars)

symbols(wt,mpg,circles=cyl,
        inches=0.2,
        bg=rainbow(7))
# 添加文本标签
text(wt,mpg,labels = row.names(mtcars),cex=0.7,pos = 3,offset = 0.8)

# 将圆圈换成正方形
symbols(wt,mpg,squares=cyl,
        inches=0.3,
        bg=rainbow(7))
detach(mtcars)

# ggplot2包绘制富集气泡图
library(ggplot2)
head(data)

# 基础富集气泡图
ggplot(data,aes(x=richFactor,y=Pathway,size=R0vsR3,color=-log10(Qvalue))) + geom_point()

# 更改颜色，主题，坐标轴标题
ggplot(data,aes(x=richFactor,y=Pathway,size=R0vsR3,color=-log10(Qvalue))) + 
  geom_point() + theme_bw() +
  scale_colour_gradient(low="green",high="red") + 
  labs(x="GeneRatio",y="Pathway",title="Top20 enriched pathways",
       colour=expression(-log[10]("Q Value")),size="Gene number") +
  theme(plot.title = element_text(hjust = 0.5))

# ggpubr包绘制富集气泡图
library(ggpubr)
data$`-log10(Qvalue)` <- -log10(data$Qvalue)

# 基础富集气泡图
ggscatter(data,x="richFactor",y="Pathway",
          size = "R0vsR3",color = "-log10(Qvalue)")

# 更改颜色，主题，坐标轴标题
ggscatter(data,x="richFactor",y="Pathway",
          size = "R0vsR3",color = "-log10(Qvalue)",
          xlab="GeneRatio",ylab="Pathway",
          title="Top20 enriched pathways") +
  theme_minimal() + 
  scale_colour_gradient(low="green",high="red") + 
  labs(colour=expression(-log[10]("Q Value")),size="Gene number") +
  theme(plot.title = element_text(hjust = 0.5),legend.position = "right")


