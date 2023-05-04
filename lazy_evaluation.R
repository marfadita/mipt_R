# Lazy evaluation
# In R, function arguments are lazily evaluated: they’re only evaluated if accessed. For example, this code doesn’t generate an error because x is never used:
  h01 <- function(x) {
    10
  }
h01(stop("This is an error!"))
#> [1] 10
# This is an important feature because it allows you to do things like include potentially expensive computations in function arguments that will only be evaluated if needed.
# 
h01 <- function(x, y=x){
  x = 10
  print(x)
  print(y)  # пересчет значения при первом вызове
}
h01(1)


h011 <- function(x, y=x){
  print(paste('first usage of y', y))
  x = 10
  print(x)
  print(y)  # пересчет значения после первого вызова не происходит
}
h011(1)
#######Promises
# Lazy evaluation is powered by a data structure called a promise, or (less commonly) a thunk. 
# 
# A promise has three components:
#   
#   An expression, like x + y, which gives rise to the delayed computation.
# 
# An environment where the expression should be evaluated, i.e. the environment where the function is called. This makes sure that the following function returns 11, not 101:
#   
  y <- 10
h02 <- function(x) {
  y <- 100
  x + 1
}

h02(y)  # возьмется из глобального окружения
#> [1] 11
# This also means that when you do assignment inside a call to a function, the variable is bound outside of the function, not inside of it.

h02(y <- 1000)
#> [1] 1001
y
#> [1] 1000
# A value, which is computed and cached the first time a promise is accessed when the expression is evaluated in the specified environment. This ensures that the promise is evaluated at most once, and is why you only see “Calculating…” printed once in the following example.

double <- function(x) { 
  message("Calculating...")
  x * 2
}

h03 <- function(x) {
  c(x, x)
}

h03(double(20))
#> Calculating...
#> [1] 40 40
# You cannot manipulate promises with R code. Promises are like a quantum state: any attempt to inspect them with R code will force an immediate evaluation, making the promise disappear. 

#######Default arguments
# Thanks to lazy evaluation, default values can be defined in terms of other arguments, or even in terms of variables defined later in the function:
#   
  h04 <- function(x = 1, y = x * 2, z = a + b) {
    a <- 10
    b <- 100
    
    c(x, y, z)
  }

h04()
# #> [1]   1   2 110
# Many base R functions use this technique, but I don’t recommend it. It makes the code harder to understand: to predict what will be returned, you need to know the exact order in which default arguments are evaluated.
# 
# The evaluation environment is slightly different for default and user supplied arguments, as default arguments are evaluated inside the function. This means that seemingly identical calls can yield different results. It’s easiest to see this with an extreme example:
  
  h05 <- function(x = ls()) {
    a <- 1
    x
  }

# ls() evaluated inside h05:
h05()
#> [1] "a" "x"

# ls() evaluated in global environment:
h05(ls())
#> [1] "h05"
######Missing arguments
# To determine if an argument’s value comes from the user or from a default, you can use missing():
  
  h06 <- function(x = 10) {
    list(missing(x), x)
  }
str(h06())
#> List of 2
#>  $ : logi TRUE
#>  $ : num 10
str(h06(10))
#> List of 2
#>  $ : logi FALSE
#>  $ : num 10
# missing() is best used sparingly, however. Take sample(), for example. How many arguments are required?
str(h06(20))
# List of 2
# $ : logi FALSE
# $ : num 20

scref(sample)
args(sample)
#> function (x, size, replace = FALSE, prob = NULL) 
#> NULL
# It looks like both x and size are required, but if size is not supplied, sample() uses missing() to provide a default. If I were to rewrite sample, I’d use an explicit NULL to indicate that size is not required but can be supplied:
  
  sample <- function(x, size = NULL, replace = FALSE, prob = NULL) {
    if (is.null(size)) {
      size <- length(x)
    }
    
    x[sample.int(length(x), size, replace = replace, prob = prob)]
  }
# With the binary pattern created by the %||% infix function, which uses the left side if it’s not NULL and the right side otherwise, we can further simplify sample():
  
  `%||%` <- function(lhs, rhs) {
    if (!is.null(lhs)) {
      lhs
    } else {
      rhs
    }
  }

sample <- function(x, size = NULL, replace = FALSE, prob = NULL) {
  size <- size %||% length(x)
  x[sample.int(length(x), size, replace = replace, prob = prob)]
}
# Because of lazy evaluation, you don’t need to worry about unnecessary computation: the right side of %||% will only be evaluated if the left side is NULL.
