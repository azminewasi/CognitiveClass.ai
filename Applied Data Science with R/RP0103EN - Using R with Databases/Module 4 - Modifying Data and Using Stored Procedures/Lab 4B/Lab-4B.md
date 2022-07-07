<center><img src = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/labs/module%201/images/IDSNlogo.png" width = 250></center>

<h1 align=center><font size = 5>Hands-on Lab: Modifying Data using R</h1>


### Welcome!

In this hands-on lab, we will learn modifying data using R.


<div class="alert alert-block alert-info" style="margin-top: 20px">
<h3>Tasks</h3>
<ol><ol><ol>
<li><a href="#refa">Pre-requisites</a></li>
<li><a href="#refb">Load the RODBC library</a></li>
<li><a href="#refc">Connect to your database</a></li>
<li><a href="#refd">Create a test table</a></li>
<li><a href="#refe">Create a dataframe</a></li>
<li><a href="#reff">Create a new dataframe</a></li>
<li><a href="#refg">Insert the dataframe into a NEW table</a></li>
<li><a href="#refh">Use sqlUdate() to enter new values</a></li>
<li><a href="#refi">Dis-connect</a></li>
</ol></ol></ol>
<br>
Estimated Time Needed: <strong>30 min</strong>
</div>


<a id="refa"></a>

<h3>a. Pre-requisites</h3>


In this lab we will use Jupyter Notebooks within SN Labs to access data in a Db2 on Cloud database using RODBC.  Information about Jupyter notebooks, SN Labs, and Db2 services is provided in the previous labs.


<a id="refb"></a>

<h3>b. Load the RODBC library</h3>
<br>
Let's start by loading the <b>RODBC</b> library. The RODBC package and the ODBC driver for Db2 are pre-installed on your workbench. Let’s load the RODBC package by clicking on the following cell and executing it (Shift+Enter):



```R
library(RODBC);
```

<a id="refc"></a>

<h3>c. Connect to your database</h3>
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
#Create a connection string and connect to the database
conn_... <- paste("DRIVER=",...,
                  ";DATABASE=",...,
                  ";HOSTNAME=",...,
                  ";PORT=",...,
                  ";PROTOCOL=",...,
                  ";UID=",dsn_...,
                  ";PWD=",dsn_...,sep="")
conn <- ...DriverConnect(conn_...)
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
conn.... <- odbc...(conn)
conn....["..._Name"]
conn....["..._Ver"]
conn....["..._ODBC_..."]
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


Now drop the table in case you have already created the table and are re-running this cell.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...ttab <- sql...(conn, "...")
```

</details>


<details>
<summary>Click here to view/hide hint</summary>
<p>

```
#Drop the table in case you have already created the table and are re-running this cell
dropttab <- sqlDrop(conn, "TESTR")
```

</details>


<a id="refd"></a>

<h3>d. Create a test table</h3>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
create... <- sql...(conn, "CREATE ... ... (ID ... PRIMARY ... NOT ..., NAME ...(6))", ...=FALSE)
```

</details>


<details>
<summary>Click here to view/hide hint</summary>
<p>

```
#Create a test table
createtab <- sqlQuery(conn, "CREATE TABLE TESTR (ID INTEGER PRIMARY KEY NOT NULL, NAME CHAR(6))", errors=FALSE)
```

</details>


Perform error checking to see if the table was created successfully.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
if(create...==...){
      ...("An ... has ...:\n")
      ....msg <- odbc...(conn)
      for (error in ....msg) {
        ...(error,"\n")
      } 
      } else {
          ... ("Table ... successfully.\n")
}
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Perform error checking to see if the table was created successfully
if(createtab==-1){
      cat("An error has occurred:\n")
      err.msg <- odbcGetErrMsg(conn)
      for (error in err.msg) {
        cat(error,"\n")
      } 
      } else {
          cat ("Table created successfully.\n")
}
```

</details>


Get the column information for the newly created test table.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
test....detail <- sql...(conn, "...")
print(test....detail[c(...,...,7,...)], ....names=FALSE)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Get column information for the newly created test table
testcol.detail <- sqlColumns(conn, "TESTR")
print(testcol.detail[c(4,6,7,18)], row.names=FALSE)
```

</details>


<a id="refe"></a>

<h3>e. Create a dataframe</h3>
<p>Create a dataframe with sample values.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
id <- c(1, 2, 3)
name <- c("...", "...", "...")
test... <- ....frame(..., name)
test...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Create a dataframe with sample values
id <- c(1, 2, 3)
name <- c("BAT   ", "CAT   ", "DOG   ")
testrdf <- data.frame(id, name)
#view the contents of the dataframe
testrdf
```

</details>


Save the contents of the test dataframe into the test table.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
sql...(conn, test..., "...", ...=TRUE, fast=..., ...names=FALSE, ...names=FALSE)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#save the contents of the test dataframe into the test table
sqlSave(conn, testrdf, "TESTR", append=TRUE, fast=FALSE, rownames=FALSE, colnames=FALSE)
```

