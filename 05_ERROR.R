
#### generate an error
# stop("Something erroneous has occurred!")

# name_of_function <- function(){
#     stop("Something bad happened.")
# }
# 
# name_of_function()

#### generate a warning

warning("Consider yourself warned!")

#### generate a message
message("In a bottle.")


#### tryCatch
is_even_error <- function(n){
    tryCatch(n %% 2 == 0,
             error = function(e){
                 FALSE
             })
}

is_even_error(714)

is_even_error("eight")

#### try to  limit the number of errors program generates as much as possible
is_even_check <- function(n){
    is.numeric(n) && n %% 2 == 0
}

is_even_check(1876)


is_even_check("twelve")

library(microbenchmark)
microbenchmark(sapply(letters, is_even_check))
microbenchmark(sapply(letters, is_even_error))

