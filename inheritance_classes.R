# Inheritance in S3 Class
# S3 classes do not have any fixed definition. Hence attributes of S3 objects can be arbitrary.
#
# Derived class, however, inherit the methods defined for base class. Let us suppose we have a function that creates new objects of class student as follows.


student <- function(n, a, g) {
  value <- list(name = n, age = a, GPA = g)
  attr(value, "class") <- "student"
  value
}
# Furthermore, we have a method defined for generic function print() as follows.

print.student <- function(obj) {
  cat(obj$name, "\n")
  cat(obj$age, "years old\n")
  cat("GPA:", obj$GPA, "\n")
}

# Now we want to create an object of class InternationalStudent which inherits from student.

# This is be done by assigning a character vector of class names like class(obj) <- c(child, parent).

# create a list
s <- list(
  name = "John",
  age = 21,
  GPA = 3.5,
  country = "France"
)
# make it of the class InternationalStudent which is derived from the class student
class(s) <- c("InternationalStudent", "student")
# print it out
s

# We can see above that, since we haven’t defined any method of the form print.InternationalStudent(), 
# the method print.student() got called. This method of class student was inherited.

# Now let us define print.InternationalStudent().

print.InternationalStudent <- function(obj) {
  cat(obj$name, "is from", obj$country, "\n")
}
# This will overwrite the method defined for class student as shown below.

s
# John is from France
# We can check for inheritance with functions like inherits() or is().

inherits(s, "student")
# [1] TRUE
is(s, "student")
# [1] TRUE
# Inheritance in S4 Class
# Since S4 classes have proper definition, derived classes will inherit both attributes and methods of the parent class.
#
# Let us define a class student with a method for the generic function show().

# define a class called student
setClass("student",
         slots = list(name = "character", age = "numeric", GPA = "numeric"))
# define class method for the show() generic function
setMethod("show",
          "student",
          function(object) {
            cat(object@name, "\n")
            cat(object@age, "years old\n")
            cat("GPA:", object@GPA, "\n")
          })

# Inheritance is done during the derived class definition with the argument contains as shown below.

# inherit from student
setClass(
  "InternationalStudent",
  slots = list(country = "character"),
  contains = "student"
)
# Here we have added an attribute country, rest will be inherited from the parent.

s <-
  new(
    "InternationalStudent",
    name = "John",
    age = 21,
    GPA = 3.5,
    country = "France"
  )
show(s)

# We see that method define for class student got called when we did show(s).

# We can define methods for the derived class which will overwrite methods of the base class, like in the case of S3 systems.

