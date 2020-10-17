# 27. 序列logo图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/27seqlogo/")

# 使用seqLogo包绘制序列logo图
# 安装并加载所需的R包
#BiocManager::install("seqLogo")
library(seqLogo)

# 读取示例位置频率矩阵(PWM)数据
mFile <- system.file("Exfiles/pwm1", package="seqLogo")
m <- read.table(mFile)
m

# 使用makePWM函数转换成PWM矩阵
pwm <- makePWM(m)
pwm

# 使用seqLogo函数绘制序列logo图
seqLogo(pwm)

# 使用ggseqlogo包绘制序列logo图
# 安装并加载所需的R包
#install.packages("ggseqlogo")
library(ggseqlogo)

# 加载并查看示例数据
data(ggseqlogo_sample)
# 查看示例氨基酸序列数据
length(seqs_aa)
head(seqs_aa[[1]])

# 查看示例DNA序列数据
length(seqs_dna)
head(seqs_dna[[1]])

# 查看示例位置频率矩阵数据
length(pfms_dna)
head(pfms_dna[[1]])

# 使用ggseqlogo函数绘制序列logo图
ggseqlogo(seqs_dna[[1]])

# 绘制多个序列logo
ggseqlogo(seqs_dna, facet = "wrap",ncol = 4)

# seq_type参数指定序列类型，默认为“auto”自动设别，可以设置为"aa","dna","rna","other"等
ggseqlogo(seqs_aa, seq_type = "aa")

# method参数指定序列展示的方法，默认为“bits”
ggseqlogo(seqs_dna[1:4], method = "prob")

# col_scheme参数设置配色方案
# 使用list_col_schemes()函数查看内置配色方案
list_col_schemes(v = T)
ggseqlogo(pfms_dna, col_scheme = "clustalx")
ggseqlogo(pfms_dna, col_scheme = "base_pairing")

# 也可以使用make_col_scheme()函数自定义配色方案
# 离散型配色方案 Discrete color scheme examples
cs1 = make_col_scheme(chars=c('A', 'T', 'G', 'C'), groups=c('g1', 'g1', 'g2', 'g2'), 
                      cols=c('red', 'red', 'blue', 'blue'), name='custom1')
cs1

# 连续型配色方案 Quantitative color scheme
cs2 = make_col_scheme(chars=c('A', 'T', 'G', 'C'), values=1:4, 
                      name='custom3')
cs2

ggseqlogo(pfms_dna, col_scheme = cs1)
ggseqlogo(pfms_dna, col_scheme = cs2)

# font参数设置logo字体
# 使用list_fonts()函数查看内置字体
list_fonts(v = T)
ggseqlogo(seqs_dna[5:8],font="helvetica_bold")
ggseqlogo(seqs_dna[5:8],font="roboto_regular")

# stack_width参数设置字母的宽度
ggseqlogo(seqs_dna[5:8],stack_width=0.5)
ggseqlogo(seqs_dna[5:8],stack_width=0.9)


# 使用motifStack包绘制序列logo图
# 安装并加载所需的R包
#BiocManager::install("motifStack")
library(motifStack)

# 读取motif文件
pcm <- read.table(file.path(find.package("motifStack"), 
                            "extdata", "bin_SOLEXA.pcm"))
head(pcm)

# 生成motif矩阵
pcm <- pcm[,3:ncol(pcm)]
rownames(pcm) <- c("A","C","G","T")
head(pcm)
motif <- new("pcm", mat=as.matrix(pcm), name="bin_SOLEXA")
motif

# 生成motif logo图形
plot(motif)
#plot the logo with same height
plot(motif, ic.scale=FALSE, ylab="probability")
#try a different font and a different color group
motif@color <- colorset(colorScheme='basepairing')
plot(motif,font="Times")

# plot an affinity logo
# 绘制双链关联序列logo图
motif<-matrix(
  c(
    .846, .631, .593, .000, .000, .000, .434, .410, 1.00, .655, .284, .000, .000, .771, .640, .961,
    .625, .679, .773, 1.00, 1.00, .000, .573, .238, .397, 1.00, 1.00, .000, .298, 1.00, 1.00, .996,
    1.00, 1.00, 1.00, .228, .000, 1.00, 1.00, .597, .622, .630, .000, 1.00, 1.00, .871, .617, 1.00,
    .701, .513, .658, .000, .000, .247, .542, 1.00, .718, .686, .000, .000, .000, .595, .437, .970
  ), nrow=4, byrow = TRUE)
rownames(motif) <- c("A", "C", "G", "T")
motif<-new("psam", mat=motif, name="affinity logo")
motif
plot(motif)

# plot sequence logo stack
# 导入多个序列矩阵
motifs<-importMatrix(dir(file.path(find.package("motifStack"), "extdata"),"pcm$", full.names = TRUE))
motifs

## plot stacks
# 绘制多序列堆叠logo图
motifStack(motifs, layout="stack", ncex=1.0)

## plot stacks with hierarchical tree
# 添加进化树（layout="tree"）
motifStack(motifs, layout="tree")

## When the number of motifs is too much to be shown in a vertical stack, 
## motifStack can draw them in a radial style.
## random sample from MotifDb
#BiocManager::install("MotifDb")
library("MotifDb")
matrix.fly <- query(MotifDb, "Dmelanogaster")
motifs2 <- as.list(matrix.fly)
## use data from FlyFactorSurvey
motifs2 <- motifs2[grepl("Dmelanogaster\\-FlyFactorSurvey\\-",
                         names(motifs2))]
## format the names
names(motifs2) <- gsub("Dmelanogaster_FlyFactorSurvey_", "",
                       gsub("_FBgn\\d+$", "",
                            gsub("[^a-zA-Z0-9]","_",
                                 gsub("(_\\d+)+$", "", names(motifs2)))))
motifs2 <- motifs2[unique(names(motifs2))]
pfms <- sample(motifs2, 50)
## creat a list of object of pfm 
motifs2 <- lapply(names(pfms), 
                  function(.ele, pfms){new("pfm",mat=pfms[[.ele]], name=.ele)}
                  ,pfms)
## trim the motifs
motifs2 <- lapply(motifs2, trimMotif, t=0.4)
motifs2

## setting colors
library(RColorBrewer)
color <- brewer.pal(12, "Set3")
color
## plot logo stack with radial style
# 设置环形多序列logo图（layout="radialPhylog"）
motifStack(motifs2, layout="radialPhylog", 
           circle=0.3, cleaves = 0.2, 
           clabel.leaves = 0.5, 
           col.bg=rep(color, each=5), col.bg.alpha=0.3, 
           col.leaves=rep(color, each=5),
           col.inner.label.circle=rep(color, each=5), 
           inner.label.circle.width=0.05,
           col.outer.label.circle=rep(color, each=5), 
           outer.label.circle.width=0.02, 
           circle.motif=1.2,
           angle=350)

sessionInfo()