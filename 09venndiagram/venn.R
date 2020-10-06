# 09.韦恩图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/09venndiagram/")

# gplots包绘制韦恩图
library(gplots)
data <- read.table("demo1_venn.txt", header = T, sep = "\t")
head(data)
attach(data)

# 绘制二维韦恩图
venn(data = list(Set1,Set2))

# 绘制三维韦恩图
venn(data = list(Set1,Set2,Set3))

# 绘制四维韦恩图
venn(data = list(Set1,Set2,Set3,Set4))

# 绘制五维韦恩图
venn(data = list(Set1,Set2,Set3,Set4,Set5))

# VennDiagram包绘制韦恩图
library(VennDiagram)

# 使用draw.single.venn函数绘制一维韦恩图
venn.plot <- draw.single.venn(
  area = 365,
  category = "All\nDays",
  lwd = 5,
  lty = "blank",
  cex = 3,
  label.col = "orange",
  cat.cex = 4,
  cat.pos = 180,
  cat.dist = -0.20,
  cat.col = "white",
  fill = "red",
  alpha = 0.15
);
grid.newpage();

# 使用draw.pairwise.vennh函数绘制二维韦恩图
venn.plot <- draw.pairwise.venn(
  area1 = 100,
  area2 = 70,
  cross.area = 68,
  category = c("First", "Second"),
  fill = c("blue", "red"),
  lty = "blank",
  cex = 2,
  cat.cex = 2,
  cat.pos = c(285, 105),
  cat.dist = 0.09,
  cat.just = list(c(-1, -1), c(1, 1)),
  ext.pos = 30,
  ext.dist = -0.05,
  ext.length = 0.85,
  ext.line.lwd = 2,
  ext.line.lty = "dashed"
);
grid.newpage();

# 使用draw.triple.vennh函数绘制三维韦恩图
venn.plot <- draw.triple.venn(
  area1 = 65,
  area2 = 75,
  area3 = 85,
  n12 = 35,
  n23 = 15,
  n13 = 25,
  n123 = 5,
  category = c("First", "Second", "Third"),
  fill = c("blue", "red", "green"),
  lty = "blank",
  cex = 2,
  cat.cex = 2,
  cat.col = c("blue", "red", "green")
);
grid.newpage();

# 使用draw.quad.venn函数绘制四维韦恩图
# Reference four-set diagram
venn.plot <- draw.quad.venn(
  area1 = 72,
  area2 = 86,
  area3 = 50,
  area4 = 52,
  n12 = 44,
  n13 = 27,
  n14 = 32,
  n23 = 38,
  n24 = 32,
  n34 = 20,
  n123 = 18,
  n124 = 17,
  n134 = 11,
  n234 = 13,
  n1234 = 6,
  category = c("First", "Second", "Third", "Fourth"),
  fill = c("orange", "red", "green", "blue"),
  lty = "dashed",
  cex = 2,
  cat.cex = 2,
  cat.col = c("orange", "red", "green", "blue")
);
grid.newpage();

# 使用draw.quintuple.venn函数绘制五维韦恩图
# Reference five-set diagram
venn.plot <- draw.quintuple.venn(
  area1 = 301,
  area2 = 321,
  area3 = 311,
  area4 = 321,
  area5 = 301,
  n12 = 188,
  n13 = 191,
  n14 = 184,
  n15 = 177,
  n23 = 194,
  n24 = 197,
  n25 = 190,
  n34 = 190,
  n35 = 173,
  n45 = 186,
  n123 = 112,
  n124 = 108,
  n125 = 108,
  n134 = 111,
  n135 = 104,
  n145 = 104,
  n234 = 111,
  n235 = 107,
  n245 = 110,
  n345 = 100,
  n1234 = 61,
  n1235 = 60,
  n1245 = 59,
  n1345 = 58,
  n2345 = 57,
  n12345 = 31,
  category = c("A", "B", "C", "D", "E"),
  fill = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
  cat.col = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
  cat.cex = 2,
  margin = 0.05,
  cex = c(1.5, 1.5, 1.5, 1.5, 1.5, 1, 0.8, 1, 0.8, 1, 0.8, 1, 0.8, 1, 0.8, 
          1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 1, 1, 1, 1, 1.5),
  ind = TRUE
);
grid.newpage();

