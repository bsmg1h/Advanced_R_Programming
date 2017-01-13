####  create an expression and execute it
two_plus_two <- quote(2 + 2)
two_plus_two
eval(two_plus_two)

#### transform a string into an expression
# str = "2 + 2"
# exp = parse(text = str)
# eval(exp)
# eval(parse(text = str))
parse(text = "2+2")
eval(parse(text = "2+2"))

#### transform an expression into an string
deparse(two_plus_two)

#### modify an expression
sum_expr <- quote(sum(1, 5))
eval(sum_expr)

sum_expr[[1]]

sum_expr[[2]]

sum_expr[[3]]

sum_expr[[1]] <- quote(paste0)
sum_expr[[2]] <- quote(4)
sum_expr[[3]] <- quote(6)
eval(sum_expr)

#### compose the expressions using function
sum_40_50_expr <- call("sum", 40, 50)
sum_40_50_expr
sum(40, 50)
eval(sum_40_50_expr)


#### manipulate the arguments inside the functions
return_expression <- function(...){
    match.call()
}

return_expression(2, col = "blue", FALSE)

first_arg <- function(...){
    expr <- match.call()
    first_arg_expr <- expr[[2]]
    first_arg <- eval(first_arg_expr)
    if(is.numeric(first_arg)){
        paste("The first argument is", first_arg)
    } else {
        "The first argument is not numeric."
    }
}

first_arg(1,2,3,4)
first_arg("a","b")


#### set a new environment
my_new_env <- new.env()
my_new_env$x <- 4
my_new_env$x


assign("y", 9, envir = my_new_env)
get("y", envir = my_new_env)

my_new_env$y

#### observe the variables in the environment
ls(my_new_env)

rm(y, envir = my_new_env)
exists("y", envir = my_new_env)

exists("x", envir = my_new_env)

my_new_env$x

my_new_env$y

#### complex assignment operator: "<<-"
x <- 10
x

assign1 <- function(){
    x <<- "Wow!"
}

assign1()
x

