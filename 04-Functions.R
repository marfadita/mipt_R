#LET's START WITH EXAMPLE 
#Before learning how to write custom functions, let's motivate functions once again. Let us assume we have to calculate the standard deviation for a series of numeric vectors. 

# "Manually" calculate the standard deviation : 
sqrt(sum((x - mean(x))^2) / (length(x) - 1))
#Sure, there already is a function to calculate the standard deviation (sd()), but we will use our own code for this example.

# Define the three vectors (random numbers)
set.seed(3) # Pseudo-randomization
x1 <- rnorm(1000, 0, 1.0)
x2 <- rnorm(1000, 0, 1.5)
x3 <- rnorm(1000, 0, 5.0)

# Calculate standard deviation once ...
sd1 <- sqrt(sum((x1 - mean(x1))^2) / (length(x1) - 1))
# ... and again, ...
sd2 <- sqrt(sum((x2 - mean(x2))^2) / (length(x2) - 1))
# ... and again ...
sd3 <- sqrt(sum((x3 - mean(x1))^2) / (length(x3) - 1))
c(sd1 = sd1, sd2 = sd2, sd3 = sd3)

#Rather than doing this spaghetti-style coding (unstructured and difficult-to-maintain source) we now use functions.
# User-defined standard deviation function
sdfun <- function(x) {
  res <- sqrt(sum((x - mean(x))^2) / (length(x) - 1))
  return(res)  # или  просто res, как будто просто распечатали
}
# Define some values
set.seed(3) # Pseudo-randomization
x1 <- rnorm(1000, 0, 1)
x2 <- rnorm(1000, 0, 1.5)
x3 <- rnorm(1000, 0, 5)

# Calculate standard deviation
sd1 <- sdfun(x1)
sd2 <- sdfun(x2)
sd3 <- sdfun(x3)
c(sd1 = sd1, sd2 = sd2, sd3 = sd3)

#An example of co-existence of a vector called mean and the function mean()
mean <- c(1, 2, 3, 4, 5, 6)  # Vector called 'mean'
mean(mean)                   # Function called 'mean()'

#INTRODUCTION TO FUNCTIONS
#Syntax for Writing Functions in R
function.name <- function(arguments) 
{
  computations on the arguments
  some other code
}

#example 1:
my_function <- function() { # create a function with the name my_function
  print("Hello World!")
}

#example 2:
pow <- function(x, y) {
  # function to print x raised to the power y
  result <- x^y
  print(paste(x,"raised to the power", y, "is", result))
}

#Call a Function

#call example 1
my_function <- function() {
  print("Hello World!")
}

my_function() # call the function named my_function

#call example 2:
pow(8, 2)
pow(2, 8)

#Arguments:
#The following example has a function with one argument (fname). When the function is called, we pass along a first name, which is used inside the function to print the full name:
my_function <- function(fname) {
  paste(fname, "Griffin")
}

my_function("Peter")
my_function("Lois")
my_function("Stewie")

#Number of Arguments: by default, a function must be called with the correct number of arguments. Meaning that if your function expects 2 arguments, you have to call the function with 2 arguments, not more, and not less:
my_function <- function(fname, lname) {
  paste(fname, lname)
}

my_function("Peter", "Griffin")

#Default Parameter Value: if we call the function without an argument, it uses the default value:
my_function <- function(country = "Norway") {
  paste("I am from", country)
}

my_function("Sweden")
my_function("India")
my_function() # will get the default value, which is Norway
my_function("USA")

#Return Values
my_function <- function(x) {
  return (5 * x)
}

print(my_function(3))
print(my_function(5))
print(my_function(9))

#Example: we are going to define a function fahrenheit_to_celsius that converts temperatures from Fahrenheit to Celsius:
fahrenheit_to_celsius <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5 / 9
  return(temp_C)
}
# freezing point of water
fahrenheit_to_celsius(32)
# boiling point of water
fahrenheit_to_celsius(212)

#Now that we've seen how to turn Fahrenheit into Celsius, it's easy to turn Celsius into Kelvin:
celsius_to_kelvin <- function(temp_C) {
  temp_K <- temp_C + 273.15
  return(temp_K)
}
# freezing point of water in Kelvin
celsius_to_kelvin(0)

#What about converting Fahrenheit to Kelvin? We could write out the formula, but we don't need to. Instead, we can compose the two functions we have already created:
fahrenheit_to_kelvin <- function(temp_F) {
  temp_C <- fahrenheit_to_celsius(temp_F)
  temp_K <- celsius_to_kelvin(temp_C)
  return(temp_K)
}
# freezing point of water in Kelvin
fahrenheit_to_kelvin(32.0)


#Nested Functions
#There are two ways to create a nested function: 1)Call a function within another function.2)Write a function within a function
Nested_function <- function(x, y) {
  a <- x + y
  return(a)
}

Nested_function(Nested_function(2,2), Nested_function(3,3))

#Example:
#This example showed the output of fahrenheit_to_celsius assigned to temp_C, which is then passed to celsius_to_kelvin to get the final result. It is also possible to perform this calculation in one line of code, by "nesting" one function call inside another, like so:
# freezing point of water in Fahrenheit
celsius_to_kelvin(fahrenheit_to_celsius(32.0))

#Write a function within a function:
Outer_func <- function(x) {
  Inner_func <- function(y) {
    a <- x + y
    return(a)
  }
  return (Inner_func)
}
output <- Outer_func(3) # To call the Outer_func
output(5)

#Recursion: Recursion is a common mathematical and programming concept. It means that a function calls itself. This has the benefit of meaning that you can loop through data to reach a result.
#In this example, tri_recursion() is a function that we have defined to call itself ("recurse"). We use the k variable as the data, which decrements (-1) every time we recurse. The recursion ends when the condition is not greater than 0 (i.e. when it is 0).
tri_recursion <- function(k) {
  if (k > 0) {
    result <- k + tri_recursion(k - 1)
    print(result)
  } else {
    result = 0
    return(result)
  }
}
tri_recursion(6)

#The NULL value in R
x <- NULL
length(x)
class(x)
typeof(x)
is.null(x)

#Concatenate and print
# Output simple character string
cat("What a great day!\n")
# Combine a variable `x` with a character string + \n
x <- "What a great day"
cat(x, "today!\n")
# Concatenate character strings and elements of named numeric vector
housecat <- c("height" = 46, "weight" = 4.5)
cat("The average house cat is", housecat["height"],
    "cm tall\nand weighs", housecat["weight"], "kilograms.\n")
x <- cat("What does cat return?\n")
print(x)
class(x)

res <- paste("The average house cat is", housecat["height"],
             "cm tall\nand weighs", housecat["weight"], "kilograms.\n")
length(res)
class(res)
cat(res)

#Calling R Functions Defined in Other Scripts
source("myScript.R") #load function saved in "myscript"
#to find a specific function, such as myFirstFun, within a script file MyUtils.R, which contains other utility functions. In this case, the 'source' command will load the function once you've found it with the call to the function exists()
if(exists("myFirstFun", mode = "function"))
  source("MyUtils.R")
#If misspell or forgot how you called your file, you can use sapply() to retrieve a list of filenames with extension .R, with their full name, from your directory, say "/R/MyFiles", and of course load them:
sapply(list.files(pattern="[.]R$", path="R/MyFiles", full.names=TRUE), source);


