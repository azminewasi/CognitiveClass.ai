<img src="http://cognitiveclass.ai/wp-content/uploads/2017/11/cc-logo-square.png" width="150">

<h1 align=center>ARRAYS & MATRICES</h1> 


## Table of Contents

<strong>This lesson will cover some basics concepts about vector and factors in R:</strong>

<ul>
- <p><a href="#What-is-an-Array?">What is an Array?</a></p>
- <p><a href="#Array-Indexing">Array Indexing</a></p>
- <p><a href="#What-is-a-Matrix?">What is a Matrix?</a></p>
- <p><a href="#Concatenation-Function">Concatenation Function</a></p>
<p></p>
</ul>
<br>

* * *


<a id="ref0"></a>

# About the Dataset

Imagine you got many movie recomendations from your friends and compiled all of the recomendations in a table, with specific info about each movie.

The table has one row for each movie and several columns

-   **name** - The name of the movie
-   **year** - The year the movie was released
-   **length_min** - The lenght of the movie in minutes
-   **genre** - The genre of the movie
-   **average_rating** - Average rating on Imdb
-   **cost_millions** - The movie's production cost in millions
-   **sequences** - The amount of sequences
-   **foreign** - Indicative of whether the movie is foreign (1) or domestic (0)
-   **age_restriction** - The age restriction for the movie
    <br>

You can see part of the dataset below

<img src = "https://ibm.box.com/shared/static/6kr8sg0n6pc40zd1xn6hjhtvy3k7cmeq.png" align = "center">


<h2>What is an Array?</h2>
<br>
An array is a structure that holds values grouped together, like a 2 x 2 table of 2 rows and 2 columns. Arrays can also be **multidimensional**, such as a 2 x 2 x 2 array.


#### What is the difference between an array and a vector?

Vectors are always one dimensional like a single row of data. On the other hand, an array can be multidimensional (stored as rows and columns). The "dimension" indicates how many rows of data there are.


#### Let's create a 4 x 3 array (4 rows, 3 columns)

The example below is a vector of 9 movie names, hence the data type is the same for all the elements.



```R
#lets first create a vector of nine movies
movie_vector <- c("Akira", "Toy Story", "Room", "The Wave", "Whiplash",
                  "Star Wars", "The Ring", "The Artist", "Jumanji")
movie_vector
```

To create an array, we can use the **array()** function.



```R
movie_array <- array(movie_vector, dim = c(4,3))
movie_array
```

Note that **arrays are created column-wise**. Did you also notice that there were only 9 movie names, but the array was 4 x 3? The original **vector doesn't have enough elements** to fill the entire array (that should have 3 x 4 = 12 elements). So R simply fills rest of the empty values by going back to the beginning of the vector and starting again ("Akira", "Toy story", "Room" in this case).


We also needed to provide **`c(4,3)`** as a second _argument_ to specify the number of rows (4) and columns (3) that we wanted.


<div class="alert alert-success alertsuccess" style="margin-top: 20px">
**[Tip] What is an "argument"? How are "arguments" different from "_parameters_"?**   
<br>
Arguments and parameters are terms you will hear constantly when talking about **functions**.  
- The _**parameters**_ are the input variables used in a function, like **dim** in the function **array()**.   
- The _**arguments**_ refer to the _values_ for those parameters that a function takes as inputs, like **c(4,3)**  
<br>
We actually don't need to write out the name of the parameter (dim) each time, as in:  
`array(movie_vector, c(4,3))`  
As long as we write the arguments out in the correct order, R can interpret the code.  

<br>
Arguments in a function may sometimes need to be of a **specific type**. For more information on each function, you can open up the help file by running the function name with a ? beforehand, as in:  
`?array`
<p></p>

</div>


<h2 align=center>Array Indexing</h2>


Let's look at our array again:



```R
movie_array
```

To access an element of an array, we should pass in **[row, column]** as the row and column number of that element.  
For example, here we retrieve **Whiplash** from row 1 and column 2:



```R
movie_array[1,2] #[row, column]
```

To display all the elements of the first row, we should put 1 in the row and nothing in the column part. Be sure to keep in the comma after the `1`.



```R
movie_array[1,]
```

Likewise, you can get the elements by column as below.



```R
movie_array[,2]
```

To get the dimension of the array, **dim()** should be used.



```R
dim(movie_array)
```

We can also do math on arrays. Let's create an array of the lengths of each of the nine movies used earlier.



```R
length_vector <- c(125, 81, 118, 81, 106, 121, 95, 100, 104)
length_array <- array(length_vector, dim = c(3,3))
length_array
```

Let's add 5 to the array, to account for a 5-min bathroom break:



```R
length_array + 5
```

<div class="alert alert-success alertsuccess" style="margin-top: 20px">
**Tip**: Performing operations on objects, like adding 5 to an array, does not change the object. **To change the object, we would need to assign the new result to itself**.
</div>


<a id="ref3"></a>

<h2 align=center>Using Logical Conditions to Subset Arrays</h2>


Which movies can I finish watching in two hours? Using a logical condition, we can check which movies are less than 2 hours long.



```R
mask_array <- length_array > 120
mask_array
```

Using this array of TRUEs and FALSEs, we can subset the array of movie names:



```R
x_vector <- c("Akira", "Toy Story", "Room", "The Wave", "Whiplash",
              "Star Wars", "The Ring", "The Artist", "Jumanji")
x_array <- array(x_vector, dim = c(3,3))

x_array[mask_array]
```

<h2 align=center>What is a Matrix?</h2>

Matrices are a subtype of arrays. A matrix **must** have 2 dimensions, whereas arrays are more flexible and can have, 1, 2 or more dimensions.  

To create a matrix out of a vector , you can use **matrix()**, which takes in an argument for the vector, an argument for the number of rows and another for the number of columns.



```R
movie_matrix <- matrix(movie_vector, nrow = 3, ncol = 3)
```


```R
movie_matrix
```

### Accessing elements of a matrix


As with arrays, you can use **[row, column]** to access elements of a matrix. To retrieve "Akira", you should use [1,1] as it lies in the first row and first column.



```R
movie_matrix[1,1]
```

To get data from a certain range, the folowing code can help. This takes the elements from rows 2 to 3, and from columns 1 to 2.



```R
movie_matrix[2:3, 1:2]
```

<h2>Concatenation function</h2>

A concatenation function is used to combine two vectors into one vector. It combines values of both vectors.<br>
Lets create a new vector for the upcoming movies as upcoming_movie and add them to the movie_vector to create a new_vector of movies.



```R
upcoming_movie <- c("Fast and Furious 8", "xXx: Return of Xander Cage", "Suicide Squad")
```


```R
new_vector <- c(movie_vector, upcoming_movie)
```


```R
new_vector
```

<hr>
#### Scaling R with big data

As you learn more about R, if you are interested in exploring platforms that can help you run analyses at scale, you might want to sign up for a free account on [IBM Watson Studio](http://cocl.us/dsx_rp0101en), which allows you to run analyses in R with two Spark executors for free.


<hr>
### About the Author:  
Hi! It's [Hiten Patel](https://ca.linkedin.com/in/hitenpatel161289), the author of this notebook. I hope you found arrays and matrices easy to learn! As you start learning the foundations of R, feel free to connect with me if you have any questions.
<hr>

Copyright ?? [IBM Cognitive Class](https://cognitiveclass.ai?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ). This notebook and its source code are released under the terms of the [MIT License](https://cognitiveclass.ai/mit-license?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ).

