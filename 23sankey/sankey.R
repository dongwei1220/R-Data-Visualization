# 23. 桑基图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/23sankey/")

# 使用riverplot包绘制桑基图
# 安装并加载所需的R包
#install.packages("riverplot")
library(riverplot)

# 构建测序数据集
nodes <- c( LETTERS[1:5] )
nodes

edges <- list( A = list( C= 6 ), 
               B = list( C= 5 ),
               C = list( D= 4 ),
               E = list( C= 3 )
               )
edges

# 使用makeRiver函数构造riverplot对象
r <- makeRiver( nodes, edges, 
                node_xpos= c( 1,1,2,3,3 ),
                node_labels= c( A= "Node A", B= "Node B", C= "Node C", D= "Node D", E= "Node E" ),
                node_styles= list( A= list( col= "yellow" ), D= list( col= "blue" ), E= list( col= "red" )))
r

# 使用riverplot函数绘制桑基图
riverplot(r)

# 绘制一个DNA双螺旋
# a DNA strand
plot.new()
par( usr= c( 0, 4, -2.5, 2.5 ) )

w <- 0.4
cols <- c( "blue", "green" )
init <- c( -0.8, -0.5 )
pos  <- c( 1, -1 )
step <- 0.5

# Draw a curved segment
for( i in rep( rep( c( 1, 2 ), each= 2 ), 5 ) ) {
  curveseg( init[i], init[i] + step, pos[1], pos[2], width= w, col= cols[i] )
  init[i] <- init[i] + step
  pos <- pos * -1
}

# 使用ggforce包绘制桑基图
# 安装并加载所需的R包
#install.packages("ggforce")
library(ggforce)

# 构建示例数据
data <- reshape2::melt(Titanic)
head(data)
data <- gather_set_data(data, 1:4)
head(data)

# 使用geom_parallel_setsh函数绘制桑基图
ggplot(data, aes(x, id = id, split = y, value = value)) +
  geom_parallel_sets(aes(fill = Sex), alpha = 0.5, axis.width = 0.1) +
  geom_parallel_sets_axes(axis.width = 0.2,fill="black",color="red") +
  geom_parallel_sets_labels(colour = 'white',angle = 45) +
  theme_bw()

# 使用ggalluvial包绘制桑基图
# 安装并加载所需的R包
#install.packages("ggalluvial")
library(ggalluvial)

# 使用geom_alluvium函数绘制桑基图
admissions <- as.data.frame(UCBAdmissions)
head(admissions)

ggplot(admissions,
       aes(y = Freq, axis1 = Gender, axis2 = Dept)) +
  geom_alluvium(aes(fill = Admit), width = 1/12) +
  geom_stratum(width = 1/12, fill = "black", color = "grey") +
  geom_label(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("Gender", "Dept"), expand = c(.05, .05)) +
  scale_fill_brewer(type = "qual", palette = "Set1") +
  ggtitle("UC Berkeley admissions and rejections, by sex and department")


data <- as.data.frame(Titanic)
head(data)

ggplot(data,
       aes(y = Freq,
           axis1 = Survived, axis2 = Sex, axis3 = Class)) +
  geom_alluvium(aes(fill = Class),width = 0, 
                knot.pos = 0, reverse = FALSE) +
  guides(fill = FALSE) +
  geom_stratum(width = 1/8, reverse = FALSE) +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)),reverse = FALSE) +
  scale_x_continuous(breaks = 1:3, labels = c("Survived", "Sex", "Class")) +
  coord_flip() +
  ggtitle("Titanic survival by class and sex")

data(vaccinations)
levels(vaccinations$response) <- rev(levels(vaccinations$response))
head(vaccinations)

ggplot(vaccinations,
       aes(x = survey, stratum = response, alluvium = subject,
           y = freq,
           fill = response, label = response)) +
  scale_x_discrete(expand = c(.1, .1)) +
  geom_flow() +
  geom_stratum(alpha = .5) +
  geom_text(stat = "stratum", size = 4) +
  theme(legend.position = "none") +
  ggtitle("vaccination survey responses at three points in time")

sessionInfo()
