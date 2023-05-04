library(tidyverse)
set.seed
df <- data.frame(value=rnorm(10,mean=20,sd=10),
                 object=letters[1:10])

df
# gg_plot<-
  ggplot() +
  geom_polygon(data=df, aes(x=object, y=value, group=1),color = 'purple', fill=NA,rule="winding")+
  coord_polar(start = -pi/10)+
  annotate("text", x = 1, y = c(-5,0,5,10,15,25), label = c(-5,0,5,10,15,25), hjust = 1,size=3.5)+  #шкала
scale_x_discrete() +
  theme_bw() +
  theme(
    axis.text.x =
      element_text( size = 10, color = alpha("red",0.7),                    angle=345
                    ),
    panel.grid.major = element_line(size = 0.5, linetype = 'solid',colour = "grey")
  )
        
  