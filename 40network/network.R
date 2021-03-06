# 40. 网络图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/40network/")

# 使用igraph包绘制网络图
# 安装并加载所需的R包
#install.packages("igraph")
library(igraph)

# 使用邻接矩阵数据绘制网络图
# 构建示例数据
set.seed(10)
data <- matrix(sample(0:2, 25, replace=TRUE), nrow=5)
colnames(data) = rownames(data) = LETTERS[1:5]
# 查看示例数据
head(data)

# build the graph object
# 使用graph_from_adjacency_matrix()函数构建网络图对象
network <- graph_from_adjacency_matrix(data)
# 查看对象
network

# plot it
# 绘制基础网络图，默认得到无权重有方向的网路图
plot(network)

# 使用关联矩阵数据绘制网络图
# 构建示例数据
set.seed(1)
data <- matrix(sample(0:2, 15, replace=TRUE), nrow=3)
colnames(data) <- letters[1:5]
rownames(data) <- LETTERS[1:3]
# 查看示例数据
head(data)

# create the network object
# 使用graph_from_incidence_matrix()函数构建网络图对像
network <- graph_from_incidence_matrix(data,directed = T)
network

# plot it
plot(network)

# 使用边列表数据绘制网络图
# 构建示例数据
links <- data.frame(
  source=c("A","A", "A", "A", "A","F", "B"),
  target=c("B","B", "C", "D", "F","A","E")
)
links

# create the network object
# 使用graph_from_data_frame()函数构建网络图对像
network <- graph_from_data_frame(d=links, directed=F) 
network

# plot it
plot(network)

# 自定义一些参数美化网络图
# Create data
set.seed(1)
data <- matrix(sample(0:1, 100, replace=TRUE, prob=c(0.8,0.2)), nc=10)
head(data)

# 构建网络图对象，设置mode='undirected'参数构建无方向的网络图
network <- graph_from_adjacency_matrix(data, mode='undirected', diag=T)
network

# Default network
plot(network)

# 使用vertex.参数设置节点的大小，形状和颜色等
plot(network,
     vertex.color = rgb(0.8,0.2,0.2,0.9), # Node color
     vertex.frame.color = "Forestgreen",  # Node border color
     vertex.shape=c("circle","square"),   # One of “none”, “circle”, “square”, “csquare”, “rectangle” “crectangle”, “vrectangle”, “pie”, “raster”, or “sphere”
     vertex.size=c(15:24),                # Size of the node (default is 15)
     vertex.size2=NA,                     # The second size of the node (e.g. for a rectangle)
)

# 使用vertex.label.参数添加标签，并设置标签字体，颜色和大小等
plot(network,
     vertex.label=LETTERS[1:10],        # Character vector used to label the nodes
     vertex.label.color=c("red","blue"),
     vertex.label.family="Times",       # Font family of the label (e.g.“Times”, “Helvetica”)
     vertex.label.font=c(1,2,3,4),      # Font: 1 plain, 2 bold, 3, italic, 4 bold italic, 5 symbol
     vertex.label.cex=c(0.5,1,1.5),     # Font size (multiplication factor, device-dependent)
     vertex.label.dist=0,               # Distance between the label and the vertex
     vertex.label.degree=0 ,            # The position of the label in relation to the vertex (use pi)
)

# 使用edge.参数设置边的大小，颜色和箭头等
plot(network,
     edge.color=rep(c("red","pink"),5), # Edge color
     edge.width=seq(1,10),              # Edge width, defaults to 1
     edge.arrow.size=1,                 # Arrow size, defaults to 1
     edge.arrow.width=1,                # Arrow width, defaults to 1
     edge.lty=c("solid")                # Line type, could be 0 or “blank”, 1 or “solid”, 2 or “dashed”, 3 or “dotted”, 4 or “dotdash”, 5 or “longdash”, 6 or “twodash”
     #edge.curved=c(rep(0,5), rep(1,5)) # Edge curvature, range 0-1 (FALSE sets it to 0, TRUE to 0.5)
)

# 使用layout参数设置网络图的展示类型
# Create data
data <- matrix(sample(0:1, 400, replace=TRUE, prob=c(0.8,0.2)), nrow=20)
head(data)
# 构建网络图对象
network <- graph_from_adjacency_matrix(data , mode='undirected', diag=F )
network
# 绘制不同展示类型的网络图
plot(network, layout=layout.sphere, main="sphere")
plot(network, layout=layout.circle, main="circle")
plot(network, layout=layout.random, main="random")
plot(network, layout=layout.fruchterman.reingold, main="fruchterman.reingold")

# 添加节点的属性特征
# create data:
links <- data.frame(
  source=c("A","A", "A", "A", "A","J", "B", "B", "C", "C", "D","I"),
  target=c("B","B", "C", "D", "J","A","E", "F", "G", "H", "I","I"),
  importance=(sample(1:4, 12, replace=T))
)
# 构建节点属性表
nodes <- data.frame(
  name=LETTERS[1:10],
  carac=c( rep("young",3),rep("adult",2), rep("old",5))
)
# 查看数据
head(links)
head(nodes)

