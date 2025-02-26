[Foundations of Data Science for High School]
Foundations of Data Science for High School
==========================================
author: Dr. Jeho Park
autosize: true



Git Setup
==========
__We will be using RStudio's Git/GitHub feature__

Instructor RStudio -------------------------------------------------> Student RStudio

Instructor RStudio --- push --> [GitHub Repo] --- pull --> Student RStudio


Today's Topics
==============
Chapter 4 and Chapter 5  

- R data objects: __vector, data frame, factor, function, and tibble__

- Data Wrangling (transformation)
  - Data Transformation with `dplyr`: __filter, arrange, select, mutate, group_by, summarise__ 
  - R's Logical Operators
  - Piping operator %>% 
  - Missing values
  - Summary functions

Basic R Objects: Vectors
========================================================
Vectors are array objects of the __same type__ data elements.


```r
class(a)  
class(A)
```

```r
b <- c(a,A) # concatenation
```

```r
print(b)
```

```r
class(b) # why?
```

Basic R Objects: Vectors (cont.)
========================================================
R has five basic or “atomic” classes of objects: 
* character
* numeric (real numbers) 
* integer
* complex
* logical (True/False)

A vector contains a set of data in any one of the atomic classes.

Basic R Objects: Data frames
========================================================
__Data frames are used for storing data tables as a collection of vectors of equal length.__  
  
__A data frame is a basic data object for this course!__


```r
n <- c(2, 3, 5) # a vector 
s <- c("aa", "bb", "cc") # a vector
b <- c(TRUE, FALSE, TRUE) # a vector 
df <- data.frame(n, s, b) # a data frame
df
mtcars # a built-in (attached) data frame
mtcars$mpg # notice this $ operator
```

Basic R Objects: Data frames (cont.)
========================================================
__Data frames are used for storing data tables__  
__It is a column-wide collection of vectors of equal length__.

<div align="center">
  <img src="images/df.png" width=300>
</div>

Basic R Objects: Data frames (cont.)
========================================================
__Data frames are used for storing data tables__  
__It is a column-wide collection of vectors of equal length__. 

```r
df1 <- data.frame(y1=rnorm(1000),y2=rnorm(1000), y3=rnorm(1000))
head(df1) # display first few lines of data
names(df1) # display column names
summary(df1) # output depends on the data types
plot(df1)
hist(df1$y1)
```


```r
df2 <- read.table("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.txt", header = FALSE)
df2
```

R Objects: Factor
========================================================
* Factors are a special compound object used to represent __categorical data__ such as gender(성별), nationality(국적), grades(성적), etc.
* Factors have 'levels' attribute. They may be nominal(이름뿐인/명목 척도) or ordinal(순위 척도).
* Remember the types of variables from Day 2? Factors are the R's implementation of quantitative variables.

```r
v <- c("a","b","c","c","b","d","f")
x <- factor(v) # turn the character vector into a factor object
z <- factor(v, ordered = TRUE) # ordered factor
x
z
table(x)
```

R Objects: Functions
=============================

```r
multiply <- function(a,b) {
  a*b
}

multiply   
multiply(2,3) # a function call
```

Tibbles
====================
Tibbles are data frames, but better!


```r
vignette("tibble")
```


```r
library("tidyverse") 
iris # data.frame
iris_tibble <- as_tibble(iris)
iris_tibble # tibble
```

Subsetting
===============


```r
tbbl <- tibble(
  x = runif(5),
  y = rnorm(5)
)
tbbl # A tibble: 5 x 2 
```

Subsetting operators: `$`, `[ ]`, and `[[ ]]` 


```r
tbbl$x
tbbl[1]
tbbl[[1]]
```


Variable and Object Naming Convention
===================
Find all that can be a variable (or object) name in R from the following:


```r
(1) 4wheelDrive   

(2) four_wheel_drive  

(3) fourWheelDrive  

(4) !my4wheeldrive  

(5) _4wheelDrive  

(6) Four.Wheel.Drive  
```

Session II: Data Wrangling
==============
## What is Data Wrangling?

<div align="center">
  <img src="images/wrangling-nat-geo.jpg" width=800>
</div>

Source: Wrangling Wild Horses in the Mountains of Montana (Director: Kristopher Rey-Talley) | Short Film Showcase | National Geographic Channel on Youtube (https://youtu.be/vkBtEe-lieU?t=131) | clip from 2:11 to 3:11

What is Data Wrangling?
=============================================
Data wrangling is the process of obtaining, cleaning, reshaping and transforming raw (and messy) data into a usable form of processed (and tidy) data.

![Data Wrangling](./images/Data_Wrangling_with_R.png)  
Source: "Data Wrangling with R" by Bradley C. Boehmke | Use R! Series


Data Transformation using dplyr package
======================
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
Let's use `nycflights13` dataset for our examples and hands-on practice.

If you don't have the `nycflights13` package, install it.


```r
library(nycflights13)
library(tidyverse)
```

We will be using `flights` data frame for our study. Try `?flights` to find out the details of the data set.

In the next sections, we will learn data manipulation functions from `dplyr` package.

Data Transformation: Filter rows with filter()
=============
Let's create a new data frame, `jan1`, containing only the flights on January 1st.


```r
jan1 <- filter(flights, month == 1, day == 1)
```


<div align="center">
dplyr::filter<br>
  <img src="images/filter.png" width=600>
</div>


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

[Hands-On 1] Filter and Logical Operators
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
__`arrange` sorts observations (rows) by a variable (column) in ascending order (오름차순)__


```r
temp <- arrange(flights, year, month, day)
```



[Hands-On 2] Arrange and find
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

<div align="center">
dplyr::select<br>
  <img src="images/select.png" width=600>
</div>

Helper Functions for Select
===========================
In real world datasets, a data frame may have hundreds or thousands of columns. And also in such cases, the column names may be coded with some pattern (e.g., TRD012021, TRD022021, etc.).

- `starts_with("abc")`: matches names that begin with “abc”.
- `ends_with("xyz")`: matches names that end with “xyz”.
- `contains("ijk")`: matches names that contain “ijk”.
- `num_range("x", 1:3)`: matches x1, x2 and x3.


>> Try `??'Selection language'` from your console to open a help doc about selection helper functions.


Piping using %>%
==========================================
- You can chain dplyr functions together using a special looking operator called a pipe operator: `%>%`
- The pipe operator feeds the resulting object into the 1st argument of the next function. 
- Keyboard shortcut is Shift-Cmd-M (for Mac) and Shift-Ctrl-M (for Windows)

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

Hands-On Exercise
=================
First, import "Births2015.csv" as `births2015` (follow instructions).

Answer the following questions:

1. What are the variables of `births2015` data.frame?
2. What is the total number of babies born in 2015?
3. How many babies were born on Wednesdays? (must use the pipe operator)
4. Which `date` had the least amount of babies born?



Session III: LAB2 (Chapter 5)
=============
Lab2_1.R
Lab2_2.R
Lab2_3.R








