<img src="http://cognitiveclass.ai/wp-content/uploads/2017/11/cc-logo-square.png" width="150">

<h1 align="center">DEBUGGING in R</h1> 


## Table of Contents

<ul>
<li><a href="#What-is-debugging-and-error-handling?">What is debugging and error handling?</a></li>
<li><a href="#Error-handling-in-R?">Error handling in R?</a></li>
<li><a href="#Warning-handling-in-R?">Warning handling in R?</a></li>
</ul>
<p></p>
Estimated Time Needed: <strong>15 min</strong>

<hr>


<a id='ref1'></a>

<center><h2>What is debugging and error handling?</h2></center>


_What do you get when you try to add  **`"a" + 10`**? An error!_



```R
"a" + 10
```

_And what happens to your code if an error occurs? It halts!_



```R
for(i in 1:10){
    #for every number, i, in the sequence of 1,2,3:
    print(i + "a")
    }
```

These are very simple examples, and the sources of the errors are easy to spot. But when it's embedded in a large chunk of code with many parts, it can be difficult to identify _when_, _where_, and _why_ an error has occurred. This process of identifying the source of the error and fixing it is called **debugging**.


<hr>


<a id='ref2'></a>

<center><h2>Error Catching</h2></center>


If you know an error may occur, the best way to handle the error is to **`catch`** the error while it's happening, so it doesn't prevent the script from halting at the error.


#### No error:



```R
tryCatch(10 + 10)
```

#### Error:



```R
tryCatch("a" + 10) #Error
```

<h3>Error Catching with `tryCatch`:</h3>


**`tryCatch`** first _tries_ to run the code, and if it works, it executes the code normally. **But if it results in an error**, you can define what to do instead.



```R
#If tryCatch detects it will cause an error, print a message instead. Overall, no error is generated and the code continued to run successfully.

tryCatch(10 + "a", 
         error = function(e) print("Oops, something went wrong!") ) #No error
```


```R
#If error, return "10a" without an error

x <- tryCatch(10 + "a", error = function(e) return("10a") ) #No error
x
```


```R
tryCatch(
    for(i in 1:3){
        #for every number, i, in the sequence of 1,2,3:
        print(i + "a")
        }
    , error = function(e) print("Found error.") )
```

<hr>


<a id='ref3'></a>

<center><h2>Warning Catching</h2></center>


Aside from **errors**, there are also **warnings**. Warnings do not halt code, but are displayed when something is perhaps not running the way a user expects.



```R
as.integer("A") #Converting "A" into an integer warns the user that the value is converted to NA
```

If needed, you can also use **`tryCatch`** to catch the warnings as they occur, without producing the warning message:



```R
tryCatch(as.integer("A"), warning = function(e) print("Warning.") )
```

<hr>
#### Scaling R with big data

As you learn more about R, if you are interested in exploring platforms that can help you run analyses at scale, you might want to sign up for a free account on [IBM Watson Studio](http://cocl.us/dsx_rp0101en), which allows you to run analyses in R with two Spark executors for free.


<hr>


### About the Author:

Hi! It's [Kumar Gaurav](https://ca.linkedin.com/in/kumar-gaurav-a387a620?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ), the author of this notebook. I hope you found R easy to learn! There's lots more to learn about R but you're well on your way. Feel free to connect with me if you have any questions.


<hr>

Copyright ?? [IBM Cognitive Class](https://cognitiveclass.ai?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ). This notebook and its source code are released under the terms of the [MIT License](https://cognitiveclass.ai/mit-license?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0101EN-SkillsNetwork-20900564&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ).

