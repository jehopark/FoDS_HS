[Foundations of Data Science with Capstone at SMU, Summer 2021]
Day 5: Data Wrangling (2)
========================================================
author: Dr. Jeho Park
date: 
autosize: true



DAY4 and LAB4 Review
========================================================

- Day4 Quiz

Any questions?



Today's Topics
==============
## Data Transformation: 
- Pick observations by their values (filter()).
- Reorder the rows (arrange()).
- Pick variables by their names (select()).
- Create new variables with functions of existing variables (mutate()).
- Collapse many values down to a single summary (summarise()).
- Group by group operations (group_by())
  
  
## Essentials for Data Transformation:
- Boolean Operator in R
- Piping, Missing values, Summary functions


Data Transformation
====================
Let's use nycflights dataset for our examples and hands-on practice.

If you don't have the `nycflights13` package, install it.


```r
library(nycflights13)
library(tidyverse)
```

Try `?nycflights13` to find out the details of the dataset.

In the next sections, we will learn data manipulation functions from `dplyr` package.

Data Transformation: Filter rows with filter()
=============
Let's create a new data frame, `jan1`, containing only the flights on January 1st.


```r
jan1 <- filter(flights, month == 1, day == 1)
```

Notice assignment operator (<-) and comparison operator (==)

Comparison and Logical Operators in R
=================================

Comparison Operators

| Operator | Description              |
|----------|--------------------------|
| <        | Less than                |
| >        | Greater than             |
| <=       | Less than or equal to    |
| >=       | Greater than or equal to |
| ==       | Equal to                 |
| !=       | Not equal to             |

------------------
Logical Operators

| Operator | Description              |
|----------|--------------------------|
| !        | Logical NOT              |
| &        | Element-wise logical AND |
| &&       | Logical AND              |
| |         | Element-wise logical OR  |
| ||         | Logical OR               |
| xor(x,y) | Exclusive OR             |

TRUE or FALSE
===============

```r
# Logical Operators in R
5 < 2
(5 < 2) & (3 > 2)
(5 < 2) | (3 > 2)
5 %in% c(1,2,3,4,5)
is.na(c(1,2,NA,4,5))
```


```r
# vectorized (element-wise) operator
x <- c(TRUE, FALSE, FALSE)
y <- c(TRUE, TRUE, FALSE)
x & y   # returns a logical vector
x && y  # returns a Boolean value
```

Boolean Operators
=================

![Boolean](./images/transform-logical.png)

[Hands-On] Filter and Logical Operators
==============

1. Find all flights that departed in November or December.

1. Find all flights that weren’t delayed (on arrival or departure) by more than two hours

Missing Values and Comparison/Logical Operations
========================
It is important to remember that the results of any operations on rows with `NA` values will be unknown (NA) as well.


```r
NA > 5
#> [1] NA
10 == NA
#> [1] NA
NA + 10
#> [1] NA
NA / 2
#> [1] NA
```


Data Transformation: Arrange rows with arrange()
==================
__`arrange` sorts observations (rows) by a variable (column) in ascending order__


```r
temp <- arrange(flights, year, month, day)
```

[Hands-on] Arrange and find
=================

1. Sort `flights` to find the most delayed flights. Find the flights that left earliest.

1. Which flights traveled the farthest? Which traveled the shortest?

Data Transformation: Select columns with select()
==================
__`select` extract_ (subsets) only the variables (columns) that you choose__


```r
# Select columns by name
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
select(flights, year:day)

# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
```

Helper Functions for Select
===========================
In real world datasets, a data frame may have hundreds or thousands of columns. And also in such cases, the column names may be coded with some pattern (e.g., TRD012021, TRD022021, etc.).

- `starts_with("abc")`: matches names that begin with “abc”.
- `ends_with("xyz")`: matches names that end with “xyz”.
- `contains("ijk")`: matches names that contain “ijk”.
- `matches("(.)\\1")`: selects variables that match a regular expression. This one matches any variables that contain repeated characters. You’ll learn more about regular expressions in strings.
- `num_range("x", 1:3)`: matches x1, x2 and x3.
- `everything()`: matches all variables (it could be "everything else" if used with a combination of other variables)

>> Try `??'Selection language'` from your console to open a help doc about selection helper functions.


[Hands-On] Breakout Session
===============
1. Select `dep_time`, `sched_dep_time`, `dep_delay`, `arr_time`, `sched_arr_time`, and `arr_delay` from flights and save the subset as `flights_time`. (Brainstorm how you can do this.)

