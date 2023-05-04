# S3,S4 and Reference classes in R

# S3 class
# S3 class has no formal, predefined definition.
# 
# Basically, a list with its class attribute set to some class name, is an S3 object.
# The components of the list become the member variables of the object.
# 
# Following is a simple example of how an S3 object of class student can be created.

# create a list with required components
s <- list(name = "John", age = 21, GPA = 3.5)
s_not_student <- list(name = "John", age = 21, GPA = 3.5)

# name the class appropriately
class(s) <- "student" 

# That's it! we now have an object of class "student"
s
# $name
# [1] "John"
# $age
# [1] 21
# $GPA
# [1] 3.5
# attr(,"class")
# [1] "student"
class(s) #or attr(s,"class")
class(s_not_student) 

# functions = generic + methods
#S3 works by defining a strict naming convention of generic.class.

# Creating your Own Generic Method in S3
#example: create method age for class student
age <- function(object) {
  UseMethod("age")
}
age.student <- function(object) {
  cat("Student age", object$age, "\n")
}
age(s)
age(s_not_student)#it is an error

#S4 class
# An S4 class is defined using setClass() function 
setClass("employee", slots=list(name="character", id="numeric", contact="character"))

obj <- new("employee",name="Steven", id=1002, contact="West Avenue")
obj

# An object of class "employee"
# Slot "name":
#   [1] "Steven"
# 
# Slot "id":
#   [1] 1002
# 
# Slot "contact":
#   [1] "West Avenue"

is.object(obj) #TRUE
isS4(obj) #TRUE

# compare with S3:
is.object(s) #TRUE
isS4(s)   #FALSE

# Accessing the slot
# The slot can be accessed using the "@" instead of "$".
obj@name
obj@id
# Modifying the slot
obj@contact <- "North Avenue"
obj

# Creating your own Generic Method in S4
setMethod("show",
          "employee",
          function(object) {
            cat("Name:",object@name, "\n")
            cat("Id:",object@id, "\n")
            cat("Contact:", object@contact, "\n")
          }
)
obj
show(obj)

#List all generic functions
showMethods()
#check if a function is a generic function
isS4(print)
isS4(show)


class(show)
class(trigamma)
class(print)


# Defining reference class is similar to defining a S4 class. Instead of setClass() we use the setRefClass() function.

setRefClass("pupil")
setRefClass("pupil", fields = list(name = "character", age = "numeric", mark = "numeric"))
pupil <- setRefClass("pupil",
                       fields = list(name = "character", age = "numeric", mark = "numeric"))
# now pupil() is our generator function which can be used to create new objects
p <- pupil(name = "John", age = 18,mark = 9)
p
# Reference class object of class "pupil"
# Field "name":
#   [1] "John"
# Field "age":
#   [1] 18
# Field "mark":
#   [1] 9

p$name
p$name <- "Paul"
p
