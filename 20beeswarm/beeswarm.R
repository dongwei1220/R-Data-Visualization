# 20. 蜂群图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/20beeswarm/")

# 使用beeswarm包绘制蜂群图
# 安装并加载所需的R包
#install.packages("beeswarm")
library(beeswarm)

# 查看示例数据
data(breast)
head(breast)

# 使用beeswarm函数绘制蜂群图
beeswarm(time_survival ~ ER, 
         data = breast,pch = 16,
         pwcol = 1 + as.numeric(event_survival),
         xlab = "", ylab = "Follow-up time (months)",
         labels = c("ER neg", "ER pos"))
# 添加图例
legend("topright", legend = c("Yes", "No"),
       title = "Censored", pch = 16, col = 1:2)

# 构建数据集
distributions <- list(runif = runif(200, min = -3, max = 3), 
                      rnorm = rnorm(200),
                      rlnorm = rlnorm(200, sdlog = 0.5))
head(distributions)

beeswarm(distributions, col = 2:4)

## Demonstrate 'pwcol' with the list interface 
myCol <- lapply(distributions, function(x) cut(x, breaks = quantile(x), labels = FALSE))
myCol
beeswarm(distributions, pch = 16, pwcol = myCol)
# 添加图例
legend("topright", legend = 1:4, pch = 16, col = 1:4, title = "Quartile")

## Compare the 4 methods
# 使用method参数设置蜂群点分布的方法
op <- par(mfrow = c(2,2))
for (m in c("swarm", "center", "hex", "square")) {
  beeswarm(distributions, method = m, 
           main = paste0("method = ", m), 
           pch = 16, pwcol = myCol)
}
par(op)

## Demonstrate the 'corral' methods
# 使用corral参数调整组外离群点的分布
op <- par(mfrow = c(2,3))
beeswarm(distributions, col = 2:4, 
         main = 'corral = "none" (default)')
beeswarm(distributions, col = 2:4, corral = "gutter", 
         main = 'corral = "gutter"')
beeswarm(distributions, col = 2:4, corral = "wrap", 
         main = 'corral = "wrap"')
beeswarm(distributions, col = 2:4, corral = "random", 
         main = 'corral = "random"')
beeswarm(distributions, col = 2:4, corral = "omit", 
         main = 'corral = "omit"')  
par(op)

## Demonstrate 'side' and 'priority'
# 调整蜂群点的排序和分布形式
op <- par(mfrow = c(2,3))
beeswarm(distributions, col = 2:4, 
         main = 'Default')
beeswarm(distributions, col = 2:4, side = -1, 
         main = 'side = -1')
beeswarm(distributions, col = 2:4, side = 1, 
         main = 'side = 1')
beeswarm(distributions, col = 2:4, priority = "descending", 
         main = 'priority = "descending"')
beeswarm(distributions, col = 2:4, priority = "random", 
         main = 'priority = "random"')  
beeswarm(distributions, col = 2:4, priority = "density", 
         main = 'priority = "density"')  
par(op)

# 使用ggbeeswarm包绘制蜂群图
#install.packages("ggbeeswarm")
library(ggbeeswarm)

# 查看示例数据
head(breast)

# 使用geom_beeswarm函数绘制蜂群图
ggplot(breast,aes(x=ER,y=time_survival))+
  geom_beeswarm(aes(color=factor(event_survival)),cex=1.5,size=2)+
  theme_bw()+
  labs(x="",y="Follow-up time (months)") + 
  scale_color_manual(values=c("black","red"),name="Censored",labels=c("Yes","No")) +
  scale_x_discrete(labels=c("ER neg","ER pos"))






