####  This function will return a new function, which use the arguments provided
####  from the former one.

adder_maker <- function(n){
    function(x){
        n + x
    }
}

adder_maker(4)
adder_maker(4)(5)