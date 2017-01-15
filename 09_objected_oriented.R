#### S3 object

class(2)
class("is in session.")
class(class)

special_num_1 <- structure(1, class = "special_number")
class(special_num_1)

special_num_2 <- 2
class(special_num_2)
class(special_num_2) <- "special_number"
class(special_num_2)

shape_s3 <- function(side_lengths){
    structure(list(side_lengths = side_lengths), class = "shape_S3")
}

square_4 <- shape_s3(c(4,4,4,4))
class(square_4)

triangle_3 <- shape_s3(c(3,3,3))
class(triangle_3)

#### method
mean(c(2,3,7))
mean(c(as.Date("2016-09-01"),as.Date("2016-09-06")))

is_square <- function(x) UseMethod("is_square")
is_square.shape_S3 <- function(x){
    length(x$side_lengths) == 4 &&
        x$side_lengths[1] == x$side_lengths[2] &&
        x$side_lengths[2] == x$side_lengths[3] &&
        x$side_lengths[3] == x$side_lengths[4]
}
is_square.default <- function(x){
    NA
}

is_square(square_4)
is_square(triangle_3)
is_square("abc")



is_square(square_4)
is_square(triangle_3)
is_square("abc")

# define another method for "print"
print(square_4)

print.shape_S3 <- function(x){
    if(length(x$side_lengths) == 3){
        cat(sprintf("This object is an triangle.\n"))
        sprintf("The side lengths are %f %f and %f",x$side_lengths[1],
                x$side_lengths[2],x$side_lengths[3])
    } else if(length(x$side_lengths) == 4){
        if(is_square(x)){
            cat(sprintf("This object is an square.\n"))
            sprintf("The side lengths are %f %f %f and %f",x$side_lengths[1],
                    x$side_lengths[2],x$side_lengths[3],x$side_lengths[4])
        } else{
            cat(sprintf("This object is a quadrilateral.\n"))
            sprintf("The side lengths are %f %f %f and %f",x$side_lengths[1],
                    x$side_lengths[2],x$side_lengths[3],x$side_lengths[4])
        }
    } else{
        sprintf("This a shape with %s sides.",length(x$side_lengths))
    }
}

print(square_4)
print(triangle_3)
print(shape_s3(c(5,5,5,5,5)))
print(shape_s3(c(2,3,4,5)))


#### inherit
class(square_4) <- c("shape_S3", "square")
class(square_4)



#### example: polygon
## Constructor function for polygon objects
## x a numeric vector of x coordinates
## y a numeric vector of y coordinates
make_poly <- function(x, y) {
    if(length(x) != length(y))
        stop("'x' and 'y' should be the same length")
    
    ## Create the "polygon" object 
    object <- list(xcoord = x, ycoord = y)
    
    ## Set the class name
    class(object) <- "polygon"
    object
}

## Print method for polygon objects
## x an object of class "polygon"
print.polygon <- function(x, ...) {
    cat("a polygon with", length(x$xcoord), 
        "vertices\n")
    invisible(x)
}

## Summary method for polygon objects
## object an object of class "polygon"

summary.polygon <- function(object, ...) {
    object <- list(rng.x = range(object$xcoord),
                   rng.y = range(object$ycoord))
    class(object) <- "summary_polygon"
    object
}

## Print method for summary.polygon objects
## x an object of class "summary_polygon"
print.summary_polygon <- function(x, ...) {
    cat("x:", x$rng.x[1], "-->", x$rng.x[2], "\n")
    cat("y:", x$rng.y[1], "-->", x$rng.y[2], "\n")
    invisible(x)
}