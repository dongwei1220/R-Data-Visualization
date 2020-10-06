# 10.Upset集合图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/10upset/")

# 使用UpSetR包绘制集合图
library(UpSetR)
# 加载UpSetR包的内置数据集
movies <- read.csv(system.file("extdata", "movies.csv", package = "UpSetR"), 
                   header = T, sep = ";")
dim(movies)
head(movies)

# 基础绘图
upset(data = movies, 
      sets = c("Action", "Adventure", "Comedy", "Drama", "Mystery", 
               "Thriller", "Romance", "War", "Western"), # 指定所用的集合
      number.angles = 30, # 设置相交集合柱状图上方数字的角度
      point.size = 3.5, # 设置矩阵中圆圈的大小
      line.size = 2, # 设置矩阵中连接圆圈的线的大小
      mainbar.y.label = "Genre Intersections", # 设置y轴标签
      sets.x.label = "Movies Per Genre", # 设置x轴标签
      mb.ratio = c(0.6, 0.4), # 设置bar plot和matrix plot图形高度的占比
      order.by = "freq")

p <- upset(data = movies, 
     sets = c("Action", "Adventure", "Comedy", "Drama", "Mystery", 
              "Thriller", "Romance", "War", "Western"), # 指定所用的集合
     number.angles = 45, # 设置相交集合柱状图上方数字的角度
     point.size = 3, # 设置矩阵中圆圈的大小
     line.size = 1.5, # 设置矩阵中连接圆圈的线的大小
     mainbar.y.label = "Genre Intersections", # 设置y轴标签
     sets.x.label = "Movies Per Genre", # 设置x轴标签
     mb.ratio = c(0.7, 0.3), # 设置bar plot和matrix plot图形高度的占比
     order.by = "degree", # 更改排序的方式
     keep.order = TRUE # 保持集合按输入的顺序排序
     )

# 使用fromList函数输入列表格式的集合数据
# example of list input (list of named vectors)
listInput <- list(one = c(1, 2, 3, 5, 7, 8, 11, 12, 13), 
                  two = c(1, 2, 4, 5, 10), 
                  three = c(1, 5, 6, 7, 8, 9, 10, 12, 13))
listInput
upset(fromList(listInput), order.by = "freq")

# 使用fromExpression函数输入表达式向量格式的集合数据
# example of expression input
expressionInput <- c(one = 2, two = 1, three = 2, 
                     `one&two` = 1, `one&three` = 4, 
                     `two&three` = 1, `one&two&three` = 2)
expressionInput
upset(fromExpression(expressionInput), order.by = "freq",point.size = 2,line.size = 1)

# 使用set.metadata参数添加元数据信息
# 构建metadata信息
sets <- names(movies[3:19])
avgRottenTomatoesScore <- round(runif(17, min = 0, max = 90))
metadata <- as.data.frame(cbind(sets, avgRottenTomatoesScore))
names(metadata) <- c("sets", "avgRottenTomatoesScore")
head(metadata)
metadata$avgRottenTomatoesScore <- as.numeric(as.character(metadata$avgRottenTomatoesScore))

# 添加元数据条形图
upset(movies, 
      sets = c("Action", "Adventure", "Comedy", "Drama", "Mystery", "Thriller", "Romance", "War", "Western"),
      set.metadata = list(data = metadata, 
                          plots = list(list(type = "hist", column = "avgRottenTomatoesScore", assign = 20))))

# 添加元数据热图
Cities <- sample(c("Boston", "NYC", "LA"), 17, replace = T)
metadata <- cbind(metadata, Cities)
metadata$Cities <- as.character(metadata$Cities)
metadata[which(metadata$sets %in% c("Drama", "Comedy", "Action", "Thriller", "Romance")), ]
head(metadata)

upset(movies, 
      sets = c("Drama", "Comedy", "Action", "Thriller", "Romance"),
      set.metadata = list(data = metadata, 
                          plots = list(list(type = "heat", column = "Cities", assign = 10, colors = c(Boston = "green", NYC = "navy", LA = "purple")))))

upset(movies, 
      sets = c("Drama", "Comedy", "Action", "Thriller", "Romance"),
      set.metadata = list(data = metadata, 
                          plots = list(list(type = "heat", column = "Cities", assign = 10, colors = c(Boston = "green", NYC = "navy", LA = "purple")), 
                                       list(type = "heat", column = "avgRottenTomatoesScore", assign = 10))))

