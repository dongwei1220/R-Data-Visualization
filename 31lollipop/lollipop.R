# 31. 棒棒糖图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/31lollipop/")

# 使用ggplot2包绘制棒棒糖图
library(ggplot2)

# 查看内置示例数据
data("mtcars")
df <- mtcars
# 转换为因子
df$cyl <- as.factor(df$cyl)
df$name <- rownames(df)
head(df)

# 绘制基础棒棒糖图
ggplot(df,aes(name,mpg)) + 
  # 添加散点
  geom_point(size=5) + 
  # 添加辅助线段
  geom_segment(aes(x=name,xend=name,y=0,yend=mpg))

# 更改点的大小，形状，颜色和透明度
ggplot(df,aes(name,mpg)) + 
  # 添加散点
  geom_point(size=5, color="red", fill=alpha("orange", 0.3), 
             alpha=0.7, shape=21, stroke=3) + 
  # 添加辅助线段
  geom_segment(aes(x=name,xend=name,y=0,yend=mpg)) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1),
        panel.grid = element_blank())

# 更改辅助线段的大小，颜色和类型
ggplot(df,aes(name,mpg)) + 
  # 添加散点
  geom_point(aes(size=cyl,color=cyl)) + 
  # 添加辅助线段
  geom_segment(aes(x=name,xend=name,y=0,yend=mpg),
               size=1, color="blue", linetype="dotdash") +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1),
        panel.grid = element_blank()) +
  scale_y_continuous(expand = c(0,0))

# 对点进行排序，坐标轴翻转
# 根据mpg值从小到大排序
df <- df[order(df$mpg),]
# 设置因子进行排序
df$name <- factor(df$name,levels = df$name)

ggplot(df,aes(name,mpg)) + 
  # 添加散点
  geom_point(aes(color=cyl),size=8) + 
  # 添加辅助线段
  geom_segment(aes(x=name,xend=name,y=0,yend=mpg),
               size=1, color="gray") +
  theme_minimal() + 
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  coord_flip()

# 使用ggpubr包绘制棒棒糖图
library(ggpubr)

# 查看示例数据
head(df)

# 使用ggdotchart函数绘制棒棒糖图
ggdotchart(df, x = "name", y = "mpg",
           color = "cyl", # 设置按照cyl填充颜色
           size = 6, # 设置点的大小
           palette = c("#00AFBB", "#E7B800", "#FC4E07"), # 修改颜色画板
           sorting = "ascending", # 设置升序排序                        
           add = "segments", # 添加辅助线段
           add.params = list(color = "lightgray", size = 1.5), # 设置辅助线段的大小和颜色
           ggtheme = theme_pubr(), # 设置主题
)
  
# 自定义一些参数
ggdotchart(df, x = "name", y = "mpg",
           color = "cyl", # 设置按照cyl填充颜色
           size = 8, # 设置点的大小
           palette = "jco", # 修改颜色画板
           sorting = "descending", # 设置降序排序                        
           add = "segments", # 添加辅助线段
           add.params = list(color = "lightgray", size = 1.2), # 设置辅助线段的大小和颜色
           rotate = TRUE, # 旋转坐标轴方向
           group = "cyl", # 设置按照cyl进行分组
           label = "mpg", # 按mpg添加label标签
           font.label = list(color = "white", 
                             size = 7, 
                             vjust = 0.5), # 设置label标签的字体颜色和大小
           ggtheme = theme_pubclean(), # 设置主题
)

sessionInfo()
