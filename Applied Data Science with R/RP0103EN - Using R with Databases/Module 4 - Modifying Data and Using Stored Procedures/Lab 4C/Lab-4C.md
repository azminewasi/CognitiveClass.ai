<center><img src = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/labs/module%201/images/IDSNlogo.png" width = 250></center>

<h1 align=center><font size = 5>Hands-on Lab: Using Database Stored Procedures from R</h1>


### Welcome!

In this hands-on lab, we will create and use database stored procedures from R.


<div class="alert alert-block alert-info" style="margin-top: 20px">
<h3>Tasks</h3>
<ol><ol><ol>
<li><a href="#refa">Pre-requisites</a></li>
<li><a href="#refb">Load the RODBC package</a></li>
<li><a href="#refc">Connect to your Database</a></li>
<li>Create a simple stored procedure:
<ol>
<li><a href="#refd1">Construct the stored procedure</a></li>
<li><a href="#refd2">Execute the sqlQuery statement</a></li>
</ol></li>
<li><a href="#refe">Invoke the stored procedure</a></li>
<li><a href="#reff">Pass parameters to a stored procedure</a></li>
<li><a href="#refg">Update data with a stored procedure</a></li>
</ol></ol></ol>
<br>
Estimated Time Needed: <strong>30 min</strong>
</div>


<a id="refa"></a>

<h3>a. Pre-requisites</h3>


In this lab we will use Jupyter Notebooks within SN Labs to access data in a Db2 on Cloud database using RODBC.  Information about Jupyter notebooks, SN Labs, and Db2 services is provided in the previous labs.


<a id="refb"></a>

<h3>b. Load the RODBC package</h3>
<br>
Let's start by loading the <b>RODBC</b> package. The RODBC package and the ODBC driver for Db2 are pre-installed on your workbench. Let’s load the RODBC package by clicking on the following cell and executing it (Shift+Enter):



```R
library(RODBC);
```

<a id="refc"></a>

<h3>c. Connect to your database</h3>
<br>
Enter the values for your database connection.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the <...>
dsn_driver <- "{...}"
dsn_database <- "..."            
dsn_hostname <- "<Enter Hostname>" 
dsn_port <- "..."                
dsn_protocol <- "..."            
dsn_uid <- "<Enter UserID>"        
dsn_pwd <- "<Enter Password>"   
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Enter the values for you database connection
dsn_driver <- "{IBM DB2 ODBC Driver}"
dsn_database <- "BLUDB"            # e.g. "BLUDB"
dsn_hostname <- "<Enter Hostname>" # e.g.: "dashdb-txn-sbox-yp-dal09-11.services.dal.bluemix.net"
dsn_port <- "50000"                # e.g. "50000" 
dsn_protocol <- "TCPIP"            # i.e. "TCPIP"
dsn_uid <- "<Enter UserID>"        # e.g. "zjh17769"
dsn_pwd <- "<Enter Password>"      # e.g. "zcwd4+8gbq9bm5k4"  
```

</details>


Create a connection string and connect to the database.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
..._path <- paste("DRIVER=",dsn_...,
                  ";DATABASE=",dsn_...,
                  ";HOSTNAME=",dsn_...,
                  ";PORT=",dsn_...,
                  ";PROTOCOL=",dsn_...,
                  ";...=",dsn_...,
                  ";...=",dsn_...,...="")
conn <- ...Driver...(conn_...)
conn
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Create a connection string and connect to the database
conn_path <- paste("DRIVER=",dsn_driver,
                  ";DATABASE=",dsn_database,
                  ";HOSTNAME=",dsn_hostname,
                  ";PORT=",dsn_port,
                  ";PROTOCOL=",dsn_protocol,
                  ";UID=",dsn_uid,
                  ";PWD=",dsn_pwd,sep="")
conn <- odbcDriverConnect(conn_path)
conn
```

</details>


