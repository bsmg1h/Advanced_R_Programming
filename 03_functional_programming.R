library(purrr)

####  This function will return a new function, which use the arguments provided
####  from the former one.

adder_maker <- function(n){
    function(x){
        n + x
    }
}

adder_maker(4)
adder_maker(4)(5)


####  map function
map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
})

map_chr(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
})

map_dbl(1:5,function(x){
    6-x
})


##  map_if and map_at
map_if(1:5,function(x){
    x%%2 == 0
},function(y){
    y^2
}) %>% unlist

map_at(seq(100, 500, 100), c(1, 3, 5), function(x){
    x - 10
}) %>% unlist()

##  multivector
map2(map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
}),map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
}),paste
)

pmap(list(map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
}),map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
}),map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
}),map(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
})),function(a,b,c,d){
    paste(a,b,c,d,sep = ",")
})


#### reduce
reduce(1:5,function(x1,x2){
    x1+x2
})

reduce(1:5,function(x1,x2){
    message("x1 is",x1)
    message("x2 is",x2)
    x1+x2
})

#### Search: contains, detect, detect_index

x <- list(1:10, 5, 9.9)
x %>% contains(1:10)
x %>% contains(3)
x

detect(20:40, function(x){
    x > 22 && x %% 2 == 0
})

detect_index(20:40, function(x){
    x > 22 && x %% 2 == 0
})

#### Filter: keep, discard, every, some

keep(1:20, function(x){
    x %% 2 == 0
})

discard(1:20, function(x){
    x %% 2 == 0
})

every(1:20, function(x){
    x %% 2 == 0
})

some(1:20, function(x){
    x %% 2 == 0
})

#### Compose
n_unique <- compose(length, unique)
# The composition above is the same as:
# n_unique <- function(x){
#   length(unique(x))
# }

rep(1:5, 1:5)


n_unique(rep(1:5, 1:5))



#### partial application

mult_three_n <- function(x, y, z){
    x * y * z
}

mult_by_15 <- partial(mult_three_n, x = 3, y = 5)

mult_by_15(4)


#### Side effect: walk
walk(c("Friends, Romans, countrymen,",
       "lend me your ears;",
       "I come to bury Caesar,", 
       "not to praise him."), message)

#### recursion

Fibonacci_rec <- function(x){
    if(x == 1){
        0
    }else if(x == 2){
        1
    }else{
        Fibonacci_rec(x-1) + Fibonacci_rec(x-2)
    }
}

map_dbl(1:12,Fibonacci_rec)

fib_num <- c(0,1,rep(NA,23))
Fibonacci_rec_mem <- function(x){
    stopifnot(x >0)
    
    if(!is.na(fib_num[x])){
        fib_num[x]
    } else{
        fib_num[x-1] <<- Fibonacci_rec_mem(x-1)
        fib_num[x-2] <<- Fibonacci_rec_mem(x-2)
        fib_num[x-1] + fib_num[x-2]
    }
}

map_dbl(1:12,Fibonacci_rec_mem)


####which one is faster?
t <- Sys.time()
Fibonacci_rec(30)
Sys.time() - t

t <- Sys.time()
Fibonacci_rec_mem(30)
Sys.time() - t

library(microbenchmark)
library(magrittr)
library(tidyr)
library(dplyr)

fib_data <- map(1:10, function(x){microbenchmark(Fibonacci_rec(x), times = 100)$time})
names(fib_data) <- paste0(letters[1:10], 1:10)
fib_data <- as.data.frame(fib_data)

fib_data %<>%
    gather(num, time) %>%
    group_by(num) %>%
    summarise(med_time = median(time))

memo_data <- map(1:10, function(x){microbenchmark(Fibonacci_rec_mem(x))$time})
names(memo_data) <- paste0(letters[1:10], 1:10)
memo_data <- as.data.frame(memo_data)

memo_data %<>%
    gather(num, time) %>%
    group_by(num) %>%
    summarise(med_time = median(time))

plot(1:10, fib_data$med_time, xlab = "Fibonacci Number", ylab = "Median Time (Nanoseconds)",
     pch = 18, bty = "n", xaxt = "n", yaxt = "n")
axis(1, at = 1:10)
axis(2, at = seq(0, 350000, by = 50000))
points(1:10 + .1, memo_data$med_time, col = "blue", pch = 18)
legend(1, 100000, c("Not Memoized", "Memoized"), pch = 18, 
       col = c("black", "blue"), bty = "n", cex = 1, y.intersp = 1.5)
