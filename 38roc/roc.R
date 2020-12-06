# 38. ROC曲线图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/38roc/")

# 使用ROCR包绘制ROC曲线
# 安装并加载所需的R包
#install.packages("ROCR")
library(ROCR)

# 查看内置示例数据
data(ROCR.simple)
head(ROCR.simple)

#使用prediction()函数构建prediction对象
pred <- prediction(predictions = ROCR.simple$predictions, 
                   labels = ROCR.simple$labels);
pred

# 不同评估值的计算方法
#ROC curves:
#  measure="tpr", x.measure="fpr".
#
#Precision/recall graphs:
#  measure="prec", x.measure="rec".
#
#Sensitivity/specificity plots:
#  measure="sens", x.measure="spec".
#
#Lift charts:
#  measure="lift", x.measure="rpp".

# 计算ROC值并绘制ROC曲线
## computing a simple ROC curve (x-axis: fpr, y-axis: tpr)
perf <- performance(prediction.obj = pred,
                    measure = "tpr",
                    x.measure = "fpr")
perf
plot(perf,colorize=TRUE,
     main="ROCR fingerpainting toolkit",
     xlab="Mary's axis", ylab="", 
     box.lty=7, box.lwd=2, box.col="gray")

## 计算曲线下的面积即AUC值
auc<-  performance(pred,"auc")
auc
auc_area<-slot(auc,"y.values")[[1]]
# 保留4位小数
auc_area<-round(auc_area,4)
#添加文本注释
text_auc<-paste("AUC=", auc_area,sep="")
text(0.25,0.9,text_auc)

## precision/recall curve (x-axis: recall, y-axis: precision)
perf1 <- performance(pred, "prec", "rec")
plot(perf1,colorize=T)

## sensitivity/specificity curve (x-axis: specificity, y-axis: sensitivity)
perf1 <- performance(pred, "sens", "spec")
plot(perf1,colorize=T)

# 使用pROC包绘制ROC曲线图
#安装并加载所需的R包
#install.packages("pROC")
library(pROC)
library(ggplot2)

# 查看内置数据集
data("aSAH")
head(aSAH)

# 使用roc()函数计算ROC值并绘制ROC曲线
#roc(aSAH$outcome ~ aSAH$s100b)
roc.s100b <- roc(outcome ~ s100b, aSAH, levels=c("Good", "Poor"))
roc.s100b
# 绘制基础ROC曲线
plot(roc.s100b)

# 绘制平滑ROC曲线
# Add a smoothed ROC:
plot(smooth(roc.s100b), add=TRUE, col="blue")
# 添加图例
legend("topright", legend=c("Empirical", "Smoothed"),
       col=c(par("fg"), "blue"), lwd=2)

# 添加一些参数美化ROC曲线
plot(roc.s100b, 
     print.auc=TRUE, #设置是否添加AUC值标签
     auc.polygon=TRUE, #设置是否添加AUC值面积多边形
     max.auc.polygon=TRUE, #设置是否添加最大AUC值面积多边形
     auc.polygon.col="skyblue", #设置AUC值面积多边形的填充色
     grid=c(0.1, 0.2), #添加网格线
     grid.col=c("green", "red"), #设置网格线颜色
     print.thres=TRUE)

# To plot a different partial AUC, we need to ignore the existing value
# with reuse.auc=FALSE:
plot(roc.s100b, print.auc=TRUE, auc.polygon=TRUE, 
     partial.auc=c(1, 0.8), # 计算选定范围的AUC值
     partial.auc.focus="sp", # 高亮关注选定范围的AUC值
     grid=c(0.1, 0.2), grid.col=c("green", "red"),
     max.auc.polygon=TRUE, auc.polygon.col="lightblue", 
     print.thres=TRUE, print.thres.adj = c(1, -1),
     reuse.auc=FALSE)

roc.wfns <- roc(aSAH$outcome, aSAH$wfns)
roc.ndka <- roc(aSAH$outcome, aSAH$ndka)
# Add a second ROC curve to the previous plot:
plot(roc.s100b, col="red")
plot(roc.wfns, col="blue", add=TRUE)
plot(roc.ndka, col="green", add=TRUE)

# 使用ggcor()函数绘制基于ggplot2的ROC曲线
ggroc(roc.s100b, 
      alpha = 0.5, colour = "red", 
      linetype = 2, size = 2) +
  theme_minimal() + 
  ggtitle("My ROC curve") + 
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), 
               color="grey", linetype="dashed")

# 绘制多条ROC曲线
# Multiple curves:
ggroc(list(s100b=roc.s100b, wfns=roc.wfns, ndka=roc.ndka))

# This is equivalent to using roc.formula:
roc.list <- roc(outcome ~ s100b + ndka + wfns, data = aSAH)
g.list <- ggroc(roc.list, aes=c("linetype", "color"))
g.list

# 分面展示
# OR faceting
g.list + facet_grid(.~name) + 
  theme_bw() 

# 使用survivalROC包绘制时间依赖的ROC曲线
# 安装并加载所需的R包
#install.packages("survivalROC")
library(survivalROC)

# 查看内置数据集
data(mayo)
head(mayo)

# 计算数据的行数
nobs <- NROW(mayo)
nobs
# 自定义阈值
cutoff <- 365

# 使用MAYOSCORE 4作为marker, 并用NNE（Nearest Neighbor Estimation）法计算ROC值
Mayo4.1 = survivalROC(Stime=mayo$time,  
                      status=mayo$censor,      
                      marker = mayo$mayoscore4,     
                      predict.time = cutoff,
                      span = 0.25*nobs^(-0.20) )
Mayo4.1

# 绘制ROC曲线
plot(Mayo4.1$FP, Mayo4.1$TP, type="l", 
     xlim=c(0,1), ylim=c(0,1), col="red",  
     xlab=paste( "FP", "\n", "AUC = ",round(Mayo4.1$AUC,3)), 
     ylab="TP",main="Mayoscore 4, Method = NNE \n  Year = 1")
# 添加对角线
abline(0,1)

# 使用KM（Kaplan-Meier）法计算ROC值
## MAYOSCORE 4, METHOD = KM
Mayo4.2= survivalROC(Stime=mayo$time,  
                     status=mayo$censor,      
                     marker = mayo$mayoscore4,     
                     predict.time =  cutoff, method="KM")
plot(Mayo4.2$FP, Mayo4.2$TP, type="l", 
     xlim=c(0,1), ylim=c(0,1), col="blue",
     xlab=paste( "FP", "\n", "AUC = ",round(Mayo4.2$AUC,3)), 
     ylab="TP",main="Mayoscore 4, Method = KM \n Year = 1")
abline(0,1,lty=2,col="gray")

# 将两种方法的结果绘制到同一个图里
## 绘制NNE法计算的ROC曲线
plot(Mayo4.1$FP, Mayo4.1$TP,
     type="l",col="red",
     xlim=c(0,1), ylim=c(0,1),   
     xlab="FP", 
     ylab="TP",
     main="Time dependent ROC")
# 添加对角线
abline(0,1,col="gray",lty=2)

## 添加KM法计算的ROC曲线
lines(Mayo4.2$FP, Mayo4.2$TP, 
      type="l",col="blue",
      xlim=c(0,1), ylim=c(0,1))
# 添加图例
legend("bottomright",legend = c(paste("AUC of NNE =",round(Mayo4.1$AUC,3)),
                          paste("AUC of KM =",round(Mayo4.2$AUC,3))),
       col=c("red","blue"),
       lty= 1 ,lwd= 2)

sessionInfo()