</details>


Check that the contents were saved in the database by fetching the contents of the table. 



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
test... <- sql...(conn, "...", strings...=FALSE)
test...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#check the contents were saved in the database by fetching the contents of the table
testrdb <- sqlFetch(conn, "TESTR", stringsAsFactors=FALSE)
testrdb
```

</details>


Find the ID of the last row in the table and increment it.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
new... <- n...(test...) + ...
new...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#find the ID of last row in the table and increment it
newID <- nrow(testrdb) + 1
newID
```

</details>


<a id="reff"></a>

<h3>f. Create a new dataframe</h3>
<p>Create a dataframe for the new row with the incremented ID.</p>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
new... <- data....("ID"=...ID, "..."="FOG   ")
new...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Create a dataframe for the new row with the incremented ID
newrow <- data.frame("ID"=newID, "NAME"="FOG   ")
newrow
```

</details>


Now let's insert the new row in the table; note that append is TRUE.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
sql...(conn, new..., "...", ...=TRUE, fast=..., row...=FALSE, ...names=FALSE)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Now let's insert the new row in the table
#Note below append=TRUE
sqlSave(conn, newrow, "TESTR", append=TRUE, fast=FALSE, rownames=FALSE, colnames=FALSE)
```

</details>


Let's retrieve the table contents and see if the new row was added.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
#Lets retrieve the table contents and see if the new row was added
test... <- sql...(conn, "...", strings...=FALSE)
test...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Lets retrieve the table contents and see if the new row was added
testrdbnew <- sqlFetch(conn, "TESTR", stringsAsFactors=FALSE)
testrdbnew
```

</details>


Let's add a few more rows to the database; first create a dataframe with a couple more rows.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
ID <- c(...,...)
NAME <- c("...   ", "...   ")
new... <- data....(..., NAME)
new...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Lets add a few more rows to the database
#First create a dataframe with couple more rows
ID <- c(5,6)
NAME <- c("JOG   ", "LOG   ")
newrows <- data.frame(ID, NAME)
newrows
```

</details>


Add these new rows to the dataframe we retrieved from the database.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
test...rows <- r...(test...,...rows)
test...rows
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Add these new rows to the dataframe we retrieved from the database
testrdbnewrows <- rbind(testrdbnew,newrows)
testrdbnewrows
```

</details>


<a id="refg"></a>

<h3>g. Insert the dataframe into a NEW table</h3>
<p>Now let's insert the dataframe with new rows into a NEW table in the database. Because TESTR2 does not exist it will be created.</p>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
drop... <- sql...(conn, "...")  
sql...(conn, test..., "...", fast=..., row...=FALSE, col...=FALSE)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Now let's insert the dataframe with new rows into a NEW table in the database
dropttab <- sqlDrop(conn, "TESTR2")  #Ensure the table does not exist
#Because TESTR2 does not exist it will be created
sqlSave(conn, testrdbnewrows, "TESTR2", fast=FALSE, rownames=FALSE, colnames=FALSE)
```

</details>


Let's fetch the contents of the new table to see if the contents of the new table match those of the test database new rows we inserted earlier.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
test... <- sql...(conn, "...", strings...=FALSE)
test...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>
  
```
#let's fetch the contents of the new table
testrdb2 <- sqlFetch(conn, "TESTR2", stringsAsFactors=FALSE)
#See if the contents o fthe new table match those of testdbnewrows we inserted
testrdb2
```
  
</details>


Now let's update some data; set a new value for the second column in the sixth row.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
test...[6,...] <- "..." 
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
testrdb2[6,2] <- "MEG   " 
```

</details>


<a id="refh"></a>

<h3>h. Use sqlUdate() to enter new values</h3>
<p>Now use sqlUpdate() to enter the new value into the database; then fetch the contents of the updated table.</p>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
sql...(conn, ...,"TEST...", ...="ID")
#fetch the contents of the updated table
test... <- sql...(conn, "TEST...", strings...=FALSE)
test...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
sqlUpdate(conn, testrdb2,"TESTR2", index="ID")
#fetch the contents of the updated table
testrdb3 <- sqlFetch(conn, "TESTR2", stringsAsFactors=FALSE)
testrdb3
```

</details>


Note: Rather than use SQLUpdate, sometimes it may be more efficient to modify the data using the SQL UPDATE statement via sqlQuery()


<a id="refi"></a>

<h3>i. Close the connection</h3>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...(...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
close(conn) 
```

</details>


<a id="refj"></a>

<h3>Summary</h3>


In this lab you learned how to modify data in a database using R.


<hr>


#### Thank you for completing this lab on modifying data using R.


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

