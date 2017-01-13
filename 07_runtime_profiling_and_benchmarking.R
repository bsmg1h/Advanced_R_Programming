#### microbenchmark

library(microbenchmark)
library(dplyr)

microbenchmark(a <- rnorm(1000), 
               b <- mean(rnorm(1000)))

## examples:
# function1

find_records_1 <- function(datafr, threshold){
    highest_temp <- c()
    record_temp <- c()
    for(i in 1:nrow(datafr)){
        highest_temp <- max(highest_temp, datafr$temp[i])
        record_temp[i] <- datafr$temp[i] >= threshold & 
            datafr$temp[i] >= highest_temp
    }
    datafr <- cbind(datafr, record_temp)
    return(datafr)
}

# function2
find_records_2 <- function(datafr, threshold){
    datafr <- datafr %>% 
        mutate_(overthreshold = ~ temp >= threshold,
               cummax_temp = ~ temp == cummax(temp),
               record_temp = ~ overthreshold & cummax_temp) %>% 
        select_(.dots = c("-overthreshold", "-cummax_temp"))
    return(as.data.frame(datafr))
}

# compairison on a small dataset
example_data <- data_frame(date = c("2015-07-01", "2015-07-02",
                                    "2015-07-03", "2015-07-04",
                                    "2015-07-05", "2015-07-06",
                                    "2015-07-07", "2015-07-08"),
                           temp = c(26.5, 27.2, 28.0, 26.9, 
                                    27.5, 25.9, 28.0, 28.2))

(test_1 <- find_records_1(example_data, 27))
(test_2 <- find_records_2(example_data, 27))

record_temp_perf <- microbenchmark(find_records_1(example_data, 27), 
                                   find_records_2(example_data, 27))
record_temp_perf

# compairison on a large dataset

library(dlnm)
data("chicagoNMMAPS")

record_temp_perf_2 <- microbenchmark(find_records_1(chicagoNMMAPS, 27), 
                                     find_records_2(chicagoNMMAPS, 27))
record_temp_perf_2

# plot for small dataset
library(ggplot2)
autoplot(record_temp_perf)
autoplot(record_temp_perf2)



#### profvis to detect how much time each step costs
library(profvis)
datafr <- chicagoNMMAPS
threshold <- 27

profvis({
    highest_temp <- c()
    record_temp <- c()
    for(i in 1:nrow(datafr)){
        highest_temp <- max(highest_temp, datafr$temp[i])
        record_temp[i] <- datafr$temp[i] >= threshold & 
            datafr$temp[i] >= highest_temp
    }
    datafr <- cbind(datafr, record_temp) 
})

profvis({
    datafr <- datafr %>% 
        mutate_(overthreshold = ~ temp >= threshold,
                cummax_temp = ~ temp == cummax(temp),
                record_temp = ~ overthreshold & cummax_temp) %>% 
        select_(.dots = c("-overthreshold", "-cummax_temp"))
    a <- as.data.frame(datafr)
    highest_temp <- c()
    record_temp <- c()
    for(i in 1:nrow(datafr)){
        highest_temp <- max(highest_temp, datafr$temp[i])
        record_temp[i] <- datafr$temp[i] >= threshold & 
            datafr$temp[i] >= highest_temp
    }
    datafr <- cbind(datafr, record_temp) 
})
