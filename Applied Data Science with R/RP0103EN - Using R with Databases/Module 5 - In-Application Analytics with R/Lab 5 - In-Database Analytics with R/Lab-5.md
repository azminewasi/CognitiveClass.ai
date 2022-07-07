<center><img src = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/labs/module%201/images/IDSNlogo.png" width = 250></center>

<h1 align=center><font size = 5>Hands-on Lab: Perform K-Means Clustering Analysis with R</h1>


### Welcome!

In this hands-on lab, we will perform the following tasks to illustrate the use of in-database anayltics in Db2 on Cloud using ibmdbR.


<div class="alert alert-block alert-info" style="margin-top: 20px">
<h3>Tasks</h3>
<ol><ol><ol>
<li><a href="#refa">Pre-requisites</a></li>
<li><a href="#refb">Load the ibmdbR package</a></li>
<li><a href="#refc">Connect to your Db2 on Cloud database</a></li>
<li><a href="#refd">Create a table with data</a></li>
<li><a href="#refe">Analyze the data</a></li>
<li><a href="#reff">Dis-connect</a></li>
</ol></ol></ol>
<br>
Estimated Time Needed: <strong>30 min</strong>
</div>


<a id="refa"></a>

<h3>a. Pre-requisites</h3>


In this lab we will use Jupyter Notebooks within SN Labs to access data in a Db2 on Cloud database using RODBC.  Information about Jupyter notebooks, SN Labs, and Db2 services is provided in the previous labs.


<a id="refb"></a>

<h3>b. Load the ibmdbR package</h3>
<br>
Let's start by loading the <b>ibmdbR</b> package. <b>ibmdbR</b> utilizes RODBC to connect to interact with the database so ensure that the database is accessable using RODBC. Let’s load the <b>ibmdbR</b> package by clicking on the following cell and executing it (Shift+Enter):



```R
library(ibmdbR);
```

<a id="refc"></a>

<h3>c. Connect to your Db2 on Cloud database</h3>


Enter the other connection details for your instance of Db2 on Cloud:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
driver.name <- "..."    # this matches entry in odbc.ini for DB2 driver
db.name <- "..."     
host.name <- "host..." 
port <- "..."         
protocol="..."        
user.name <- "..." 
pwd <- "..."       
dsnstr <- paste(driver....,
                  ";Data...=",....name,
                  ";Host...=",....name,
                  ";Port...=",...,
                  ";PROTOCOL=",..., sep="...")
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
driver.name <- "DB2"    # this matches entry in odbc.ini for DB2 driver
db.name <- "BLUDB"      # e.g. BLUDB
host.name <- "hostname" # e.g.  "dashdb-txn-sbox-yp-dal09-11.services.dal.bluemix.net"
port <- "50000"         # e.g.  50000
protocol="TCPIP"        # i.e. TCPIP
user.name <- "username" # e.g.  "zjh17769"
pwd <- "password"       # e.g. "zcwd4+8gbq9bm5k4"
dsnstr <- paste(driver.name,
                  ";Database=",db.name,
                  ";Hostname=",host.name,
                  ";Port=",port,
                  ";PROTOCOL=",protocol, sep="")
```

</details>


Now create a connection string and connect to the database using idaConnect().  Syntax and arguments for this function follow:

<div class="alert alert-block alert-info" style="margin-top: 20px">
<b>Usage</b><br>
idaConnect(dsn, uid = "", pwd = "", conType = "odbc")
<p>
<b>Arguments</b><br>
  dsn -     The DSN of the data base.<br>
  uid -    The user name.<br>
  pwd -    The password.<br>
  conType - The connection type. <br>


Add code to connect to the database (example: con <- idaConnect(...))



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
con <- ida...(dsn..., uid=....name, p...=...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
con <- idaConnect(dsnstr, uid=user.name, pwd=pwd)
```

</details>


Now let's initialize the In Database Analytics functions using idaInit() <br>

<div class="alert alert-block alert-info" style="margin-top: 20px">
<b>Usage</b><br>
idaInit(con,jobDescription=NULL)<br>
<br>
<b>Arguments</b><br>
con - An open RODBC connection.<br>
jobDescription - Optional argument that allows to assign a description to the jobs submitted from the R session<br>
</div>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
ida...(...) 
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
idaInit(con) 
```

</details>


Let's test to check our connection was established successfully by using idaShowTables() to get a list of tables.

<div class="alert alert-block alert-info" style="margin-top: 20px">
Tip: The list might be long ... single or double click on the left side just below Out [linenumber] to minimize the output result
</div>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
ida...(show...=...)
```

