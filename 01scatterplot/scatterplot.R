# 01.散点图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/01scatterplot/")

# 读取示例数据
data <- read.table("demo_scatterplot.txt", header = T, check.names = F)
# 查看数据
head(data)
dim(data)

# base plot函数绘制散点图
attach(data)
plot(BRCA1, BRCA2, col="red", pch=16)
# 线性拟合
lm.fit <- lm(BRCA2 ~ BRCA1)
# 查看拟合结果
summary(lm.fit)
# 添加拟合曲线
abline(lm.fit, lty=2, lwd = 2, col="blue")
# 计算pearson相关性
cor_pearson <- cor.test(BRCA1, BRCA2, method = "pearson")
cor_pearson
cor_coef <- cor_pearson$estimate
cor_pvalue <- cor_pearson$p.value

plot(BRCA1,BRCA2,col="red",pch=16,
     main = paste0("Pearson r = ",round(cor_coef,digits = 2)," P-value = ",cor_pvalue))
# 添加拟合直线
abline(lm.fit, lty=2, lwd = 2, col="blue")
# 添加拟合直线方程
a <- lm.fit$coefficients[2]
b <- lm.fit$coefficients[1]
a <- round(a, 3)
b <- round(b, 3)
text(x = -0.4, y = 0.2, labels = paste("y = ", a, " * x + ", b, sep = ""), cex = 1.5)
detach(data)

# ggplot2包绘制散点图
library(ggplot2)
library(ggpubr)
p1 <- ggplot(data = data, mapping = aes(x = BRCA1, y = BRCA2)) + 
  geom_point(colour = "red", size = 2) + 
  geom_smooth(method = lm, colour='blue', fill='gray') #添加拟合曲线
p1

p1 + stat_cor(method = "pearson", label.x = -0.4, label.y = 0.2) #添加pearson相关系数

# ggpubr包绘制散点图
library(ggpubr)
ggscatter(data, x = "BRCA1", y = "BRCA2",
          color = "red", size =2, # Points color and size
          add = "reg.line",  # Add regression line
          add.params = list(color = "blue", fill = "gray"), # Customize regression line
          conf.int = TRUE, # Add confidence interval
          cor.coef = TRUE, # Add correlation coefficient. see ?stat_cor
          cor.coeff.args = list(method = "pearson"))


