<img src="http://cognitiveclass.ai/wp-content/uploads/2017/11/cc-logo-square.png" width="150">

<h1 align=center>LISTS and DATAFRAMES in R</h1> 


## Table of Contents

<div class="alert alert-block alert-info" style="margin-top: 20px">
<li><a href="#About-the-Dataset">About the Dataset</a></li>
<li><a href="#Lists">Lists</a></li>
<li><a href="#DataFrames">DataFrames</a></li>
<br>
<p></p>
Estimated Time Needed: <strong>15 min</strong>
</div>

<hr>


<a id="ref0"></a>

<center><h2>About the Dataset</h2></center>


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
    <br>

Part of the dataset can be seen below

<img src = "https://ibm.box.com/shared/static/6kr8sg0n6pc40zd1xn6hjhtvy3k7cmeq.png" align = "center">


<hr>


<a id="ref1"></a>

<center><h2>Lists</h2></center>

First of all, we're gonna take a look at lists in R. A list is a sequenced collection of different objects of R, like vectors, numbers, characters, other lists as well, and so on. You can consider a list as a container of correlated information, well structured and easy to read. A list accepts items of different types, but a vector (or a matrix, which is a multidimensional vector) doesn't. To create a list just type **list()** with your content inside the parenthesis and separated by commas. Let’s try it!



```R
movie <- list("Toy Story", 1995, c("Animation", "Adventure", "Comedy"))
```

In the code above, the variable movie contains a list of 3 objects, which are a string, a numeric value, and a vector of strings. Easy, eh? Now let's print the content of the list. We just need to call its name.



```R
movie
```

A list has a sequence and each element of a list has a position in that sequence, which starts from 1. If you look at our previous example, you can see that each element has its position represented by double square brackets "**\[[ ]]**".


### Accessing items in a list

It is possible to retrieve only a part of a list using the **single \_square** bracket operator\_ "**[ ]**". This operator can be also used to get a single element in a specific position. Take a look at the next example:


The index number 2 returns the second element of a list, if that element exists:



```R
movie[2]
```

Or you can select a part or interval of elements of a list. In our next example we are retrieving the 1st, 2nd, and 3rd elements:



```R
movie[2:3]
```

It looks a little confusing, but lists can also store names for its elements.


### Named lists

The following list is a named list:



```R
movie <- list(name = "Toy Story",
             year = 1995,
             genre = c("Animation", "Adventure", "Comedy"))
```

Let me explain that: the list **movie** has some named objects within it. **name**, for example, is an object of type **character**, **year** is an object of type **number**, and **genre** is a vector with objects of type **character**.

Now take a look at this list. This time, it's full of information and well organized. It's clear what each element means. You can see that the elements have different types, and that's ok because it's a list.



```R
movie
```

You can also get separated information from the list. You can use **listName\\$selectorName**. The _dollar-sign operator_ **$** will give you the block of data that is related to selectorName.

Let's get the genre part of our movies list, for example.



```R
movie$genre
```

Another way of selecting the genre column:



```R
movie["genre"]
```

You can also use numerical selectors like an array. Here we are selecting elements from 2 to 3.



```R
movie[2:3]
```

The function **class()** returns the type of a object. You can use that function to retrieve the type of specific elements of a list:



```R
class(movie$name)
class(movie$foreign)
```

### Adding, modifying, and removing items


Adding a new element is also very easy. The code below adds a new field named **age** and puts the numerical value 0 into it. In this case we use the double square brackets operator, because we are directly referencing a list member (and we want to change its content).



```R
movie[["age"]] <- 5
movie
```

In order to modify, you just need to reference a list member that already exists, then change its content.



```R
movie[["age"]] <- 6
# Now it's 6, not 5
movie
```

And removing is also easy! You just put **_NULL_**, which means missing value/data, into it.



```R
movie[["age"]] <- NULL
movie
```

### Concatenating lists

Concatenation is the proccess of puting things together, in sequence. And yes, you can do it with lists. Just call the function **_c()_**. Take a look at the next example:



