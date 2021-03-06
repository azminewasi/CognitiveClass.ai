<img src="http://cognitiveclass.ai/wp-content/uploads/2017/11/cc-logo-square.png" width="150">

<h1 align=center>R BASICS</h1> 


### Welcome!

By the end of this notebook, you will have learned the basics of R!  


## Table of Contents

<ul>
<li><a href="#About-the-Dataset">About the Dataset</a></li>
<li><a href="#Simple-Math-in-R">Simple Math in R</a></li>
<li><a href="#Variables-in-R">Variables in R</a></li>
<li><a href="#Vectors-in-R">Vectors in R</a></li>
<li><a href="#Strings-in-R">Strings in R</a></li>
</ul>
<p></p>
Estimated Time Needed: <strong>15 min</strong>

<hr>


<a id="ref0"></a>

<h2 align=center>About the Dataset</h2>


Which movie should you watch next? 

Let's say each of your friends tells you their favorite movies. You do some research on the movies and put it all into a table. Now you can begin exploring the dataset, and asking questions about the movies. For example, you can check if movies from some certain genres tend to get better ratings. You can check how the production cost for movies changes across years, and much more. 


**Movies dataset**

The table gathered includes one row for each movie, with several columns for each movie characteristic:

-   **name** - Name of the movie
-   **year** - Year the movie was released
-   **length_min** - Length of the movie (minutes)
-   **genre** - Genre of the movie
-   **average_rating** - Average rating on [IMDB](http://www.imdb.com?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)
-   **cost_millions** - Movie's production cost (millions in USD)
-   **foreign** - Is the movie foreign (1) or domestic (0)?
-   **age_restriction** - Age restriction for the movie
    <br>


<img src = "https://ibm.box.com/shared/static/6kr8sg0n6pc40zd1xn6hjhtvy3k7cmeq.png" width = 90% align="left">


### We can use R to help us explore the dataset

But to begin, we'll need to start from the basics, so let's get started!


<hr>


<a id="ref1"></a>

<h2 align=center> Simple Math in R </h2>


Let's say you want to watch _Fight Club_ and _Star Wars: Episode IV (1977)_, back-to-back. Do you have enough time to **watch both movies in 4 hours?** Let's try using simple math in R.  


What is the **total movie length** for Fight Club and Star Wars (1977)?

-   **Fight Club**: 139 min
-   **Star Wars: Episode IV**: 121 min


<div class="alert alert-success alertsuccess" style="margin-top: 20px">
**Tip**: To run the grey code cell below, click on it, and press Shift + Enter.
</div>



```R
139 + 121 
```

Great! You've determined that the total number of movie play time is **260 min**.  


**What is 260 min in hours?**



```R
260 / 60
```

Well, it looks like it's **over 4 hours**, which means you can't watch _Fight Club_ and _Star Wars (1977)_ back-to-back if you only have 4 hours available!


<hr></hr>
<div class="alert alert-success alertsuccess" style="margin-top: 20px">
<h4> [Tip] Simple math in R </h4>
<p></p>
You can do a variety of mathematical operations in R including:  
<li> addition: **2 + 2** </li>
<li> subtraction: **5 - 2** </li>
<li> multiplication: **3 \* 2** </li>
<li> division: **4 / 2** </li>
<li> exponentiation: **4 \*\* 2** or **4 ^ 2 **</li>
</div>
<hr></hr>


<a id="ref2"></a>

<h2 align=center> Variables in R </h2>


We can also **store** our output in **variables**, so we can use them later on. For example:



```R
x <- 139 + 121
```

To return the value of **`x`**, we can simply run the variable as a command:



```R
x
```

We can also perform operations on **`x`** and save the result to a **new variable**:



```R
y <- x / 60
y
```

If we save something to an **existing variable**, it will **overwrite** the previous value:



```R
x <- x / 60
x
```

It's good practice to use **meaningful variable names**, so you don't have to keep track of what variable is what:



```R
total <- 139 + 121
total
```


```R
total_hr <- total / 60
total_hr
```

You can put this all into a single expression, but remember to use **round brackets** to add together the movie lengths first, before dividing by 60.



```R
total_hr <- (139 + 121) / 60
total_hr
```

<hr></hr>
<div class="alert alert-success alertsuccess" style="margin-top: 0px">
<h4> [Tip] Variables in R </h4>
<p></p>
As you just learned, you can use **variables** to store values for repeated use. Here are some more **characteristics of variables in R**:
<li>variables store the output of a block of code </li>
<li>variables are typically assigned using **<-**, but can also be assigned using **=**, as in **x <- 1** or **x = 1** </li>
<li>once created, variables can be removed from memory using **rm(**my_variable**)**  </li>
<p></p>
</div>
<hr></hr>


<a id="ref3"></a>

<h2 align=center>Vectors in R</h2>


What if we want to know the **movie length in _hours_**, not minutes, for _Toy Story_ and for _Akira_?

-   **Toy Story (1995)**: 81 min
-   **Akira (1998)**: 125 min



```R
c(81, 125) / 60
```

As you see above, we've applied a single math operation to both of the items in **`c(81, 125)`**. You can even assign **`c(81, 125)`** to a variable before performing an operation.



```R
ratings <- c(81, 125)
ratings / 60
```

What we just did was create vectors, using the combine function **`c()`**. The **`c()`** function takes multiple items, then combines them into a **vector**. 

It's important to understand that **vectors** are used everywhere in R, and vectors are easy to use.



```R
c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
c(1:10)
```


```R
c(10:1) # 10 to 1
```

<hr></hr>
<div class="alert alert-success alertsuccess" style="margin-top: 20px">
<h4> [Tip] # Comments</h4>  

Did you notice the **comment** after the **c(10:1)** above? Comments are very useful in describing your code. You can create your own comments by using the **#** symbol and writing your comment after it. R will interpret it as a comment, not as code.

<p></p>
</div>

<hr></hr>


<a id="ref4"></a>

<h2 align=center>Strings in R</h2>


R isn't just about numbers -- we can also have strings too. For example:



```R
movie <- "Toy Story"
movie
```

In R, you can identify **character strings** when they are wrapped with **matching double (") or single (') quotes**.


Let's create a **character vector** for the following **genres**:

-   Animation
-   Comedy
-   Biography
-   Horror
-   Romance
-   Sci-fi



```R
genres <- c("Animation", "Comedy", "Biography", "Horror", "Romance", "Sci-fi")
genres
```

<hr>


#### Scaling R with big data


As you learn more about R, if you are interested in exploring platforms that can help you run analyses at scale, you might want to sign up for a free account on [IBM Watson Studio](http://cocl.us/dsx_rp0101en), which allows you to run analyses in R with two Spark executors for free.


<hr>


### Excellent! You have just completed the R basics notebook!


### About the Author:

Hi! It's [Marta Aghili](https://ca.linkedin.com/in/marta-aghili-2b184b71?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ), the author of this notebook. I hope you found R easy to learn! There's lots more to learn about R but you're well on your way. Feel free to connect with me if you have any questions.


<hr>
Copyright &copy; [IBM Cognitive Class](https://cognitiveclass.ai). This notebook and its source code are released under the terms of the [MIT License](https://cognitiveclass.ai/mit-license/).

