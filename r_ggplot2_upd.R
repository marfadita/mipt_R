library(ggplot2)
head(diamonds)
help(diamonds)
dim(diamonds)
View(diamonds)
ggplot(data=diamonds[1:50,], aes(x = carat, y = price))+ geom_point()
# aes == aestetics
ggplot(diamonds[1:50,], aes(x = carat, y = price, color = clarity)) + geom_point()+theme_classic()

ggplot(diamonds[1:50,], aes(x = carat, y = price, color = color)) + geom_point()
ggplot(diamonds[1:50,], aes(x = carat, y = price, color = cut)) + geom_point()
ggplot(diamonds[1:50,], aes(
  x = carat,
  y = price,
  color = clarity,
  size = cut
)) + geom_point()

ggplot(diamonds[1:50,], aes(
  x = carat,
  y = price,
  color = clarity,
  shape = cut
)) + geom_point()
ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + geom_smooth()+geom_vline(aes(xintercept=0.3,color="red"))

ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + geom_smooth(se = FALSE)

ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + geom_smooth(se =FALSE, method = "lm")

ggplot(diamonds[1:50,], aes(x = carat, y = price, color = clarity)) + geom_point() + geom_smooth(se =FALSE)

ggplot(diamonds[1:50,], aes(x = carat, y = price, color = clarity)) + geom_smooth(se = FALSE)

ggplot(diamonds[1:50,], aes(x = carat, y = price, color = cut)) + geom_point() + facet_wrap( ~ clarity)

ggplot(diamonds[1:50,], aes(x = carat, y = price, color = cut)) + geom_point() + facet_grid( ~ clarity)

ggplot(diamonds[1:50,], aes(x = carat, y = price, color = cut)) + geom_point() + facet_grid(color ~ clarity)

ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + ggtitle("My scatter plot")

ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + ggtitle("My scatter plot") + xlab("Weight (carats)")

ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + ggtitle("My scatter plot") + xlab("Weight (carats)") + xlim(0, 2)

ggplot(diamonds[1:50,], aes(x = carat, y = price)) + geom_point() + ggtitle("My scatter plot") + xlab("Weight (carats)") + ylim(0, 10000)

ggplot(diamonds[1:500,], aes(x = price)) + geom_histogram()

ggplot(diamonds, aes(x = price)) + geom_histogram()

ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 2000)

ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 200)

ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 200) + facet_wrap( ~ clarity)
# фиксированный диапозон по осям X и Y

ggplot(diamonds, aes(x = price)) + geom_histogram(binwidth = 200) + facet_wrap( ~ clarity, scale ="free_y")
# диапозон по Y разный

ggplot(diamonds, aes(x = price, fill = clarity)) + geom_histogram()

ggplot(diamonds, aes(x = price, fill = cut)) + geom_histogram()

ggplot(diamonds, aes(x = price)) + geom_density()

ggplot(diamonds, aes(x = price, color = cut)) + geom_density()

ggplot(diamonds, aes(x = color, y = price)) + geom_boxplot()

p <- ggplot(diamonds, aes(x = color, y = price)) + geom_boxplot() + scale_y_log10()+theme(
  axis.title.x = element_text(size = 20),
  axis.title.y = element_text(size = 20),
  axis.text.x = element_text(size = 10),
  axis.text.y = element_text(size = 10)
)
getwd()
p
ggsave("my_ggplot2_file.png",width = 7.5,height=5,units = "cm",dpi = 350)
p <- p+geom_jitter(size=0.001)
print(p)#in loop