```R
# We split our previous list in two sublists
movie_part1 <- list(name = "Toy Story")
movie_part2 <- list(year = 1995, genre = c("Animation", "Adventure", "Comedy"))

# Now we call the function c() to put everything together again
movie_concatenated <- c(movie_part1, movie_part2)

# Check it out
movie_concatenated
```

Lists are really handy for organizing different types of elements in R, and also easy to use. Additionally, lists are also important since this type of data structure is essential to create data frames, our next covered topic.


<hr>


<a id="ref2"></a>

<center><h2>DataFrames</h2></center>


A DataFrame is a structure that is used for storing data tables. Underneath it all, a data frame is a list of vectors of same length, exactly like a table (each vector is a column). We call a function called  **data.frame()** to create a data frame and pass vector, which are our columns, as arguments. It is required to name the columns that will compose the data frame.



```R
movies <- data.frame(name = c("Toy Story", "Akira", "The Breakfast Club", "The Artist",
                              "Modern Times", "Fight Club", "City of God", "The Untouchables"),
                    year = c(1995, 1998, 1985, 2011, 1936, 1999, 2002, 1987),
                    stringsAsFactors=F)
```

Let's print its content of our recently created data frame:



```R
movies
```

It's very easy! You can note how it looks like a table.

We can also use the **"$"** selector to get some type of information. This operator returns the content of a specific column of a data frame (that's why we have to choose a name for each column).



```R
movies$name
```

You retrieve data using numeric indexing, like in lists:



```R
# This returns the first (1st) column
movies[1]
```

The function called **str()** is one of most useful functions in R. With this function you can obtain textual information about an object. In this case,  it delivers information about the objects whitin a data frame. Let's see what it returns:



```R
str(movies)
```

It shouws this data frame has 8 observations, for 2 columns, so called **name** and **year**. The "name" column is a factor with 8 levels and "year" is a numerical column. 


The class() function works for data frames as well. You can use it to determine the type of a column of a data frame.



```R
class(movies$year)
```

You can use numerical selectors to reach information inside the table.



```R
movies[1,2] #1-Toy Story, 2-1995
```

The **_head()_** function is very useful when you have a large table and you need to take a peek at the first elements. This function returns the first 6 values of a data frame (or event a list).



```R
head(movies)
```

Similar to the previous function, **_tail()_** returns the last 6 values of a data frame or list.



```R
tail(movies)
```

Now let's try to add a new column to our data frame with the length of each movie in minutes.



```R
movies['length'] <- c(81, 125, 97, 100, 87, 139, 130, 119)
movies
```

A new column was included into our data frame with just one line of code. We just needed to add a vector to data frame, then it will be our new column.


Now let's try to add a new movie to our data set.



```R
movies <- rbind(movies, c(name="Dr. Strangelove", year=1964, length=94))
movies
```

Remember, you can't add a list with more variables than the data frame, and vice-versa.


We don't need this movie anymore, so let's delete it. Here we are deleting row 12 by assigning to itself the movies dataframe without the 12th row.



```R
movies <- movies[-12,]
movies
```

To delete a column you can just set it as **_NULL_**.



```R
movies[["length"]] <- NULL
movies
```

That is it! You learned a lot about data frames and how easy it is to work with them. 


<hr>


#### Scaling R with big data

As you learn more about R, if you are interested in exploring platforms that can help you run analyses at scale, you might want to sign up for a free account on [IBM Watson Studio](http://cocl.us/dsx_rp0101en), which allows you to run analyses in R with two Spark executors for free.


* * *


#### About the Author:

Hi! It's [Thiago Felipe Correa Borges](https://www.linkedin.com/in/thiago-felipe-corr%C3%AAa-borges-a932bb114?trk=nav_responsive_tab_profile&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ), the author of this notebook. I hope you found R easy to learn! There's lots more to learn about R but you're well on your way. Feel free to connect with me if you have any questions.

<hr>

Copyright © [IBM Cognitive Class](https://cognitiveclass.ai?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ). This notebook and its source code are released under the terms of the [MIT License](https://cognitiveclass.ai/mit-license?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ).