2. Arrange `flights_time` by `dep_delay` in descending order and then by `arr_delay` in descending order. Save this sorted data frame back to `flights_time`

3. Make an one-liner code for the two steps (#1 and #2 above). Use nested function calls. 

Piping using %>%
==========================================
- You can chain dplyr functions together using a special looking operator called a pipe operator: `%>%`
- The pipe operator feeds the resulting object into the 1st argument of the next function. 
- Keyboard shortcut is Shift-Cmd-M (for Mac) and ? (for Windows)

[Breakout] Nested calls vs. Piping
===================================================
__Discuss which code snippet is more readable: (1) nested function calls vs. (2) piping.__


```r
# Nested function calls
flights_time1 <- 
  arrange(
    select(flights, contains(c("dep_","arr_"))), 
    desc(dep_delay), desc(arr_delay)
  )
```


```r
# Piping
flights_time2 <- 
  flights %>%  
  select(contains(c("dep_","arr_"))) %>% 
  arrange(desc(dep_delay), desc(arr_delay))
```

When not to use pipes
=====================
- When your pipes are too long (In this case, it does not help code clarity or readability)
- When you have multiple inputs or outputs. (It is good for one data frame as an input.)
- When you have to use a directed graph with a complex dependency structure. (Pipes are essentially good for a step-by-step progress of code execution.)



Data Transformation: Add new variables with mutate()
==================
__`mutate` creates new variables based on some calculations using other variables__  
__The newly created variables (columns) are added to the end of the data frame.__


```r
starwars_mass <- 
  starwars %>% 
  select(name, mass) %>% 
  mutate(mass2 = mass * 2, mass2_squared = mass2 * mass2)
starwars_mass
```

- `transmute` creates a new data frame containing only the new variables.

```r
starwars_mass2 <- 
  starwars %>% 
  select(name, mass) %>% 
  transmute(mass2 = mass * 2, mass2_squared = mass2 * mass2)
starwars_mass2
```

Data Transformation: Grouped summaries with summarise() and group_by()
=======================
__`summarise` applies a summary function (e.g., mean, sum, etc.) and returns a result.__   


```r
flights %>% 
  summarise(delay = mean(dep_delay, na.rm = TRUE))
```

__Use `summarise` and `group_by` together to create grouped summaries__  

The following R code generates a data frame, `daily_dep_delay`, containing average daily departure delays.


```r
daily_dep_delay <- 
  flights %>% 
  group_by(year, month, day) %>% 
  summarise(delay = mean(dep_delay, na.rm = TRUE))
daily_dep_delay # Any issue?
```

(Discuss: *Why the NA's for delay?*)

Missing Values
================
__It is very important to correctly treat missing values in your datasets.__

__Especially, when you use aggregation functions (mean, sum, n, etc.) and if there’s any missing value in the input dataset, the output will be a missing value (NA)__


```r
x <- c(1, 2, 3, NA, 5)
sum(x)
```

[Hands-On] Find the most delayed plane on average for arrivals
================
1. Remove rows having NA in `dep_delay` and `arr_delay` (The results will be a data frame with no canceled flights.) 

2. Save the filtered data frame as `not_canceled` 

3. Summarise the `not_canceld` data frame by average arrival delay (`arr_delay`), grouped by plane (`tailnum`)

4. Find the plane (identified by it tail number) that have the highest average arrival delay and report how long it delayed its arrivals on average.

Useful summary functions
==================
Summary functions return a single (aggregated) value. We have seen `sum()`, `mean()`, and `n()` for calculating sum, average, and count respectively.

__Measures of Location__

- `median()` is useful to find an observation at the middle when all the obs are sorted from smallest to largest.


```r
x <- c(10, 5, 2, 4, 3, 9, 6, 7, 8, 1, 0)
median(x)
```

__Measures of Spread__

- `sd()` (standard deviation) is useful to see how much the values of the observations are spread around the average

__Measures of Rank__

- `min()`, `quantile(x, 0.25)`, `max()` are useful to find minimum, quantile, and maximum respectively.

- `quantile(x, 0.25)`, will find a value of a vector, x, that is greater than 25% of the observations and less than 75% of the observations. We read it as 0.25-quantile which is the same meaning as 25th percentile. 



LAB5
=============
- 5.2.4: #1
- 5.3.1 #1, #3
- 5.4.1 #2, #3
- 5.5.2 #5
- 5.6.7 #5

