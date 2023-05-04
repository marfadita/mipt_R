data(USArrests)
load(USArrests)
View(USArrests)
df <- USArrests

# 1
dim(df)
ncol(df)
nrow(df)

# 2
head(df)
tail(df)

# 3
df$UrbanPop[16:20]

# 4
mode(df)
class(df)
typeof(df)
print(df)

for(i in 1:ncol(df)) {
  print(colnames(df)[i])
  print(mode(df[,i]))
  print(class(df[,i]))
  print(typeof(df[,i]))
  cat('\n')
}

# 5
colnames(df)
rownames(df)
dimnames(df)

# 6 
sum(df)
mean(as.matrix(df), na.rm = TRUE)
sd(as.matrix(df))
var(as.matrix(df))

# 7
colSums(df)
colMeans(df)
sapply(df, sd)
sapply(df, var)

# 8
rowSums(df)
rowMeans(df)

# install.packages("matrixStats")
library(matrixStats)

rowSds(as.matrix(df))
rowVars(as.matrix(df))


# 9
for (i in colnames(df)){
  print(df[[i]][10:14])
}

# 10
sum(df < 10)

# 11
apply(df<10 ,2, sum)

# 12  “Miss” (which, rownames, grepl)
df_rows <- rownames(df)
df_rows[grepl("Miss", df_rows)]
which(grepl("Miss", df_rows))

# 13 "New"
ind <- which(grepl("New", df_rows))
summary(df[ind,])


# 14 
# записать файл .csv, содержащий 1-20 строки и 1 и 3 столбцы 
write.csv(df[seq(1:20),c(1,3)],"test_df.csv")

# 15
# записать файл .xlsx, содержащий листы M и N со статистикой для штатов, начинающихся на букву M и N 
states_m <- which(grepl("^M", df_rows))
states_n <- which(grepl("^N", df_rows))
states_m_stats <- summary(df[states_m,])
states_n_stats <- summary(df[states_n,])

dataset_names <- list('M' = states_m_stats, 'N' = states_n_stats)

openxlsx::write.xlsx(dataset_names, file="filename.xlsx")

# 16 
# прочитать записанные файлы
x_csv <- read.csv('test_df.csv')
head(x_csv,2)

x_m <- readxl::read_excel("filename.xlsx", sheet = 1)
x_m <- openxlsx::read.xlsx("filename.xlsx", sheet = 1)
x_m <- openxlsx::read.xlsx("filename.xlsx", sheet = "M",rowNames = T)
head(x_m,2)

x_n <- readxl::read_excel("filename.xlsx", sheet = 2)
head(x_n, 2)