# Turn it into igraph object
# 构建网络图对象，vertices参数指定节点属性
network <- graph_from_data_frame(d=links, vertices=nodes, directed=F) 
# 查看网络图对象
network

# 自定义颜色
# Make a palette of 3 colors
library(RColorBrewer)
coul  <- brewer.pal(3, "Set1") 
# Create a vector of color
my_color <- coul[as.numeric(as.factor(V(network)$carac))]
my_color

# 绘值带节点属性的网络图
plot(network, vertex.color=my_color)
# 添加图例
legend("bottomleft", legend=levels(as.factor(V(network)$carac)), 
       col = coul , bty = "n", pch=20 , pt.cex = 3, 
       cex = 1.5, text.col=coul , horiz = FALSE, 
       inset = c(0.1, 0.1))

# 添加边的属性特征
plot(network, vertex.color=my_color, 
     edge.width=E(network)$importance*2 )
# 添加图例
legend("bottomleft", legend=levels(as.factor(V(network)$carac)), 
       col = coul , bty = "n", pch=20 , pt.cex = 3, 
       cex = 1.5, text.col=coul , horiz = FALSE, 
       inset = c(0.1, 0.1))

# 使用ggraph包绘制网络图
library(ggraph)
library(igraph)
library(tidyverse)

# 构建示例数据
# create a data frame giving the hierarchical structure of your individuals
set.seed(1234)
d1 <- data.frame(from="origin", to=paste("group", seq(1,10), sep=""))
d2 <- data.frame(from=rep(d1$to, each=10), to=paste("subgroup", seq(1,100), sep="_"))
hierarchy <- rbind(d1, d2)

# create a dataframe with connection between leaves (individuals)
all_leaves <- paste("subgroup", seq(1,100), sep="_")
connect <- rbind( 
  data.frame( from=sample(all_leaves, 100, replace=T) , to=sample(all_leaves, 100, replace=T)), 
  data.frame( from=sample(head(all_leaves), 30, replace=T) , to=sample( tail(all_leaves), 30, replace=T)), 
  data.frame( from=sample(all_leaves[25:30], 30, replace=T) , to=sample( all_leaves[55:60], 30, replace=T)), 
  data.frame( from=sample(all_leaves[75:80], 30, replace=T) , to=sample( all_leaves[55:60], 30, replace=T)) )
connect$value <- runif(nrow(connect))

# create a vertices data.frame. One line per object of our hierarchy
vertices  <-  data.frame(
  name = unique(c(as.character(hierarchy$from), as.character(hierarchy$to))) , 
  value = runif(111)
) 
# Let's add a column with the group of each name. It will be useful later to color points
vertices$group  <-  hierarchy$from[ match( vertices$name, hierarchy$to ) ]

# 查看示例数据
head(hierarchy)
head(connect)
head(vertices)

# Create a graph object
# 构建网络图对象，vertices参数指定节点属性
mygraph <- graph_from_data_frame( hierarchy, vertices=vertices )
mygraph

# The connection object must refer to the ids of the leaves:
from  <-  match( connect$from, vertices$name)
to  <-  match( connect$to, vertices$name)

# Basic graph
# 绘制基础网络图
ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
  # 添加边连接线
  geom_conn_bundle(data = get_con(from = from, to = to), 
                   alpha=0.6, colour="skyblue", tension = .7) + 
  # 设置节点
  geom_node_point(aes(filter = leaf, x = x*1.05, y=y*1.05)) +
  theme_void()

# 更改边连接线的颜色
p <- ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
  geom_node_point(aes(filter = leaf, x = x*1.05, y=y*1.05)) +
  theme_void()
# Use the 'value' column of the connection data frame for the color:
p +  geom_conn_bundle(data = get_con(from = from, to = to), 
                      aes(colour=value, alpha=value)) 

# In this case you can change the color palette
p +  
  geom_conn_bundle(data = get_con(from = from, to = to), 
                   aes(colour=value)) +
  scale_edge_color_continuous(low="white", high="red")

p +  
  geom_conn_bundle(data = get_con(from = from, to = to), 
                   aes(colour=value)) +
  scale_edge_colour_distiller(palette = "BuPu")

# Color depends of the index: the from and the to are different
p +  
  geom_conn_bundle(data = get_con(from = from, to = to), 
                   width=1, alpha=0.2, aes(colour=..index..)) +
  scale_edge_colour_distiller(palette = "RdPu") +
  theme(legend.position = "none")

# 更改节点的颜色，大小等信息
# Basic usual argument
p <- ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
  geom_conn_bundle(data = get_con(from = from, to = to), 
                   width=1, alpha=0.2, aes(colour=..index..)) +
  scale_edge_colour_distiller(palette = "RdPu") +
  theme_void() +
  theme(legend.position = "none")
