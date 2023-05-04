

install.packages('psych')

# Scatter Plots
# Scatter Plot Matrices
# Box Plots
# Strip Charts: 1-D scatter Plots
# Bar Plots
# Line Plots
# Pie Charts
# Histogram and Density Plots
# QQ-plots: Quantile-Quantile plots
# Dot Charts
# Plot Group Means and Confidence Intervals
#scatter plots
libraries(utils)
x <- 1:10
y <- x ^ 2
plot(x, y)
plot(x, y, type = "b")
plot(x, y, type = "h")#col="green",
plot(x, y, type = "s")
plot(x, y, type = "l")

x1 <- 1:10
y1 = x ^ 3
plot(x1, y1,  xlim = c(5, 10))
plot(x1, y1,  xlim = c(5, 10),  main = "Figure1",  sub = "sutitle1",  xlab = "Axis 1", col = 'blue')
plot(x1, y1,  xlim = c(5, 10),  main = "Figure1",  sub = "sutitle1",  xlab = "Axis 1",  cex = 5)

# cex - размер отображаемых элементов
# col - цвет

# Scatter Plot Matrices
head(iris)
pairs(iris[, 1:4], pch = 19)
pairs(iris[, 1:4], pch = 19, lower.panel = NULL)
my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")
pairs(
  iris[, 1:4],
  pch = 19,
  cex = 0.5,
  col = my_cols[iris$Species],
  lower.panel = NULL
)
# Correlation panel
panel.cor <- function(x, y) {
  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- round(cor(x, y), digits = 2)
  txt <- paste0("R = ", r)
  cex.cor <- 0.8 / strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
# Customize upper panel
upper.panel <- function(x, y) {
  points(x, y, pch = 19, col = my_cols[iris$Species])
}
# Create the plots
pairs(iris[, 1:4],
      lower.panel = panel.cor,
      upper.panel = upper.panel)
# Customize upper panel
upper.panel <- function(x, y) {
  points(x,
         y,
         pch = 19,
         col = c("red", "green3", "blue")[iris$Species])
  r <- round(cor(x, y), digits = 2)
  txt <- paste0("R = ", r)
  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  text(0.5, 0.9, txt)
}
pairs(iris[, 1:4], lower.panel = NULL,
      upper.panel = upper.panel)

# install.packages("psych")
library(psych)
pairs.panels(
  iris[,-5],
  method = "pearson",
  # correlation method
  hist.col = "#00AFBB",
  density = TRUE,
  # show density plots
  ellipses = TRUE # show correlation ellipses
)


# Box Plots
head(ToothGrowth)
# Box plot of one variable
boxplot(ToothGrowth$len)
# Box plots by groups (dose)
# remove frame
boxplot(len ~ dose, data = ToothGrowth, frame = F)
# Horizontal box plots
boxplot(len ~ dose,
        data = ToothGrowth,
        frame = FALSE,
        horizontal = TRUE)
# Notched box plots
boxplot(len ~ dose,
        data = ToothGrowth,
        frame = FALSE,
        notch = TRUE)
boxplot(
  len ~ dose,
  data = ToothGrowth,
  frame = FALSE,
  names = c("D0.5", "D1", "D2")
)
# Change the color of border using one single color
boxplot(len ~ dose,
        data = ToothGrowth,
        frame = FALSE,
        border = "steelblue")
# Change the color of border.
#  Use different colors for each group
boxplot(
  len ~ dose,
  data = ToothGrowth,
  frame = FALSE,
  border = c("#999999", "#E69F00", "#56B4E9")
)
# Change fill color : single color
boxplot(len ~ dose,
        data = ToothGrowth,
        frame = FALSE,
        col = "steelblue")
# Change fill color: multiple colors
boxplot(
  len ~ dose,
  data = ToothGrowth,
  frame = FALSE,
  col = c("#999999", "#E69F00", "#56B4E9")
)
boxplot(
  len ~ supp * dose,
  data = ToothGrowth,
  col = c("white", "steelblue"),
  frame = FALSE
)
ToothGrowth$supp
# Change axis titles
# Change color (col = "gray") and remove frame
# Create notched box plot
boxplot(
  len ~ dose,
  data = ToothGrowth,
  main = "Plot of length by dose",
  xlab = "Dose (mg)",
  ylab = "Length",
  col = "lightgray",
  frame = FALSE
)

# Strip charts: 1-D scatter plots
# Plot len by dose
stripchart(len ~ dose,
           data = ToothGrowth,
           pch = 10,
           frame = FALSE)
# Vertical plot using method = "jitter"
stripchart(
  len ~ dose,
  data = ToothGrowth,
  pch = 19,
  frame = FALSE,
  vertical = TRUE,
  method = "jitter"
)
# Change point shapes (pch) and colors by groups
# add main title and axis labels
stripchart(
  len ~ dose,
  data = ToothGrowth,
  frame = FALSE,
  vertical = TRUE,
  method = "jitter",
  pch = c(21, 18, 16),
  col = c("#999999", "#E69F00", "#56B4E9"),
  main = "Length by dose",
  xlab = "Dose",
  ylab = "Length"
)

# Bar Plots
x <- VADeaths[1:3, "Rural Male"]
# Bar plot of one variable
barplot(x)
# Horizontal bar plot
barplot(x, horiz = TRUE)
barplot(x, names.arg = c("A", "B", "C"))
# Change border and fill color using one single color
barplot(x, col = "white", border = "steelblue")
# Change the color of border.
#  Use different colors for each group
barplot(x,
        col = "white",
        border = c("#999999", "#E69F00", "#56B4E9"))
# Change fill color : single color
barplot(x, col = "steelblue")
# Change fill color: multiple colors
barplot(x, col = c("#999999", "#E69F00", "#56B4E9"))
# Change axis titles
install.packages('')
# Change color (col = "gray") and remove frame

# res в стандратных библиоотеках означает разрешение

barplot(x,
        main = "Death Rates in Virginia",
        xlab = "Age",
        ylab = "Rate")
barplot(
  VADeaths,
  col = c("lightblue", "mistyrose", "lightcyan",
          "lavender", "cornsilk"),
  legend = rownames(VADeaths)
)
barplot(
  VADeaths,
  col = c("lightblue", "mistyrose", "lightcyan",
          "lavender", "cornsilk"),
  legend = rownames(VADeaths),
  beside = TRUE
)
# Define a set of colors
my_colors <- c("lightblue", "mistyrose", "lightcyan",
               "lavender", "cornsilk")
getwd()
png("my_plot1_300.png",
    width = 2000,
    height = 1000,
    res = 350)
# Bar plot
barplot(
  VADeaths,
  col = my_colors,
  beside = TRUE,
  cex.names = 0.5,
  cex.axis = 2
)
# Add legend
legend(
  "topleft",
  legend = rownames(VADeaths),
  fill = my_colors,
  box.lty = 0,
  cex = 0.4
)
dev.off()
# Line Plots
# Plots with multiple lines
# Create a first line
x <- 1:10
y1 <- x * x
y2  <- 2 * y1
plot(
  x,
  y1,
  type = "b",
  frame = FALSE,
  pch = 19,
  col = "red",
  xlab = "x",
  ylab = "y"
)
# Add a second line
lines(
  x,
  y2,
  pch = 18,
  col = "blue",
  type = "b",
  lty = 2
)#
# Add a legend to the plot
legend(
  "topleft",
  legend = c("Line 1", "Line 2"),
  col = c("red", "blue"),
  lty = 1:2,
  cex = 0.8
)

# Pie Charts
df <- data.frame(group = c("Male", "Female", "Child"),
                 value = c(25, 25, 50))
df
pie(df$value, labels = df$group, radius = 1)
# Change colors
pie(
  df$value,
  labels = df$group,
  radius = 1,
  # col = c("#999999", "#E69F00", "#56B4E9"))
  col = c("red", "green", "yellow")
)
# install.packages("plotrix")
# 3D pie chart
library("plotrix")
pie3D(
  df$value,
  labels = df$group,
  radius = 1.5,
  col = c("#999999", "#E69F00", "#56B4E9")
)
# Explode the pie chart
pie3D(
  df$value,
  labels = c("a", "b", "c"),
  radius = 3,
  col = c("#999999", "#E69F00", "#56B4E9"),
  explode = 0.1
)

# Histogram and Density Plots
set.seed(1234)
x <- c(rnorm(200, mean = 55, sd = 5),
       rnorm(200, mean = 65, sd = 5))
head(x)
hist(x, breaks = "Sturges")
hist(x, col = "steelblue", frame = FALSE)
# Change the number of breaks
hist(x,
     col = "steelblue",
     frame = FALSE,
     breaks = 30)
# Compute the density data
dens <- density(mtcars$mpg)
# plot density
plot(dens,
     frame = FALSE,
     col = "steelblue",
     main = "Density plot of mpg")
# Fill the density plot using polygon()
plot(dens,
     frame = FALSE,
     col = "steelblue",
     main = "Density plot of mpg")
polygon(dens, col = "steelblue")
# Store the data in the variable my_data
my_data <- ToothGrowth
qqnorm(my_data$len, pch = 1, frame = FALSE)
qqline(my_data$len, col = "steelblue", lwd = 2)
library("car")
qqPlot(my_data$len)
# Dot Charts
set.seed(5)
# sample(10)
random_vector <- sample(1:10)
sort(random_vector)
sort(random_vector, decreasing = T)
mtcars_non_sorted <- mtcars
mtcars1 <- mtcars[order(mtcars$drat, decreasing = T),]
mtcars2 <- mtcars[order(rownames(mtcars)),]

dotchart(
  x,
  labels = NULL,
  groups = NULL,
  gcolor = par("fg"),
  color = par("fg")
)
# Dot chart of a single numeric vector
dotchart(mtcars$mpg,
         labels = row.names(mtcars),
         cex = 0.6,
         xlab = "mpg")
# Plot and color by groups cyl
grps <- as.factor(mtcars$cyl)
my_cols <- c("#999999", "#E69F00", "#56B4E9")
dotchart(
  mtcars$mpg,
  labels = row.names(mtcars),
  groups = grps,
  gcolor = my_cols,
  color = my_cols[grps],
  cex = 0.6,
  pch = 19,
  xlab = "mpg"
)
# Dot chart of a matrix
dotchart(VADeaths, cex = 0.6,
         main = "Death Rates in Virginia - 1940")