# 添加元数据文本
upset(movies, 
      sets = c("Drama", "Comedy", "Action", "Thriller", "Romance"),
      set.metadata = list(data = metadata, 
                          plots = list(list(type = "text", column = "Cities", assign = 10, colors = c(Boston = "green", NYC = "navy", LA = "purple")))))

# 添加元数据矩阵条形图
upset(movies, 
      sets = c("Drama", "Comedy", "Action", "Thriller", "Romance"),
      set.metadata = list(data = metadata, 
                          plots = list(list(type = "hist", column = "avgRottenTomatoesScore", assign = 20), 
                                       list(type = "matrix_rows", column = "Cities", colors = c(Boston = "green", NYC = "navy", LA = "purple"), alpha = 0.5))))
# 使用queries参数查询数据
head(movies)
# 使用内置的相交查询intersects来查找或显示特定相交处的元素。
upset(movies, 
      queries = list(list(query = intersects, params = list("Drama", "Comedy", "Action"), color = "orange", active = T), 
                     list(query = intersects, params = list("Drama"), color = "red", active = F), 
                     list(query = intersects, params = list("Action", "Drama"), active = T)))

# 使用内置的元素查询elements来可视化某些元素在相交之间的分布方式
upset(movies, 
      queries = list(list(query = elements, params = list("AvgRating", 3.5, 4.1), color = "blue", active = T), 
                     list(query = elements, params = list("ReleaseDate", 1980, 1990, 2000), color = "red", active = F)))

# 添加查询图例
upset(movies, 
      query.legend = "top", 
      queries = list(list(query = intersects, params = list("Drama", "Comedy", "Action"), color = "orange", active = T, query.name = "Funny action"), 
                     list(query = intersects, params = list("Drama"), color = "red", active = F), 
                     list(query = intersects, params = list("Action", "Drama"), active = T, query.name = "Emotional action")))

# 使用attribute.plots参数添加属性图
head(movies)
# 添加内置属性直方图
upset(movies, 
      main.bar.color = "black", 
      queries = list(list(query = intersects, params = list("Drama"), active = T)), 
      attribute.plots = list(gridrows = 50, 
                             plots = list(list(plot = histogram, x = "ReleaseDate", queries = F), 
                                          list(plot = histogram, x = "AvgRating", queries = T)), ncols = 2))

# 添加内置属性散点图
upset(movies, 
      main.bar.color = "black", 
      queries = list(list(query = intersects, params = list("Drama"), color = "red", active = F),
                     list(query = intersects, params = list("Action", "Drama"), active = T), 
                     list(query = intersects, params = list("Drama", "Comedy", "Action"), color = "orange", active = T)), 
      attribute.plots = list(gridrows = 45, 
                             plots = list(list(plot = scatter_plot, x = "ReleaseDate", y = "AvgRating", queries = T), 
                                          list(plot = scatter_plot, x = "AvgRating", y = "Watches", queries = F)), ncols = 2), query.legend = "bottom")

# 添加属性箱线图
upset(movies, boxplot.summary = c("AvgRating", "ReleaseDate"))

# 一次性添加元数据，查询和属性图
upset(movies, 
      set.metadata = list(data = metadata, 
                          plots = list(list(type = "hist", column = "avgRottenTomatoesScore", assign = 20),
                                       list(type = "text", column = "Cities", assign = 5, colors = c(Boston = "green", NYC = "navy", LA = "purple")), 
                                       list(type = "matrix_rows", column = "Cities", colors = c(Boston = "green", NYC = "navy", LA = "purple"), alpha = 0.5))), 
      queries = list(list(query = intersects, params = list("Drama"), color = "red", active = F), 
                     list(query = intersects, params = list("Action", "Drama"), active = T), 
                     list(query = intersects, params = list("Drama", "Comedy", "Action"), color = "orange", active = T)), 
      attribute.plots = list(gridrows = 45, 
                             plots = list(list(plot = scatter_plot, x = "ReleaseDate", y = "AvgRating", queries = T), 
                                          list(plot = scatter_plot, x = "AvgRating", y = "Watches", queries = F)), ncols = 2), query.legend = "bottom")
