# 39. 森林图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/39forest/")

# 使用survminer包中的ggforest函数绘制森林图
require("survival")
library(survminer)

# 查看内置示例数据
head(colon)

# 构建COX回归比例风险模型
model <- coxph( Surv(time, status) ~ sex + rx + adhere,
                data = colon )
# 查看cox回归模型结果
model

# 使用ggforest()函数绘制基础森林图
ggforest(model)

# 将数据集中的变量设置成因子，添加标签进行分组
colon <- within(colon, {
  sex <- factor(sex, labels = c("female", "male"))
  differ <- factor(differ, labels = c("well", "moderate", "poor"))
  extent <- factor(extent, labels = c("submuc.", "muscle", "serosa", "contig."))
})
head(colon)

# 使用coxph()函数进行COX回归分析
bigmodel <- coxph(Surv(time, status) ~ sex + rx + adhere + differ + extent + node4,
                  data = colon )
bigmodel
ggforest(bigmodel,
         main = "Hazard ratio", # 设置标题
         cpositions = c(0.08, 0.2, 0.35), # 设置前三列的相对距离
         fontsize = 0.8, # 设置字体大小
         refLabel = "reference",
         noDigits = 2) #设置保留小数点位数


# 使用forestplot包绘制森林图
# 安装并加载所需的R包
#install.packages("forestplot")
library(forestplot)

# 构建示例数据
cochrane_from_rmeta <- data.frame(
    mean  = c(NA, NA, 0.578, 0.165, 0.246, 0.700, 0.348, 0.139, 1.017, NA, 0.531), 
    lower = c(NA, NA, 0.372, 0.018, 0.072, 0.333, 0.083, 0.016, 0.365, NA, 0.386),
    upper = c(NA, NA, 0.898, 1.517, 0.833, 1.474, 1.455, 1.209, 2.831, NA, 0.731)
    )


tabletext <-cbind(
  c("", "Study", "Auckland", "Block", 
    "Doran", "Gamsu", "Morrison", "Papageorgiou", 
    "Tauesch", NA, "Summary"),
  c("Deaths", "(steroid)", "36", "1", 
    "4", "14", "3", "1", 
    "8", NA, NA),
  c("Deaths", "(placebo)", "60", "5", 
    "11", "20", "7", "7", 
    "10", NA, NA),
  c("", "OR", "0.58", "0.16", 
    "0.25", "0.70", "0.35", "0.14", 
    "1.02", NA, "0.53"))

# 查看示例数据
head(cochrane_from_rmeta)
head(tabletext)

# 使用forestplot()函数绘制基础森林图
forestplot(labeltext = tabletext, 
           mean = cochrane_from_rmeta$mean,
           lower = cochrane_from_rmeta$lower ,
           upper = cochrane_from_rmeta$upper)

# 添加一些参数美化森林图
forestplot(tabletext, 
           cochrane_from_rmeta,
           # 添加水平线
           hrzl_lines = list("1" = gpar(lty=2, lwd=2, col="black"), 
                             "3" = gpar(lty=2, lwd=2, col="black"),
                             "11" = gpar(lwd=1, columns=1:4, col = "red")),
           align = "c", # 设置左边表格中字体的对齐方式
           zero = 1, # 设置zero line的位置
           title="Hazard Ratio Plot", # 设置标题
           new_page = TRUE,
           is.summary=c(TRUE,TRUE,rep(FALSE,8),TRUE), #A vector indicating by TRUE/FALSE if the value is a summary value which means that it will have a different font-style
           clip=c(0.2,2.5), #Lower and upper limits for clipping confidence intervals to arrows
           xlog=TRUE,
           xticks.digits = 2,
           col=fpColors(box="royalblue",line="darkblue", 
                        summary="royalblue", hrz_lines = "#444444"),
           vertices = TRUE)

sessionInfo()


