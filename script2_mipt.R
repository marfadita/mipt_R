# Basic functions
  
#repeats  
rep(3,8)
rep("a",8)
rep(c("a","b"),5)
rep(c("a","b"),each=5)

#seq: generate regular sequences. 

seq(from=1, to=9)
seq(1, 9)
seq(1, 9, by = 2)
seq(0, 1, length.out = 11)
seq_along(along.with = c("a","b"))
#rm: delete the variable
?seq_along

x <- 5
rm(x)
# delete all variables
rm(list=ls())
#Subset : Return subsets of vectors, matrices or data frames which meet conditions.
View(airquality)
subset(airquality, Temp > 80, select = c(Ozone, Temp))

airquality[airquality$Temp > 80, c('Ozone', 'Temp')]
#  эквивалентная сабсет команда, нужно указывать что Temp относится именно к этой df

# To see the list of pre-loaded data, type the function data():
data()

# Loading
data(iris)
load(iris)
View(iris)

#with: Evaluate an R expression in an environment constructed from data. with does not modify the original data.

# equivalent statements:
with(iris, sum(Petal.Length) - sum(Petal.Width))
# команда with не меняет оргинальные данные, within меняет

sum(iris$Petal.Length)-sum(iris$Petal.Width)

#within: change the original data
iris_copy <- iris
head(iris_copy)
within(iris_copy, Petal.Length <- Petal.Length+100)
head(iris_copy)

# table: uses cross-classifying factors to build a contingency table of the counts at each combination of factor levels.

table(iris$Species)
table(iris$Petal.Width)

airquality$Ozone

with(airquality,
     table(OzHi = Ozone > 80, Month, useNA = "no"))
with(airquality,
     table(OzHi = Ozone > 80, Month, useNA = "ifany"))

# explore a numeric vector
x<-iris$Petal.Width
length(x)
summary(x)
mean(x)
median(x)
quantile(x,0.5)
quantile(x,0.1)
sd(x)
var(x)
names(x)
names(x) <- LETTERS
x
rm(x)

## explore a dataset
x <- iris
dim(x)
ncol(x)
nrow(x)
rownames(x)
colnames(x)
dimnames(x)

summary(x)
colMeans(x) # it does not work because different data types in dataframe
colMeans(x[,1:4])
colMeans(x[,-5])
rowMeans(x[,-5])

colSums(x[,-5])
rowSums(x[,-5])

rm(x)
#NA processing

data(airquality) 
load(airquality)
is.na(airquality)
sum(is.na(airquality))

airquality1 <- na.omit(airquality)
sum(is.na(airquality1))

airquality2 <- airquality
airquality2[is.na(airquality2)] <- 0
sum(is.na(airquality2))

#processing text data

x <- "garden"
nchar(x)

substr(x,1,3)

gsub("g","w",x)
gsub("ar","",x)
gsub(".$","",x)

paste(x,"in the city")
paste(x,"in the city",sep = "_")
paste0(x,"ia")

LETTERS
paste(LETTERS, collapse = "_")
paste0(LETTERS,collapse = "")
# collapse склеивает значения внтури одного вектора, sep - значения разных векторов

#find location of a symbol in the stribg
# 1: Find Location of Every Occurrence
unlist(gregexpr("p", "paraphrase"))
unlist(gregexpr("a", "paraphrase"))

# 2: Find Location of First Occurrence
unlist(gregexpr("a", "paraphrase"))[1]

# 3: Find Location of Last Occurrence
tail(unlist(gregexpr("a", "paraphrase")), n=1)

# 4: Find Total Number of Occurrences
length(unlist(gregexpr("a", "paraphrase")))

#find pattern in a vector
txt <- c("The", "licenses", "for", "most", "software", "are",
         "designed", "to", "take", "away", "your", "freedom",
         "to", "share", "and", "change", "it.")

grep("g", txt)
txt[grepl("^d|^f", txt)]
which(grepl("d", txt))

## matching of indices
x <- c(1,2,1,5,6,8,1,58,9,10)
which(x==1)

x1 <- c("a1","a2","a3","a4")
x2 <- c("a1","a3","a4","a2")
match(x1, x2)
# какие элементы из х1 сопоставляются с элементами х2

#upper and lower case
tolower("Tree")
toupper("building")

#random values

#Set the seed of R's random number generator
set.seed(123)

#get n random numbers or shuffle items
sample(50)
sample(10:16)
sample(letters[1:10])

# rnorm: random generation for the normal distribution
rnorm(10)
rnorm(10, mean = 0, sd = 1)
rnorm(10, mean = 100, sd = 8)

#work with files and directories

getwd()
current_wd <- getwd()
lower_wd <- gsub(".*/","",current_wd)
lower_wd
setwd("/home/marfa/Desktop/R")#1 level up
getwd()
setwd(lower_wd)#1 level down
getwd()

#get list of files in the directory
x <- list.files("G:/WD/R_mipt4_2023")
x
#get list of directories 
y <- list.files("G:/WD")
rm(y)

#create a directory
dir.create("/test_directory")
list.files(getwd())

#copy file
file.copy(x[1],"G:/WD/R_mipt4_2023/test_directory/test_file.txt")
#remove directory with files
unlink("G:/WD/R_mipt4_2023/test_directory", recursive=TRUE)

dir_name <- "G:/WD/R_mipt4_2023/files_for_classes"
dir.create(dir_name)
setwd(dir_name)

## write datasheets
write.csv(iris,"test_iris.csv")
write.table(iris,"test_iris.tsv",sep="\t")
write.table(iris,"test_iris.txt",sep="\t")
openxlsx::write.xlsx(iris,"test_iris_by_openxlsx.xlsx")
install.packages('xlsx')
install.packages("rJava")
library(openxlsx)
library(xlsx)
xlsx::write.xlsx(iris,"test_iris_by_xlsx.xlsx")
writexl::write_xlsx(iris,"test_iris_by_writexl.xlsx")
## read datasheets
x1 <-read.csv("test_iris.csv")
head(x1,2)
x2 <- read.csv("test_iris.csv",row.names = 1)
head(x2,2)
x3 <- read.table("test_iris.tsv",sep="\t",row.names = 1)
head(x3,2)
x4 <- read.table("test_iris.txt",sep="\t",row.names = 1)
head(x4,2)
x5 <- openxlsx::read.xlsx("test_iris_by_openxlsx.xlsx")
head(x5,2)
x6 <- xlsx::read.xlsx("test_iris_by_xlsx.xlsx",sheetIndex=1)
head(x6,2)
x7 <- readxl::read_xlsx("test_iris_by_writexl.xlsx")
head(x6,2)


# при пересечении имен функций в загруженных пакетах, будет использоваться 
# функция из последнего подгруженного пакета, поэтому лучше указывать из какого именно
# пакета нужна функция

