# Assignment: Lab3_2
# Student Name: 
# Date:

# Required packages
# Load all required packages below using the library() function.

## Your libraries start below this line

## Your libraries end before this line


# Ex 7.5.3.1: #2 (modified)
# Visualise the distribution of carat, partitioned by price.
# Divide the `price` variable into 10 groups or bins using `cut_number()` function on `price`.
# Hint: How can you change the code below to divide `price` into 10 groups?
example <- ggplot(diamonds, aes(x = price, y = carat)) +
    geom_boxplot() +
    coord_flip()

## Your code starts below this line

carat_by_price_10 <- 

## Your work ends before this line