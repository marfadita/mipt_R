
#Introduction to ggplot2
# install.packages("mosaicData")
# load data
data(CPS85 , package = "mosaicData")
# specify dataset and mapping
library(ggplot2)
ggplot(data = CPS85,
       mapping = aes(x = exper, y = wage))
# add points
ggplot(data = CPS85,
       mapping = aes(x = exper, y = wage)) +
  geom_point()
### save to variable
p1 <- ggplot(data = CPS85,
       mapping = aes(x = exper, y = wage))
p1+ geom_line()+geom_point()
# delete outlier
library(dplyr)
plotdata <- filter(CPS85, wage < 40)
plotdata <- CPS85[CPS85$wage<40,]

# redraw scatterplot
ggplot(data = plotdata,
       mapping = aes(x = exper, y = wage)) +
  geom_point()
# make points blue, larger, and semi-transparent
ggplot(data = plotdata,
       mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue",
             alpha = .7,
             size = 3)
# add a line of best fit.
ggplot(data = plotdata,
       mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue",
             alpha = .7,
             size = 3) +
  geom_smooth(method = "lm")
# indicate sex using color
ggplot(data = plotdata,
       mapping = aes(x = exper, 
                     y = wage,
                     color = sex)) +
  geom_point(alpha = .7,
             size = 3) +
  geom_smooth(method = "lm", 
              se = FALSE, 
              size = 1.5)
# modify the x and y axes and specify the colors to be used
ggplot(data = plotdata,
       mapping = aes(x = exper, 
                     y = wage,
                     color = sex)) +
  geom_point(alpha = .7,
             size = 3) +
  geom_smooth(method = "lm", 
              se = FALSE, 
              size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue"))
# reproduce plot for each level of job sector
ggplot(data = plotdata,
       mapping = aes(x = exper, 
                     y = wage,
                     color = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", 
              se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue")) +
  facet_wrap(~sector, scales = "free",ncol=5)
# add informative labels
ggplot(data = plotdata,
       mapping = aes(x = exper, 
                     y = wage,
                     color = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", 
              se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender")#+
      #ggtitle("5")
# use a minimalist theme
ggplot(data = plotdata,
       mapping = aes(x = exper, 
                     y = wage,
                     color = sex)) +
  geom_point(alpha = .6) +
  geom_smooth(method = "lm", 
              se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender") +
  theme_minimal()
# placing color mapping in the ggplot function
ggplot(plotdata,
       aes(x = exper, 
           y = wage,
           color = sex)) +
  geom_point(alpha = .7,
             size = 3) +
  geom_smooth(method = "lm",
              formula = y ~ poly(x,2),
              se = FALSE, 
              size = 1.5)

#Graphs as objects
#A ggplot2 graph can be saved as a named R object (like a data frame), manipulated further, and then printed or saved to disk.
# prepare data
data(CPS85 , package = "mosaicData")
plotdata <- CPS85[CPS85$wage < 40,]

# create scatterplot and save it
myplot <- ggplot(data = plotdata,
                 aes(x = exper, y = wage)) +
  geom_point()

# print the graph
myplot

# make the points larger and blue
# then print the graph
myplot <- myplot + geom_point(size = 3, color = "blue")
myplot

# print the graph with a title and line of best fit
# but don't save those changes
myplot + geom_smooth(method = "lm") +
  labs(title = "Mildly interesting graph")

# print the graph with a black and white theme
# but don't save those changes
myplot + theme_bw()


set.seed(5)
user_vector <- rnorm(500,9,15)
ggplot()+geom_histogram(aes(x=user_vector))


View(iris)
df<- as.data.frame(matrix(rnorm(100),ncol=10))
rownames(df)<-paste0("Gene",1:10)
colnames(df)<-paste0("Patients",1:10)

# todo: long table, where 1st column gene names,
# 2nd - numeric values, 3rd - names of patients

df

myplot+
  theme(
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20),
    axis.text.x = element_text(size = 20, angle = 90),
    axis.text.y = element_text(size = 20)
  )

myplot+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 20),
    axis.text.x = element_text(size = 20, angle = 90),
    axis.text.y = element_text(size = 20)
  )
myplot+facet_wrap(~sector)+
  # theme(strip.text = element_text(size = 10))
  # theme(strip.text = element_blank())
theme(strip.background = element_blank())
ggsave("ggplot_test.png", width=5, height=7)

user_vector <- rnorm(500,9,15)


p1 <- myplot+facet_wrap(~sector)
p2 <- myplot
p3 <- ggplot()+geom_histogram(aes(x=user_vector))

library("cowplot")
plot_grid(p1,p2,p3,ncol=3)
pg <- plot_grid(p1,p2,p3,ncol=3)
ggsave("test2.png",dpi=350,height=7.5,width=7.5)