View the database and driver information.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
sql.... <- sql...(conn)
conn.... <- ...Get...(...)
conn....[..._Name"]
conn....["..._Ver"]
conn....["Driver_..._Ver"]
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#View database and driver information
sql.info <- sqlTypeInfo(conn)
conn.info <- odbcGetInfo(conn)
conn.info["DBMS_Name"]
conn.info["DBMS_Ver"]
conn.info["Driver_ODBC_Ver"]
```

</details>


<a id="refd1"></a>

<h3>d.i Create a simple stored procedure</h3>
<br>
Let's create a very simple stored procedure that simply performs a select from the sample table GOSALES_ORDER_DETAILS and returns the results.
NOTE: Typically the stored procedures are created directly on the database server and invoked from client applications, however, here we are  creating it in the R notebook just for illustration.


Construct the statement for creating the stored procedure.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...1 <- "... OR ... PROCEDURE ... 
RESULT ... 1

BEGIN ... c1 ... WITH ... FOR 
SEL... * FROM ....;

... c1;
END 
"
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
query1 <- "CREATE OR REPLACE PROCEDURE GetOrderDetails
RESULT SETS 1

BEGIN DECLARE c1 CURSOR WITH RETURN FOR 
SELECT * FROM GOSALES_ORDER_DETAILS;

OPEN c1;
END 
"
```

</details>


<a id="refd2"></a>

<h3>d.ii Execute the sqlQuery statement</h3>

Use <b>sqlQuery</b> to execute the statement for creating stored procedures



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...1 <- sql...(conn,...1)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
df1 <- sqlQuery(conn,query1)
```

</details>


<a id="refe"></a>

<h3>e. Invoke the stored procedure</h3>
<br>
Now lets invoke the stored procedure and print the results



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...2 <- "CALL ...()"
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
query2 <- "CALL GetOrderDetails()"
```

</details>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...2 <- sql...(conn,...2)
...2
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#The stored procedure returns a result set which we can retrieve into a dataframe
df2 <- sqlQuery(conn,query2)
df2
```

</details>


<a id="reff"></a>

<h3>f. Pass parameters to a stored procedure</h3>
<br>
Now let's try a stored procedure to which you can pass a parameter or more.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...3 <- "... OR ... PROCEDURE ... (IN ..., IN ...)
RESULT ... 1

BEGIN ... c1 ... WITH ... FOR 
SEL... * FROM .... WHERE ... ;

... c1;
END 
"
...3 <- sql...(conn,...3)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
query3 <- "CREATE OR REPLACE PROCEDURE GetOrderDetails (IN Start_Date DATE, IN End_date DATE)
RESULT SETS 1

BEGIN DECLARE c1 CURSOR WITH RETURN FOR 
SELECT * FROM GOSALES_ORDER_DETAILS WHERE SHIP_DATE BETWEEN Start_Date AND End_date;

OPEN c1;
END 
"
df3 <- sqlQuery(conn,query3)
```

</details>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...4 <- "CALL ...(...)"
...4 <- sql...(conn,...4)
...4
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Now invoke the procedure passing the parameter(s)
query4 <- "CALL GetOrderDetails(Start_Date => '2011-06-01', End_date => '2011-06-30')"
df4 <- sqlQuery(conn,query4)
df4
```

</details>


<a id="refg"></a>

<h3>g. Update data with a stored procedure</h3>
<br>
Let's now look at a stored procedure that updates some data in the database.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
ID <- c(as....(1),as.integer(2),as.integer(3),as.integer(4))
NAME <- c("...", "...", "...", "...")
BASE... <- c(1..., 2..., 3..., 4...)
RATING <- c(..., ..., ..., ...)
BONUS <- c(..., ..., ..., ....)
...df <- data....(ID, ..., ...SALARY, ..., BO...)

...ttab <- sql...(conn, "...")

sql...(conn, ...df, "...", ...=TRUE, ...=FALSE, ...ames=FALSE, ...names=FALSE)

...db <- sql...(conn, "...", strings...=FALSE)
...db
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
# First create a dataframe with sample IDs, names, salaries, and bonus
ID <- c(as.integer(1),as.integer(2),as.integer(3),as.integer(4))
NAME <- c("Agatha", "Polong", "Rav", "Saeed")
BASESALARY <- c(1000, 2000, 3000, 4000)
RATING <- c(4, 1, 3, 2)
BONUS <- c(0, 0, 0, 0)
salarydf <- data.frame(ID, NAME, BASESALARY, RATING, BONUS)
#drop the salary table in case it exists
dropttab <- sqlDrop(conn, "SALARY")
#insert the dataframe contents into a database table
sqlSave(conn, salarydf, "SALARY", append=TRUE, fast=FALSE, rownames=FALSE, colnames=FALSE)
#check the data that was written to database
salarydb <- sqlFetch(conn, "SALARY", stringsAsFactors=FALSE)
salarydb
```

</details>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...5 <- "... OR ... PROCEDURE ...bonus (IN ... ...)
BEGIN  
... SALARY ... BONUS = ...SALARY * (...bonus * ...);
END
"
df5 <- sql...(conn,...5)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#This procedure based on an input value gives all teachers in the salary table a bonus
query5 <- "CREATE OR REPLACE PROCEDURE givebonus (IN basebonus DOUBLE)
BEGIN  
UPDATE SALARY SET BONUS = BASESALARY * (basebonus * RATING);
END
"
df5 <- sqlQuery(conn,query5)
```

</details>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...6 <- "CALL ...(....05)"
...6 <- sql...(conn,...6)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#lets invoke the procedure with a 5% basebonus
query6 <- "CALL givebonus(0.05)"
df6 <- sqlQuery(conn,query6)
```

</details>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
bonus.. <- sql...(conn, "...", strings...=...)
bonus..
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Let's see how much Bonus everyone got
bonusdb <- sqlFetch(conn, "SALARY", stringsAsFactors=FALSE)
bonusdb
```

</details>


<h3>Summary</h3>


In this lab you learned how to take advantage of stored procedures in a database to perform processing on the database server.


<hr>


#### Thank you for completing this lab on using stored procedures from R.


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

