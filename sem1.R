c('a', 'd', 'c') -> vector_1

matrix_1 <- matrix(1:12, nrow = 4, ncol = 3)

dataframe_1 <- data.frame(
  'first'=vector_1,
  'second'= 7:9
)

# view(dataframe_1) не отработает, так как регистрозависимый язык


View(dataframe_1)

dataframe_1$first