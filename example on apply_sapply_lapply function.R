my.matrx <- matrix(c(1:10, 11:20, 21:30), nrow = 10, ncol = 3)  
my.matrx
apply(my.matrx, 1, sum) # 1 -- вдоль строк


apply(my.matrx, 2, sample) # перемешивание, 2 -- вдоль столбцов


apply(my.matrx, 2, length)
apply(my.matrx, 2, function (x) length(x)-1)
st.err <- function(x){
  sd(x)/sqrt(length(x))
}
apply(my.matrx,2, st.err)

get_sample_numbers_from_long_vector <- function(x,y){
  sample(y,x)
}
apply(my.matrx, 2, get_sample_numbers_from_long_vector,y=3)

sample(10,3)

movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
str(movies_lower)
unlist(movies_lower)


# the apply function looks like this: apply(X, MARGIN, FUN).
# X is an array or matrix (this is the data that you will be performing the function on)
# Margin specifies whether you want to apply the function across rows (1) or columns (2)
# FUN is the function you want to use

# The easiest way to transform a loop into an lapply is to take what's inside your 
# for loop and plug it inside a function. Let's start with your inner loop.
NOUT = 4
foo_inner <- function(j) {
  F[i+NOUT*(j-1)] = Y[j]-YTR[i,j]
}
#There is one problem here though: your function should return a value instead of assigning it. In this case, you want to return Y[j]-YTR[i,j].

foo_inner <- function(j) {
  return(Y[j]-YTR[i,j])
}
#You can then simply apply this function to 1:NOUT. In this case, it seems 
# (though I can't be sure given the lack of info in your post) that 
# this return value is just a number so that you can create a vector directly instead of a list. In this case, 
# it is better to use sapply rather than lapply (the 's' stands for simplify (to a vector) while the 'l' means list):

sapply(1:NOUT, foo_inner)
#This new vector must now be assigned in your outer loop. From your code, it appears you want to assign this vector to F[i+NOUT*(1:NOUT-1)]. I simply replaced your j value by 1:NOUT which is your iterator. Your code snippet can therefore be modified like thus:
  
  for (i in 1:NTR) {
    X = as.vector(as.matrix(XTR[i,]))
    YZ = FN(W, V, U, X) # return Y and Z
    Y = YZ$Y
    Z = YZ$Z
    F[i+NOUT*(1:NOUT-1)] <- sapply(1:NOUT, foo_inner)
  } # i
#Let's tackle the outer loop now. As before, we can plug what's inside in a function:
  
  foo_outer <- function(i) {
    X = as.vector(as.matrix(XTR[i,]))
    YZ = FN(W, V, U, X) # return Y and Z
    Y = YZ$Y
    Z = YZ$Z
    F[i+NOUT*(1:NOUT-1)] <- sapply(1:NOUT, foo_inner)
  }
#There is here two problems to overcome: First, your foo_inner function takes i as parameter. But, foo_inner being defined outside foo_outer, it will always use the i defined in your environment and not the argument of foo_outer. There are two solutions to this: either define foo_inner inside foo_outer:
  
  foo_outer <- function(i) {
    X = as.vector(as.matrix(XTR[i,]))
    YZ = FN(W, V, U, X) # return Y and Z
    Y = YZ$Y
    Z = YZ$Z
    foo_inner <- function(j) {
      return(Y[j]-YTR[i,j])
    }
    F[i+NOUT*(1:NOUT-1)] <- sapply(1:NOUT, foo_inner)
  }
#Or, modify your foo_inner function so that it takes i as parameter and returns a correct function. You will then apply the function foo_inner(i) inside the inner sapply rather than foo_inner:
  
  foo_inner <- function(i) {
    function(j) {
      return(Y[j]-YTR[i,j])
    }
  }
foo_outer <- function(i) {
  X = as.vector(as.matrix(XTR[i,]))
  YZ = FN(W, V, U, X) # return Y and Z
  Y = YZ$Y
  Z = YZ$Z
  F[i+NOUT*(1:NOUT-1)] <- sapply(1:NOUT, foo_inner(i))
}
#The next modification to do is to ensure you want to return a value rather than doing an assignment inside your function:
  
  foo_inner <- function(i) {
    function(j) {
      return(Y[j]-YTR[i,j])
    }
  }
foo_outer <- function(i) {
  X = as.vector(as.matrix(XTR[i,]))
  YZ = FN(W, V, U, X) # return Y and Z
  Y = YZ$Y
  Z = YZ$Z
  return(sapply(1:NOUT, foo_inner(i)))
}
#You can now apply this function:
  
  lapply(1:NTR, foo_outer)
 # In this case, I used an lapply as each element returned will be a vector so I'd rather return a list and collapse it afterwards as I'm not sure if that's what sapply does in this case (and am too lazy to find out at the moment, I'll correct if someone can confirm this).

#So you want one big vector now, so I'll just collapse all that.

do.call(c, lapply(1:NTR, foo_outer))
#I can then just assign this value to F directly:

F <- do.call(c, lapply(1:NTR, foo_outer))
#Obviously, I can't ensure this is exactly what you wanted without knowing what F, YTR, Y and all your inputs are. But I hope it gets you started on the right path!
  
 # Edit: I think I created the wrong order for your final vector: with the above it will put all the "j" values for i= 1 then all the "j" values for i = 2... But looking back at your F, it looks like the order you want is for j=1 all the "i" values... To do this, You just have to rearrange the output of your second lapply. This hould work.

#I want to create a function that will get all j elements from the list:
  
  LL <- lapply(1:NTR, foo_outer)

  
  
  
  
  get_j_values <- function(j) {
  sapply(LL, function(x) x[[j]])
}
#For any j value, get_j_value returns in a vector all the jth element of LL. By applying this function to all possible j values, it returns a list with first element: all "i" values for j=1 then for the second element all "i" values for j=2...

LL2 <- lapply(1:NOUT, get_j_values)
#I can then collapse this list in one big vector and assign it.

F <- do.call(c, LL2)
#Edit 2: Although it is possible to work with apply functions to recreate your for loop, this might be one of these times where a for loop is actually better: there is no accumulation of result so the apply method shouldn't be faster and the for loop would be clearer I believe. This is usually the case when you are looping over indices that are used over several different objects so that you can't use an apply on any specific object directly but need to apply a function to a vector of indices... Just my two cents...  

