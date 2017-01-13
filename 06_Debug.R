####  traceback

check_n_value <- function(n) {
    if(n > 0) {
        stop("n should be <= 0")
    }
}
error_if_n_is_greater_than_zero <- function(n){
    check_n_value(n)
    n
}
error_if_n_is_greater_than_zero(5)


traceback()

#### browser

check_n_value <- function(n) {
    if(n > 0) {
        a=0
        b=0
        browser()  ## Error occurs around here
        stop("n should be <= 0")
    }
}
error_if_n_is_greater_than_zero(5)

#### use trace when it is not easy to access the source cod
trace("check_n_value")
error_if_n_is_greater_than_zero(5)