</details>


<details>
<summary>Click here to view/hide Solution</summary>
<p>

```
idaShowTables(showAll=TRUE)
```

</details>


<a id="refd"></a>

<h3>d. Create table with data</h3>
<br>
Our R environment contains a sample dataset called mtcars that contains certain attributes (like mileage, cylinders, horsepower, etc.) about 32 automobiles. If you are not familiar with this dataset, lets first take a look at it.


Load the mtcars library.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
mt...
```

</details>


<details>
<summary>Click here to view/hide Solution</summary>
<p>

```
mtcars
```

</details>


We will load this data into a table in our database. Note in the output above that mpg, cyl, etc. are column names but the that the car name doesn't have a column label. That's because it isn't actually a real column in the mtcars dataframe, rather its a special column that indictes the rownames.


Now, use the as.ida.data.frame() function to create a new table in the database that inputs the data from the newmtcars dataframe. This function creates an IDA data frame from a local R dataframe by creating a table in the database.
<br>

<div class="alert alert-block alert-info" style="margin-top: 20px">
<b>Usage</b><br>
as.ida.data.frame(x, table=NULL, clear.existing=FALSE, case.sensitive=TRUE,
rownames=NULL, dbname=NULL, asAOT=FALSE)<br>
<br>
<b>Arguments</b><br>
<i>x</i> - The name of the input object.<br>
<i>table</i> - The name of the table to be created.<br>
<i>clear.existing</i> - Indicates whether the existing table is to be dropped (TRUE).<br>
<i>case.sensitive</i> - Specifies whether the column names to be treated as case-sensitive (TRUE). <br>
<i>rownames</i> - The name of the column for the unique row id. If NULL, not added.<br>
dbname, asAOT - Parameters for DB2 on z/OS
</div>


Replace the code below with functional parameters.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
tableName <- "..."
idf <- as.ida.dataframe(...)
idf
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
tableName <- "MTCARS"
as.ida.data.frame(mtcars, table=tableName, clear.existing=TRUE, rownames="carname")
```

</details>


Now let's use idaQuery() to check if a table was created in the database with the mtcars data.  This function can run any SQL query on the database and put the results into a dataframe.
<br>

<div class="alert alert-block alert-info" style="margin-top: 20px">
<b>Usage</b><br>
idaQuery(..., as.is=TRUE, na.strings = "NA")<br>
<br>
<b>Arguments</b><br>
as.is - 
Specifies whether the result columns are to be converted using RODBC type
conversions (as.is=FALSE) or left unconverted (as.is=TRUE).<br>
na.strings - character vector of strings to be mapped to NA when reading character data.<br>
</div>


Replace the ... with your query to fetch the contents of the MTCARS table.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
mtcarsdb <- idaQuery(...)
mtcarsdb
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
mtcarsdb <- idaQuery("SELECT * FROM ",tableName)
mtcarsdb
```

</details>


<a id="refe"></a>

<h3>e. Analyze the data</h3>
<br>
As you have seen above you can use ibmdbR to put data into the database and run queries against the database. The key benefit of ibmdbR, however, lies in being able to perform in-database analytics. That is, "pushing down many basic and complex R operations into the database, which removes the main memory boundary of R and allows you to make full use of parallel processing in the underlying database". 

Let's first create a dataframe referencing the MTCARS table in the database. <br>NOTE: We could use the 'idf' dataframe that we created above to store the mtcars data in the database but this shows another way.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
id... <- ida.data....(...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
idf2 <- ida.data.frame(tableName)
```

</details>


Note that an in database dataframe like idf2 is just a pointer to the object(s) in database. Therefore the following will not display the data.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
i...2
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
idf2 
```

</details>


If you want to see the data referenced by the dataframe you can use a function like head() to examine the first few rows:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
head(...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
head(idf2)
```

</details>


Now let's use one of the built-in analytic functions such as idaKMeans() on this in-database dataframe created above on MTCARS table. Just like kmeans(), idaKMeans() is used for analyzing  clustering on the data. 

PS: Although we will utilize the sample mtcars dataset in the database, appreciate the advantages of in-database analytics if this was a very large dataset.


