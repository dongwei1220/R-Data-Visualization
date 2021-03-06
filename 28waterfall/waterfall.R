# 28. 瀑布图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/28waterfall/")

## 使用waterfalls包绘制瀑布图
# 安装并加载所需的R包
#install.packages("waterfalls")
library(waterfalls)

# 构建示例数据
data <- data.frame(category = letters[1:5],
                   value = c(100, -20, 10, 20, 110))
head(data)

# 使用waterfall函数绘制瀑布图
waterfall(.data = data, 
          fill_colours = colorRampPalette(c("#1b7cd6", "#d5e6f2"))(5),
          fill_by_sign = FALSE)

## 使用maftools包绘制瀑布图
# 安装并加载所需的R包
#BiocManager::install("maftools")
library(maftools)

# 查看示例数据
#path to TCGA LAML MAF file
# maf格式的基因突变信息
laml.maf = system.file('extdata', 'tcga_laml.maf.gz', package = 'maftools') 
#clinical information containing survival information and histology. This is optional
# 临床表型注释信息
laml.clin = system.file('extdata', 'tcga_laml_annot.tsv', package = 'maftools') 

# 使用read.maf函数读取数据
laml = read.maf(maf = laml.maf, clinicalData = laml.clin)
#Typing laml shows basic summary of MAF file.
# 查看maf对象
laml

#Shows sample summry
# 获取maf对象汇总信息
getSampleSummary(laml)
#Shows all fields in MAF
getFields(laml)

# 使用plotmafSummary函数可视化maf对象汇总信息
plotmafSummary(maf = laml, 
               rmOutlier = TRUE, 
               addStat = 'median', 
               dashboard = TRUE, 
               titvRaw = FALSE)

# 使用oncoplot函数绘制基因突变瀑布图
#oncoplot for top ten mutated genes.
# 展示top10变异基因的信息
oncoplot(maf = laml, top = 10)

# 自定义变异类型的颜色
library(RColorBrewer)
vc_cols <- brewer.pal(8,"Set1")
names(vc_cols) <- levels(laml@data$Variant_Classification)
head(vc_cols)
oncoplot(maf = laml, top = 20,colors = vc_cols)

# 添加临床注释信息，按注释类型进行排序
names(laml@clinical.data)
oncoplot(maf = laml, top = 20,
         clinicalFeatures = "FAB_classification",
         sortByAnnotation = T)
# 展示多个临床注释信息
oncoplot(maf = laml, top = 20,
         clinicalFeatures = c("FAB_classification","Overall_Survival_Status"),
         sortByAnnotation = T)

## 使用GenVisR包绘制瀑布图
# 安装并加载所需的R包
#BiocManager::install("GenVisR")
library(GenVisR)

# 查看内置示例数据
head(brcaMAF)
names(brcaMAF)

# 使用waterfall函数绘制瀑布图
# Plot only genes with mutations in 6% or more of samples
# 只展示至少在6%的样本中变异的基因
waterfall(brcaMAF, fileType="MAF", mainRecurCutoff = 0.06)

# Plot only the specified genes
# 展示特定基因的变异信息
# Define specific genes to plot
genes_to_plot <- c("PIK3CA", "TP53", "USH2A", "MLL3", "BRCA1", "CDKN1B")
waterfall(brcaMAF, plotGenes = genes_to_plot)

# Create clinical data
# 添加临床表型信息
subtype <- c("lumA", "lumB", "her2", "basal", "normal")
subtype <- sample(subtype, 50, replace = TRUE)
age <- c("20-30", "31-50", "51-60", "61+")
age <- sample(age, 50, replace = TRUE)
sample <- as.character(unique(brcaMAF$Tumor_Sample_Barcode))
clinical <- as.data.frame(cbind(sample, subtype, age))

# Melt the clinical data into 'long' format.
library(reshape2)
clinical <- melt(clinical, id.vars = c("sample"))
head(clinical)

# Run waterfall
waterfall(brcaMAF, clinDat = clinical, 
          clinVarCol = c(lumA = "blue4", lumB = "deepskyblue", 
                         her2 = "hotpink2", basal = "firebrick2", 
                         normal = "green4", 
                         `20-30` = "#ddd1e7", `31-50` = "#bba3d0", 
                         `51-60` = "#9975b9", `61+` = "#7647a2"), 
          plotGenes = c("PIK3CA", "TP53", "USH2A", "MLL3", "BRCA1"), 
          clinLegCol = 2, 
          clinVarOrder = c("lumA", "lumB", "her2", "basal", "normal", "20-30", "31-50", "51-60", "61+"))

sessionInfo()