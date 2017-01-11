#### if else

if(1>0) {
  ## do something
} 
## Continue with rest of code

if(1>0) {
  ## do something
} else {
  ## do something else
}


if(1>0) {
  ## do something
} else if(1>0)  {
  ## do something different
} else {
  ## do something different
}


#### for loop

numbers <- rnorm(10)

for(i in 1:10) {
  print(numbers[i])
}

for(i in numbers){
  print(i)
}

seq_along(numbers)



#### next & break
for(i in 1:10) {
  if(i <= 5) {
    ## Skip the first 20 iterations
    next                 
  }
  ## Do something here
  print(i)
}

for(i in 1:10) {
  print(i)
  
  if(i > 5) {
    ## Stop loop after 20 iterations
    break
  }     
}
