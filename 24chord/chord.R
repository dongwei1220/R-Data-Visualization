# 24. 和弦图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/24chord/")

# 使用circlize包绘制和弦图
# 安装并加载所需的R包
# install.packages("circlize")
library(circlize)

# 构建示例数据
set.seed(999)
# 构造邻接矩阵
mat = matrix(sample(18, 18), 3, 6)
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)
head(mat)

# 构建邻接列表数据框
df = data.frame(from = rep(rownames(mat), times = ncol(mat)), #起始对象
                to = rep(colnames(mat), each = nrow(mat)), #终止对象
                value = as.vector(mat),#起始对象与终止对象之间的相互作用强度
                stringsAsFactors = FALSE)
head(df)

# 使用chordDiagram函数绘制和弦图
# 使用邻接矩阵绘图
chordDiagram(mat)
# 结束绘图，返回默认设置，否则会继续叠加图层
circos.clear() 

# 使用邻接列表数据框绘图
chordDiagram(df)
circos.clear()

# 使用order参数调整外围sectors的排列顺序
chordDiagram(mat, 
             order = c("S2", "S1", "E4", "E1", "S3", 
                       "E5", "E2", "E6", "E3"))
circos.clear()

# 使用grid.col参数调整外围sectors的填充颜色
grid_col = c(S1 = "red", S2 = "green", S3 = "blue",
             E1 = "yellow", E2 = "pink", E3 = "orange", 
             E4 = "purple", E5 = "black", E6 = "grey")
# transparency参数调整透明度
chordDiagram(mat, 
             grid.col = grid_col,
             transparency = 0.7)
circos.clear()

# 使用col参数调整links的填充颜色
col_mat = rand_color(length(mat), transparency = 0.5)
head(col_mat)

chordDiagram(mat, 
             col = col_mat)
circos.clear()

# 使用link.border，link.lty和link.lwd参数设置links的边框颜色，线型和线宽
chordDiagram(mat, 
             link.border = "red",
             link.lty = 2,
             link.lwd = 2)
circos.clear()

# 使用annotationTrack参数指定外围sectors的类型，可从c("name", "grid", "axis")中指定任意值，也可以指定多个值
chordDiagram(mat, grid.col = grid_col, 
             annotationTrack = "grid" # 指定类型为“gird”只显示网格，不显示刻度线和标签轨道
             ) 

chordDiagram(mat, grid.col = grid_col, 
             annotationTrack = c("name", "grid"), # 指定显示标签和网格轨道
             annotationTrackHeight = c(0.04, 0.02) # 指定标签和网格轨道的高度
             )  

chordDiagram(mat, grid.col = grid_col, 
             annotationTrack = NULL) # 去除所有轨道
circos.clear()

# 使用circos.par函数设置参数
circos.par(clock.wise = FALSE, #逆时针旋转
           start.degree = 60 #起始位置设置为逆时针60度方向
           )
chordDiagram(mat)
circos.clear()

#设置不同sector之间gap的间隔大小
circos.par(gap.after = c("S1" = 5, "S2" = 8, "S3" = 15, 
                         "E1" = 5, "E2" = 10,"E3" = 5, 
                         "E4" = 3, "E5" = 5, "E6" = 15))
chordDiagram(mat)
circos.clear()

sessionInfo()



