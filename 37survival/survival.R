# 37. 生存曲线图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/37survival/")

# 使用survival包进行生存分析
# 安装并加载所需的R包
#install.packages("survival") # 安装survival包
library(survival) # 加载包

#查看内置数据集
head(aml)
#time # 生存时间，天数；
#status # 生存状态，0为截尾(删失值)，1为死亡；
#x # 分组变量，Maintained和Nonmaintained

# 构建生存对象
Surv(aml$time, aml$status)

# 使用survfit()函数来拟合Kaplan-Meier生存曲线
fit <- survfit(Surv(time, status) ~ x, data = aml)

# 查看生存曲线拟合结果
fit
summary(fit)

# 绘制基础KM生存曲线
plot(fit,xlab="Time(Days)",ylab="Survival probability",
     col=c("blue","red"),lty=2:3,lwd=2) 
# 添加图例
legend("topright",c("Maintained","Nonmaintained"),
       col=c("blue","red"),lty=2:3,lwd=2,cex=1)

# 使用survminer包绘制生存曲线
# 安装并加载所需的R包
#install.packages("survminer") # 安装survminer包
library(survminer) # 加载包

# 查看内置数据集
head(lung)
#time # 生存时间，天数；
#status # 生存状态，1为截尾数据，2为死亡数据；
#age # 年龄；
#sex # 分组数据，性别：1为男性，2为女性；

# 使用survfit()函数拟合KM生存曲线
fit <- survfit(Surv(time, status) ~ sex, data = lung)

# 使用ggsurvplot()函数绘制基础KM生存曲线
ggsurvplot(fit, data = lung)

# Change font size, style and color
ggsurvplot(fit, data = lung,  
           main = "Survival curve", # 添加标题
           font.main = c(16, "bold", "darkblue"), # 设置标题字体大小、格式和颜色
           font.x = c(14, "bold.italic", "red"), # 设置x轴字体大小、格式和颜色
           font.y = c(14, "bold.italic", "darkred"), # 设置y轴字体大小、格式和颜色
           font.tickslab = c(12, "plain", "darkgreen")) # 设置坐标轴刻度字体大小、格式和颜色


# Customized survival curves
ggsurvplot(fit, data = lung,
           surv.median.line = "hv", # 添加中位数生存时间线
           
           # Change legends: title & labels
           legend.title = "Sex", # 设置图例标题
           legend.labs = c("Male", "Female"), # 指定图例分组标签
           
           # Add p-value and tervals
           pval = TRUE, # 设置添加P值
           pval.method = TRUE, #设置添加P值计算方法
           conf.int = TRUE, # 设置添加置信区间
           
           # Add risk table
           risk.table = TRUE, # 设置添加风险因子表
           tables.height = 0.2, # 设置风险表的高度
           tables.theme = theme_cleantable(), # 设置风险表的主题
           
           # Color palettes. Use custom color: c("#E7B800", "#2E9FDF"),
           # or brewer color (e.g.: "Dark2"), or ggsci color (e.g.: "jco")
           palette = c("#E7B800", "#2E9FDF"), # 设置颜色画板
           ggtheme = theme_bw() # Change ggplot2 theme
)

# 绘制分面生存曲线
# 查看示例数据
head(colon)

# 拟合KM生存曲线
fit <- survfit( Surv(time, status) ~ sex, data = colon)

# 使用ggsurvplot_facet()函数绘制分面生存曲线
ggsurvplot_facet(fit, colon, 
                 facet.by = "rx", # 设置分面变量
                 palette = "jco", # 设置颜色画板
                 pval = TRUE) # 添加pvalue值
                 
# Facet by two grouping variables: rx and adhere
ggsurvplot_facet(fit, colon, 
                 facet.by = c("rx", "adhere"),
                 palette = "npg", 
                 pval = TRUE,
                 surv.median.line = "hv",  # 增加中位生存时间
                 conf.int = TRUE) # 增加置信区间)

# 拟合多个分组变量
fit2 <- survfit( Surv(time, status) ~ sex + rx, data = colon )
fit2

ggsurvplot_facet(fit2, colon, 
                 facet.by = "adhere",
                 palette = "lancet", 
                 pval = TRUE,
                 pval.method = TRUE,
                 surv.median.line = "hv")

sessionInfo()