<br>
<div class="alert alert-block alert-info" style="margin-top: 20px">
<b>idaKMeans</b><br>
This function generates a k-means clustering model based on the contents of a IDA data frame.<br><br>
<b>Usage</b><br>
idaKMeans(
data,
id,
k=3,
maxiter=5,
distance="euclidean",
outtable=NULL,
randseed=12345,
statistics=NULL,
modelname=NULL
)<br>
<br>
<b>Arguments</b><br>
data - An IDA data frame that contains the input data for the function.<br> 
id - The name of the column that contains a unique ID for each row of the input data.<br>
k - The number of clusters to be calculated. <br>
maxiter - The maximum number of iterations to be used to calculate the k-means clusters. <br>
distance - The distance function that is to be used. e.g.: 
"euclidean" or "norm_euclidean"<br>
outtable - The name of the output table that is to contain the results of the operation. <br>
randseed - The seed for the random number generator. <br>
statistics - Denotes which statistics to calculate. e.g. 
"none", "columns" and "all" or NULL<br>
modelname - The name under which the model is stored in the database. This is the name that is specified when using functions such as idaRetrieveModel or idaDropModel.<br>
object - An object of the class idaKMeans to be used for prediction, i.e.  for applying it to new data.<br>
x - An object of the class idaKMeans to be printed.<br>
newdata - A IDA data frame that contains the data to which to apply the model.<br>
... -  Additional parameters to pass to the print or predict method.


Now run K-Means with k=4 clusters on the mtcars dataset in the database; replace the ... with your own parameters and then print the model.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
#now run kmeans with k=4 clusters on the mtcars dataset in the database 
kclusters=...
#replace ... with your parameters
km <- idaKMeans (idf2, ...)
print(...) #Print ...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
# drop this model in case it already exists e.g. re-running the cell
idaDropModel("KMEANSMODEL") 
kclusters=4
#Create a kmeans model stored in the database as KMEANSMODEL:
km <- idaKMeans(idf2, id="carname", k=kclusters, modelname="KMEANSMODEL")
print(km) #Print the model
```

</details>


Predict the model. Replace the ... with the code to predict the model.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
pred <- pred...(km,...2,id="carname")
....(pred,...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
pred <- predict(km,idf2,id="carname")
head(pred,10)
```

</details>


Now let's visualize the clustering analysis using ggplot2. You need to fix the code as indicated.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
#FIX THIS CELL
#Not working with idf2 and km
#data(idf2)
library(gg...2)
x <- t...(idf2$...,km$cluster,...)
y <- t...(idf2$...,km$cluster,...)
kcenters <- data....(x,...)
ggplot(id...,aes(...,hp))+geom_...(col=km$...,size=...) +  
    geom_point(...=kcenters,aes(...,...),pch=...,size=...,colour=...:k...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#FIX THIS CELL
#Not working with idf2 and km
#data(idf2)
library(ggplot2)
x <- tapply(idf2$mpg,km$cluster,mean)
y <- tapply(idf2$hp,km$cluster,mean)
kcenters <- data.frame(x,y)
ggplot(idf2,aes(mpg,hp))+geom_point(col=km$cluster,size=4) +  
    geom_point(data=kcenters,aes(x,y),pch=8,size=10,colour=1:kclusters)
```

</details>


<a id="reff"></a>

<h3>f. Dis-connect</h3>


Add the code to disconnect from the databse.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
ida...(...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
idaClose(con)
```

</details>


<a id="ref6o"></a>

<h3>Summary</h3>


In this lab you performed K-Means clustering analysis on a sample dataset using the ibmdbR library with an R notebook in Jupyter.


<hr>

#### Thank-you for completing this lab on K-Means Clustering.


<hr>

## Authors

-   [Rav Ahuja](https://ca.linkedin.com/in/rav-ahuja-8aa4562a?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork-23619267&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork-23619267&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)
-   [Agatha Colangelo](https://www.linkedin.com/in/agathacolangelo?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork-23619267&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork-23619267&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)
-   [Sandip Saha Joy](https://www.linkedin.com/in/sandipsahajoy?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork-23619267&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork-23619267&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)

## Changelog

| Date (YYYY-MM-DD) | Version | Changed By                   | Change Description                 |
| ----------------- | ------- | ---------------------------- | ---------------------------------- |
| 2021-01-22        | 2.0     | Sandip Saha Joy              | Created revised version of the lab |
| 2017              | 1.0     | Rav Ahuja & Agatha Colangelo | Created initial version of the lab |

<hr>

<h2 align=center><font size = 5>Copyright &copy; IBM Corporation 2017-2021. All rights reserved.</h2>

