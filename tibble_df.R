

library(tidyverse)
library(data.table)

iris_data_frame <- iris
iris_data_table <- data.table(iris_data_frame)
iris_tibble <- as_tibble(iris)
names(iris_data_frame) <- c(a="a 1","b 1","d2","d)")
#class
class(iris_data_frame)
class(iris_data_table)
class(iris_tibble)
#head
head(iris_data_frame)
head(iris_data_table)
head(iris_tibble)
#print on console
iris_data_frame
iris_data_table
iris_tibble

#type is list
typeof(iris_data_table)
mode(iris_data_table)
typeof(iris_tibble)
mode(iris_tibble)
typeof(iris_data_frame)
mode(iris_data_frame)

#get elements,rows and columns
#basic data frame
iris_data_frame[1:5,1:2]
iris_data_frame[1:5,1]
iris_data_frame[2,1:2]
rownames(iris_data_frame)

#data.table
iris_data_table[1:5,1:2]
iris_data_table[1:5,1]
iris_data_table[2,1:2]
rownames(iris_data_table)

iris_data_table %>% rownames()

starwars_tibble <- starwars

k<-starwars_tibble[1:3,1]
k1<-as.vector(starwars_tibble[1:3,1])
k2<-unlist(starwars_tibble[1:3,1])
k3<-as.vector(starwars_tibble[1,])
k5<-starwars_tibble[1,]
k4<-unlist(starwars_tibble[1,])

df0<-starwars_tibble %>% filter(mass > mean(mass, na.rm = TRUE))
df0[[2]]
df0[2,3]
df0[2:3]
df0[,2:3]
df0[[2,3]]
df0[[c(2,3)]]
df0[[,c(2,3)]]
df0[[,2:3]]
df0[[c(2,3)]]
colSums(df0[[c(2,3)]])
dim(df0)
colSums(starwars_tibble)
dim(starwars_tibble)