p

# just a blue uniform color. Note that the x*1.05 allows to make a space between the points and the connection ends
p + geom_node_point(aes(filter = leaf, x = x*1.05, y=y*1.05), 
                    colour="skyblue", alpha=0.3, size=3)

# It is good to color the points following their group appartenance
library(RColorBrewer)
p + geom_node_point(aes(filter = leaf, x = x*1.05, y=y*1.05, 
                        colour=group),   size=3) +
  scale_colour_manual(values= rep( brewer.pal(9,"Paired"), 30))

# And you can adjust the size to whatever variable quite easily!
p + 
  geom_node_point(aes(filter = leaf, x = x*1.05, y=y*1.05, 
                      colour=group, size=value, alpha=0.2)) +
  scale_colour_manual(values= rep( brewer.pal(9,"Paired"), 30)) +
  scale_size_continuous( range = c(0.1,10) ) 

# 使用networkD3包绘制动态网络图
# 安装并加载所需的R包
#install.packages("networkD3")
library(networkD3)

# 使用simpleNetwork()函数绘制简单交互网络图
# 构建示例数据
Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
NetworkData <- data.frame(Source, Target)
NetworkData

# Create graph
simpleNetwork(NetworkData)

# 使用forceNetwork()函数绘制交互网络图
# Load data
data(MisLinks)
data(MisNodes)
# 查看内置数据集
head(MisLinks)
head(MisNodes)

# Create graph
forceNetwork(Links = MisLinks, Nodes = MisNodes, 
             Source = "source", Target = "target", Value = "value", 
             NodeID = "name", Group = "group", 
             opacity = 0.4, zoom = TRUE)

# Create graph with legend and varying node radius
forceNetwork(Links = MisLinks, Nodes = MisNodes, 
             Source = "source", Target = "target", Value = "value", 
             NodeID = "name", Nodesize = "size", Group = "group",
             radiusCalculation = "Math.sqrt(d.nodesize)+6",
             opacity = 0.4, legend = TRUE)

# Create graph directed arrows
forceNetwork(Links = MisLinks, Nodes = MisNodes, 
             Source = "source", Target = "target", Value = "value", 
             NodeID = "name", Group = "group", 
             opacity = 0.4, arrows = TRUE)

# 使用chordNetwork()函数绘制和弦交互式网络图
# 构建示例数据
hairColourData <- matrix(c(11975,  1951,  8010, 1013,
                           5871, 10048, 16145,  990,
                           8916,  2060,  8090,  940,
                           2868,  6171,  8045, 6907),
                         nrow = 4)
head(hairColourData)

# Create graph
chordNetwork(Data = hairColourData, 
             width = 500, 
             height = 500,
             colourScale = c("#000000", "#FFDD89", "#957244", "#F26223"),
             labels = c("red", "brown", "blond", "gray"))

# 使用dendroNetwork()函数绘制层次聚类交互式网络图
# 使用hclust()函数进行层次聚类
hc <- hclust(dist(USArrests), "ave")
hc

# Create graph
dendroNetwork(hc, height = 800)
# 设置标签颜色
dendroNetwork(hc, textColour = c("red", "green", "orange")[cutree(hc, 3)],
              height = 800)

# 使用radialNetwork()函数绘制放射状交互式网络图
# 构建示例数据
CanadaPC <- list(name = "Canada", children = list(list(name = "Newfoundland",
                                                       children = list(list(name = "St. John's"))),
                                                  list(name = "PEI",
                                                       children = list(list(name = "Charlottetown"))),
                                                  list(name = "Nova Scotia",
                                                       children = list(list(name = "Halifax"))),
                                                  list(name = "New Brunswick",
                                                       children = list(list(name = "Fredericton"))),
                                                  list(name = "Quebec",
                                                       children = list(list(name = "Montreal"),
                                                                       list(name = "Quebec City"))),
                                                  list(name = "Ontario",
                                                       children = list(list(name = "Toronto"),
                                                                       list(name = "Ottawa"))),
                                                  list(name = "Manitoba",
                                                       children = list(list(name = "Winnipeg"))),
                                                  list(name = "Saskatchewan",
                                                       children = list(list(name = "Regina"))),
                                                  list(name = "Nunavuet",
                                                       children = list(list(name = "Iqaluit"))),
                                                  list(name = "NWT",
                                                       children = list(list(name = "Yellowknife"))),
                                                  list(name = "Alberta",
                                                       children = list(list(name = "Edmonton"))),
                                                  list(name = "British Columbia",
                                                       children = list(list(name = "Victoria"),
                                                                       list(name = "Vancouver"))),
                                                  list(name = "Yukon",
                                                       children = list(list(name = "Whitehorse")))
))
CanadaPC

# Create graph
radialNetwork(List = CanadaPC, fontSize = 10)

sessionInfo()


