[Foundations of Data Science with Capstone at SMU, Summer 2021]
Day 4: Data Wrangling (1)
========================================================
author: Dr. Jeho Park
date: 
autosize: true



LAB3 Exercises
========================================================

__Before we move on to learn data wrangling methods, please take Day 2 quiz and Day 3 quiz now.__

__Let's do a couple of Lab3 exercises__

Git Setup
==========
__We will be using RStudio's Git/GitHub feature__

Instructor RStudio -------------------------------------------------> Student RStudio

Instructor RStudio --- push --> [GitHub Repo] --- pull --> Student RStudio

(1) Download and install git on your computer: https://git-scm.com/downloads  
(2) Restart RStudio   
(3) Go to your preference and check if RStudio has the git installation information.  
(4) Create a new project with a GitHub repo attached to it. (Follow instructions)



Today's Topics
==============
- Basic R Information
- Basic R Objects
- Working with Data:  
  - Built-in Data,  
  - Data Import, 
  - Data Exploration
- R Notebook
- Data Transformation with `dplyr`: filter
- R's Logical Operators

What Can We Do with R? Math (of course!)
========================================================

```r
1+1
```


```r
2+runif(1,min=0,max=1)
```


```r
3^2
```


```r
3*3
```


```r
sqrt(3*3) # square root function
```


```r
# comments are preceded by hash sign sqrt(3*3)
```


Some R Vocabulary
========================================================
* **packages** are add on features to R  include data, new functions and methods, and extended capabilities. Think of them as `apps` on your phone. We've already installed several!
* **console** is the main window of R where you enter commands
* **workspace** is the working memory of R where all objects are stored
* **script** is where you store commands to be run in the terminal later, like syntax files in SPSS, .do files in Stata, and py files in Python.
* **function** is a set of commands doing something to R object(s) by getting inputs, do work, and return outputs. 

Some Gene-R-al Stuff
========================================================

```r
demo() # display available demos
```

```r
demo(graphics) # try graphics demo
```

```r
library() # show available packages on the computer
```

```r
?hist # search for the usage of hist function
```


```r
??histogram # search for package documents containing the word "histogram"
```

Workspace of R
========================================================

R workspace stores objects like vectors, datasets and functions in memory (the available space for calculation is limited to the size of the RAM).


```r
a <- 5 # notice a in your Environment window
```


```r
A <- "text" 
```


```r
a
A
ls()
print(c(a,A)) # Guess what the c stands for 
print(a,A)
```

Basic R Objects: Vectors
========================================================
Vectors are array objects of the __same type__ data elements.


```r
class(a)
```

```r
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
mtcars$mpg # notice this new $ operator
```

Basic R Objects: Data frames (cont.)
========================================================
__Data frames are used for storing data tables__  
__It is a column-wide collection of vectors of equal length__. 

```r
df1 <- data.frame(y1=rnorm(100),y2=rnorm(100), y3=rnorm(100))
head(df1) # display first few lines of data
names(df1) # display column names
summary(df1) # output depends on the data types
plot(df1)
```


```r
df2 <- read.table("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.txt", header = FALSE)
df2
```

R Objects: Factor
========================================================
* Factors are a special compound object used to represent __categorical data__ such as gender, social class, etc.
* Factors have 'levels' attribute. They may be nominal or ordinal.
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
fun <- function(a,b) {
  a*b
}

fun   
fun(2,3) # a function call
```

Variable and Object Naming Convention
===================
Find all that can be a variable (or object) name in R from the following:


```r
4wheelDrive   

four_wheel_drive  

fourWheelDrive  

!my4wheeldrive  

_4wheelDrive  

Four.Wheel.Drive  
```
What is Data Wrangling?
======================================

Source: Wrangling Wild Horses in the Mountains of Montana (Director: Kristopher Rey-Talley) | Short Film Showcase | National Geographic Channel on Youtube (https://youtu.be/vkBtEe-lieU?t=131) | clip from 2:11 to 3:11

What is Data Wrangling?
=============================================
Data wrangling is the process of obtaining, cleaning, reshaping and transforming raw (and messy) data into a usable form of processed (and tidy) data.

![Data Wrangling](./data-wrangling-figure/Data_Wrangling_with_R.png)  
Source: "Data Wrangling with R" by Bradley C. Boehmke | Use R! Series

Working with Data
========================================================
* Built-in datasets and basic data import
* Quick data exploration with summary
* Hands-on exercise

Built-in Datasets 
========================================================
- R's datasets package has some built in datasets that we will be using.

```r
data() # this will bring up a document, R data sets
```

- Let's look at CO2 datasets. The CO2 data frame has 84 rows and 5 columns of data from an experiment on the cold tolerance of the grass species Echinochloa crus-galli.

```r
help(CO2) # see what the dataset is about
CO2 # display all the contents of the data frame, CO2
```

__Notice there's no CO2 dataframe in the Environment pane__

Data Import
========================================================
__Data file import is very easy with RStudio__

Follow the instructor and import "auto.csv" file!

Click-click-click-done!

Check if you have *Births2015* in your Environment.

[Lab4] Data Exploration - Head or Tail?
========================================================
When you have a large dataset, it's impossible and inconvenient to display the whole contents of the dataset on the screen. You will want to check the first few rows or the last few rows of the dataset. 

In this exercise, you will create a Code Chunk in a new Notebook and do the following:  
(1) Import "Births2015.csv" as Births2015  
(2) Output the first row of Births2015 using R's built-in function  
(3) Output the last row of Births2015 using R's built-in function  



