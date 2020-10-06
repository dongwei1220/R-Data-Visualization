# 19. 峰峦图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/19ridge/")

# 使用ggridges包绘制峰峦图
library(ggridges)
library(ggplot2)

# 查看示例数据
head(iris)

# 使用geom_density_ridgesh函数绘制峰峦图
ggplot(iris, aes(x=Sepal.Length, y=Species, fill=Species)) +
  geom_density_ridges()

# 设置分面
ggplot(iris, aes(x = Sepal.Length, y = Species)) + 
  geom_density_ridges(scale = 1) + 
  facet_wrap(~Species)

# 添加jitter散点
ggplot(iris, aes(x=Sepal.Length, y=Species)) +
  geom_density_ridges(jittered_points = TRUE) + 
  theme_ridges()

# 更改散点的位置
ggplot(iris, aes(x=Sepal.Length, y=Species, fill=Species)) +
  geom_density_ridges(
    jittered_points = TRUE, 
    position = "raincloud",
    alpha = 0.8, scale = 0.5
  )

# 设置散点的大小和颜色
ggplot(iris, aes(x = Sepal.Length, y = Species, fill = Species)) +
  geom_density_ridges(
    aes(point_shape = Species, point_fill = Species, point_size = Petal.Length), 
    alpha = .2, point_alpha = 1, jittered_points = TRUE
  ) +
  scale_point_color_hue(l = 40) + 
  scale_point_size_continuous(range = c(0.5, 4)) +
  scale_discrete_manual(aesthetics = "point_shape", values = c(21, 22, 23))

library(viridis)
head(lincoln_weather)

ggplot(lincoln_weather, aes(x = `Mean Temperature [F]`, y = `Month`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [F]", option = "C") +
  labs(
    title = 'Temperatures in Lincoln NE',
    subtitle = 'Mean temperatures (Fahrenheit) by month for 2016\nData: Original CSV from the Weather Underground'
  ) +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