# Writing to file
tiff(filename = "Quintuple_Venn_diagram.tiff", compression = "lzw");
grid.draw(venn.plot);
dev.off();

# 使用venn.diagram函数绘制韦恩图
data <- read.table("demo1_venn.txt", header = T, sep = "\t")
head(data)
attach(data)

# 一维韦恩图
venn.plot <- venn.diagram(
  x = list(Set1=Set1),
  filename = NULL,
  col = "black",
  lwd = 9,
  fontface = "bold",
  fill = "grey",
  alpha = 0.75,
  cex = 4,
  cat.cex = 3,
  cat.fontface = "bold",
);
grid.draw(venn.plot);
grid.newpage();

# 二维韦恩图
venn.plot <- venn.diagram(
  x = list(Set1=Set1,Set2=Set2),
  filename = NULL,
  lwd = 4,
  fill = c("cornflowerblue", "darkorchid1"),
  alpha = 0.75,
  label.col = "white",
  cex = 4,
  fontfamily = "serif",
  fontface = "bold",
  cat.col = c("cornflowerblue", "darkorchid1"),
  cat.cex = 3,
  cat.fontfamily = "serif",
  cat.fontface = "bold",
  cat.dist = c(0.03, 0.03),
  cat.pos = c(-20, 14)
);
grid.draw(venn.plot);
grid.newpage();

# 三维韦恩图
venn.plot <- venn.diagram(
  x = list(Set1=Set1,Set2=Set2,Set3=Set3),
  filename = NULL,
  col = "transparent",
  fill = c("red", "blue", "green"),
  alpha = 0.5,
  label.col = c("darkred", "white", "darkblue", "white",
                "white", "white", "darkgreen"),
  cex = 2.5,
  fontfamily = "serif",
  fontface = "bold",
  cat.default.pos = "text",
  cat.col = c("darkred", "darkblue", "darkgreen"),
  cat.cex = 2.5,
  cat.fontfamily = "serif",
  cat.dist = c(0.06, 0.06, 0.03),
  cat.pos = 0
);
grid.draw(venn.plot);
grid.newpage();

# 四维韦恩图
venn.plot <- venn.diagram(
  x = list(Set1=Set1,Set2=Set2,Set3=Set3,Set4=Set4),
  filename = NULL,
  col = "black",
  lty = "dotted",
  lwd = 4,
  fill = c("cornflowerblue", "green", "yellow", "darkorchid1"),
  alpha = 0.50,
  label.col = c("orange", "white", "darkorchid4", "white", "white", "white",
                "white", "white", "darkblue", "white",
                "white", "white", "white", "darkgreen", "white"),
  cex = 2.5,
  fontfamily = "serif",
  fontface = "bold",
  cat.col = c("darkblue", "darkgreen", "orange", "darkorchid4"),
  cat.cex = 2.5,
  cat.fontfamily = "serif"
);
grid.draw(venn.plot);
grid.newpage();

# 五维韦恩图
venn.plot <- venn.diagram(
  x = list(Set1=Set1,Set2=Set2,Set3=Set3,Set4=Set4,Set5=Set5),
  filename = NULL,
  col = "black",
  fill = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
  alpha = 0.50,
  cex = c(1.5, 1.5, 1.5, 1.5, 1.5, 1, 0.8, 1, 0.8, 1, 0.8, 1, 0.8,
          1, 0.8, 1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 1, 1, 1, 1, 1.5),
  cat.col = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
  cat.cex = 1.5,
  cat.fontface = "bold",
  margin = 0.05
);
grid.draw(venn.plot);
grid.newpage();

