#   Для датасета iris визуализировать:
#   • распределение Sepal.Width в виде гладкой линии и гистограммы (hist, plot-density-polygon)
# • подписать имена оси x, заголовок, подзаголовок, заполнить цветом гистограмму, 
# задать другим цветом границы столбцов гистограммы. 
# Увеличить размер шрифтов для осей в 2 раза(подписи и тики). 
library(ggplot2)

hist_plot <- ggplot(iris, aes(Sepal.Width, fill = Species)) +
  geom_histogram(alpha = .3, binwidth = 0.2, color = 'blue2') +
  geom_density(bw = 0.1, alpha = 0.3, 
               aes(group = 1, y = after_stat(count * 0.2)))+
  labs(title = "A. Hist of sepal width",
                   subtitle = "Data distribution",
                   x = "Sepal width") + 
  theme(
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15)
      )
hist_plot  


# • точечный график, на котором будет отображаться зависимость Petal.Width от Sepal.Width (plot). 
# Задать свой цвет, форму элементов для каждого значения Species. 
# Размер элементов должен быть равен 3. 

dots_plot <- ggplot(iris, aes(x = Sepal.Width, y= Petal.Width, color = Species)) +
             geom_point(size = 3) +
             labs(title = "B. Plot petal width over sepal width",
                 subtitle = "Data dependence",
                 x = "Sepal width",
                 y = "Petal width")

dots_plot

# • боксплоты+джиттерплоты для каждого значения Species(три боксплота на 1 графике). 
# Надписи по оси абсцисс развернуть под углом 90 градусов.


box_n_jitter <- ggplot(iris, aes(y = Sepal.Width, x = Species, fill = Species)) + 
                geom_boxplot(alpha = 0.7) +
                geom_jitter(size=0.1) + 
                labs(title = "C. Sepal width data distribution",
                     subtitle = "Difference between species",
                     x = "Species",
                     y = "Sepal width") +
                theme(axis.text.x = element_text(angle = 90))

box_n_jitter

# Для датасета USArrests визуализировать:
#   • визуализировать корреляцию Спирмена между столбцами (разные виды коррплотов). 
# Задать синим цветом надпись Murder и зеленым - Assault, UrbanPop, Rape

library(corrplot)
library(reshape2)

cormat <- cor(USArrests,method ="spearman")
melted_cormat <- melt(cormat)
head(melted_cormat)

LabelCol = c("blue", "#03925e", "#03925e", "#03925e")

heat_map <- ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x = element_text(colour=LabelCol[melted_cormat$Var1]), 
    axis.text.y = element_text(colour=LabelCol[melted_cormat$Var1])) +
  labs(title = "Data dependence over USArrests",
       subtitle = "Spearman correlation")

heat_map


# Сохранить первые 4 рисунка с шириной 7,5 дюймов и разрешением не менее 300 dpi, формат tiff
# Сохранить первые 4 рисунка как единый рисунок с 4 панелями. 
# Обозначить панели латинскими буквами в верхнем левом углу. 


library(cowplot)

pg <- plot_grid(hist_plot, dots_plot, box_n_jitter,ncol=3)
ggsave("hw4_plot1.png",dpi=300, width=15, height = 5)
