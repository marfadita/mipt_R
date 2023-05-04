#1
# Для датасета iris визуализировать:
# • распределение Sepal.Width в виде гладкой линии и гистограммы (hist, plot-density-polygon)
# • подписать имена оси x, заголовок, подзаголовок, 
# заполнить цветом гистограмму
# задать другим цветом границы столбцов гистограммы. 
# Увеличить размер шрифтов для осей в 2 раза(подписи и тики).

dens <- density(iris$Sepal.Widt)

hist1 <- hist(iris$Sepal.Width,
     col = "steelblue", border = 'red',
  main = "Hist of sepal width", sub = "sutitle1",
  xlab = "Width",
  ylab = "Counts",
  breaks = 30, lwd = 2,
  cex.axis = 2)

dens1 <- plot(dens,
     frame = FALSE,
     col = "steelblue",  
     xlab = "Width",
     ylab = "Counts",
     main = "Density plot of sepal width",sub = "sutitle1",
     lwd = 2,
     cex.axis = 2)

# 2
# • точечный график, на котором будет отображаться зависимость Petal.Width от Sepal.Width (plot). 
# Задать свой цвет, форму элементов для каждого значения Species. 
# Размер элементов должен быть равен 3. 

my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")
my_pch <- c(16, 17, 18)

corr_plot1 <- plot(iris$Petal.Width, iris$Sepal.Width,  
     main = "Plot petal width over sepal width",  
     sub = "sutitle1",  xlab = "Petal Width", ylab = "Sepal Width",  
     cex = 3, 
     pch = my_pch[iris$Species],
     col = my_cols[iris$Species])


# 4
# • боксплоты+джиттерплоты для каждого значения Species(три боксплота на 1 графике). 
# Надписи по оси абсцисс развернуть под углом 90 градусов.

boxplot(iris$Sepal.Width ~ iris$Species,
        main = "Plot of width by species",
        xlab = "sepal width",
        ylab = "species", 
        col = c("#999999", "#E69F00", "#56B4E9"), yaxt = "n")
stripchart(iris$Sepal.Width ~ iris$Species,
           vertical = TRUE, 
           method = "jitter", add = TRUE, pch = 21, 
           col = c("#999999", "#E69F00", "#56B4E9"), yaxt = "n")
 axis(side = 2,
     las = 2)


# Для датасета USArrests визуализировать:
#   • визуализировать корреляцию Спирмена между столбцами (разные виды коррплотов). 
# Задать синим цветом надпись Murder и зеленым - Assault, UrbanPop, Rape

library(corrplot)

M <- cor(USArrests,method ="spearman")
LabelCol = c("blue", "#03925e", "#03925e", "#03925e")
corrplot(M, method = 'color', tl.col=LabelCol, tl.cex = 1.5)


# Сохранить первые 4 рисунка с шириной 7,5 дюймов и разрешением не менее 300 dpi, формат tiff
# Сохранить первые 4 рисунка как единый рисунок с 4 панелями. 
# Обозначить панели латинскими буквами в верхнем левом углу. 

# 300 dpi == 118.11 ppi, res in ppi

tiff("hw3_plot1", res = 118.11)
#set 4 panels
par(mfrow=c(2,2))

#create hist
hist(iris$Sepal.Width,
     col = "steelblue", border = 'red',
     main = "Hist plot",  sub = "Hist of sepal width", 
     xlab = "Width",
     ylab = "Counts",
     breaks = 30, lwd = 2,
     cex.axis = 2)

mtext("A.",
      side = 3, adj = -0.5, line = 3)

#create dens plot
plot(dens,
     frame = FALSE,
     col = "steelblue",  
     xlab = "Width",
     ylab = "Counts",
     main = "Density plot",sub = "Density of sepal width",
     lwd = 2,
     cex.axis = 2)
mtext("B.",
      side = 3, adj = -0.5, line = 3)

#create corr plot
plot(iris$Petal.Width, iris$Sepal.Width,  
     main = "Plot of dependence", 
     sub = "Petal width over sepal width",  xlab = "Petal Width", ylab = "Sepal Width",  
     cex = 3, 
     pch = my_pch[iris$Species],
     col = my_cols[iris$Species])
mtext("C.",
      side = 3, adj = -0.5, line = 3)

#create boxplot + jitt
boxplot(iris$Sepal.Width ~ iris$Species,
        main = "Box plot & Jitter plot",
        sub = 'Plot of width by species',
        xlab = "sepal width",
        ylab = "species", 
        col = c("#999999", "#E69F00", "#56B4E9"), yaxt = "n")
stripchart(iris$Sepal.Width ~ iris$Species,
           vertical = TRUE, 
           method = "jitter", add = TRUE, pch = 21, 
           col = c("#999999", "#E69F00", "#56B4E9"), yaxt = "n")
axis(side = 2,
     las = 2)
mtext("D.",
      side = 3, adj = -0.5, line = 3)
dev.off()


# Сохранить рисунок с шириной 2600 точек, высотой 2800 и разрешением не менее 300 dpi, формат png
png('hw3_plot2', res = 118.11, width = 2600, height = 2800)
corrplot(M, method = 'color', tl.col=LabelCol, tl.cex = 5)
dev.off()
