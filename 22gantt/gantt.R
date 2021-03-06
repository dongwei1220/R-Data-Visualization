# 22. 甘特图绘制

# 清除当前环境中的变量
rm(list=ls())

# 设置工作目录
setwd("C:/Users/Dell/Desktop/R_Plots/22gantt/")

# 使用plotrixb包绘制甘特图
# 安装并加载所需的R包
#install.packages("plotrix")
library(plotrix)

# 构建测试数据集
Ymd.format<-"%Y/%m/%d"
gantt.info <-list(labels= c("First task","Second task","Third task","Fourth task","Fifth task"),
                  starts= as.POSIXct(strptime(c("2004/01/01","2004/02/02","2004/03/03","2004/05/05","2004/09/09"),format=Ymd.format)),
                  ends= as.POSIXct(strptime(c("2004/03/03","2004/05/05","2004/05/05","2004/08/08","2004/12/12"),format=Ymd.format)),
                  priorities=c(1,2,3,4,5)
                  )
gantt.info

vgridpos <- as.POSIXct(strptime(c("2004/01/01","2004/02/01","2004/03/01","2004/04/01",
                                  "2004/05/01","2004/06/01","2004/07/01","2004/08/01",
                                  "2004/09/01","2004/10/01","2004/11/01","2004/12/01"),
                                format=Ymd.format))
vgridpos

vgridlab <- c("Jan","Feb","Mar","Apr","May","Jun",
              "Jul","Aug","Sep","Oct","Nov","Dec")
vgridlab

# 使用gantt.charth函数绘制甘特图
gantt.chart(gantt.info, # a list of task labels, start/end times and task priorities
            main="Calendar date Gantt chart (2004)", # 设置标题
            priority.legend=TRUE, # 设置是否展示color图例
            vgridpos=vgridpos, # 设置垂直网格线的位置
            vgridlab=vgridlab, # 设置垂直网格线的标签
            hgrid=TRUE # 设置是否显示水平网格线
            )

# add a little extra space on the right side
gantt.chart(gantt.info,
            main="Calendar date Gantt chart (2004)",
            priority.legend=TRUE,
            vgridpos=vgridpos,
            vgridlab=vgridlab,
            hgrid=TRUE,
            taskcolors = rainbow(5),
            priority.label = "Task priorities",
            xlim=as.POSIXct(strptime(c("2004/01/01","2004/12/20"),
                                     format=Ymd.format)))

# if both vgidpos and vgridlab are specified,
# starts and ends don't have to be dates
info2 <- list(labels=c("Jim","Joe","Jim","John","John","Jake","Joe","Jed","Jake"),
              starts=c(8.1,8.7,13.0,9.1,11.6,9.0,13.6,9.3,14.2),
              ends=c(12.5,12.7,16.5,10.3,15.6,11.7,18.1,18.2,19.0))
info2

gantt.chart(info2,vgridlab=8:19,vgridpos=8:19,
            main="All bars the same color",
            taskcolors="lightgray",
            cylindrical = T)

gantt.chart(info2,vgridlab=8:19,vgridpos=8:19,
            main="A color for each label",
            taskcolors=c(2,3,7,4,8),
            priority.legend = T)

gantt.chart(info2,vgridlab=8:19,vgridpos=8:19,
            main="A color for each interval - with borders",
            taskcolors=c(2,3,7,4,8,5,3,6,"purple"),
            border.col="black")

# 使用vistime包绘制甘特图
# 安装并加载所需的R包
#install.packages("vistime")
library(vistime)

# 构建测试数据集
pres <- data.frame(
  Position = rep(c("President", "Vice"), each = 3),
  Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
  start = c("1789-03-29", "1797-02-03", "1801-02-03"),
  end = c("1797-02-03", "1801-02-03", "1809-02-03"),
  color = c("#cbb69d", "#603913", "#c69c6e")
)
pres

# 使用gg_vistime函数绘制甘特图
gg_vistime(pres, 
           col.event = "Position", 
           col.group = "Name", 
           col.start = "start",
           col.end = "end",
           col.color = "color",
           title = "Presidents of the USA")


