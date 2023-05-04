#function components

f02 <- function(x, y) {
  # A comment
  x + y
}
#arguments
formals(f02)
#> $x
#> 
#> 
#> $y
#body
body(f02)
#> {
#>     x + y
#> }
#enviroment
environment(f02)
#> <environment: R_GlobalEnv>
attributes(f02)
attr(f02, "srcref")

# Primitive functions
# There is one exception to the rule that a function has three components. Primitive functions, like sum() and [, call C code directly.
                                                                                                              
sum
#> function (..., na.rm = FALSE)  .Primitive("sum")
`[`
#> .Primitive("[")
# They have either type builtin or type special.
typeof(sum)
#> [1] "builtin"
typeof(`[`)
#> [1] "special"
# These functions exist primarily in C, not R, so their formals(), body(), and environment() are all NULL:
?`[`

formals(sum)
#> NULL
body(sum)
#> NULL
environment(sum)
#> NULL
                                                           # Primitive functions are only found in the base package. While they have certain performance advantages, this benefit comes at a price: they are harder to write. For this reason, R-core generally avoids creating them unless there is no other option.

#Primitive Functions List
sort(names(methods:::.BasicFunsList))


# First-class functions

  f01 <- function(x) {
    sin(1 / x ^ 2)
  }

# Anonymous functions
  
lapply(mtcars, function(x) length(unique(x)))

# We can put functions in a list:
  funs <- list(
    half = function(x) x / 2,
    double = function(x) x * 2
  )

funs$double(10)
#> [1] 20

# Invoking a function
# usual call:
mean(1:10, na.rm = TRUE)
#> [1] 5.5

# alterative call: the arguments are already in a data structure
args <- list(1:10, na.rm = TRUE)
do.call(mean, args)
#> [1] 5.5

