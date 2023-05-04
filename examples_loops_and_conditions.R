#condition
if (10 < 2) {
  print("yes")
} else{
  "no"
}
# condition,another format
x = 10
ifelse(x < 5 | x > 8, x)

#loop for
for (i in 1:10) {
  print(i)
}
#loop for and condition
for (i in 1:10) {
  if ((i + 5) < 8) {
    print(i)
  }
}
#loop while
i = 0
while (i < 5) {
  print(i)
  i = i + 1
}

#loop repeat{next..break}
repeat {
  g <- rnorm(1)
  print(g)
  if (g < 0)
    next
  if (g > 1.0)
    break
  print(g)
}

