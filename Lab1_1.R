# Lab1
## Required packages
library('ggplot2')

# Ex 3.2.4: #4 (modified)
# Using the mpg data, make a scatterplot of hwy vs cyl
## Your code starts below this line
p <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))
## Your work ends before this line

