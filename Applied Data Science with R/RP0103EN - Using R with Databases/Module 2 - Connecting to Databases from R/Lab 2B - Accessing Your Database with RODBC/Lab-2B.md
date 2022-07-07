<center><img src = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/labs/module%201/images/IDSNlogo.png" width = 250></center>

<h1 align=center><font size = 5>Hands-on Lab: Accessing Your Database with RODBC</h1>


### Welcome!

In this hands-on lab, we will learn how to connect and discover metadata from database servers with R using RODBC.


<div class="alert alert-block alert-info" style="margin-top: 20px">
<h3>Tasks</h3>
<ol><ol><ol>
<li><a href="#ref6a">Pre-requisites</a></li>
<li><a href="#ref6b">Create an R notebook</a></li>
<li><a href="#ref6c">Load RODBC</a></li>
<li><a href="#ref6d">Connection information</a></li>
<li><a href="#ref6e">Create a database connection</a></li>
<li><a href="#ref6f">Connection Attributes</a></li>
<li><a href="#ref6g">Connection Metadata</a></li>
<li><a href="#ref6h">Supported Datatypes</a></li>
<li><a href="#ref6i">List of Tables</a></li>
<li><a href="#ref6j">Columns in a Table</a></li>
<li><a href="#ref6k">Dis-connect</a></li>
</ol></ol></ol>
<br>
Estimated Time Needed: <strong>15 min</strong>
</div>


<a id="ref6a"></a>

<h3>a. Pre-requisites</h3>


In this lab we will use Jupyter Notebooks within SN Labs to access data in a Db2 on Cloud database using RODBC.  Information about Jupyter notebooks, SN Labs, and Db2 services is provided in the previous labs.


<a id="ref6b"></a>

<h3>b. Create an R notebook</h3>


If necessary, set the notebook kernel to use R (using the dropdown in the top right corner).

![](https://ibm.box.com/shared/static/vb8qv1tyq3b40sq4urgyfk9fwi2i8rpm.png)


<a id="ref6c"></a>

<h3>c. Load RODBC</h3>


The RODBC package and the ODBC driver for Db2 are pre-installed on your workbench. Let’s load the RODBC package by clicking on the following cell and executing it (Shift+Enter):



```R
library(RODBC);
```

<a id="ref6d"></a>

<h3>d. Connection information</h3>


In the following cell enter the connection details for your instance of Db2 and run it. Remember to update the values for hostname, userid, and password.

For instructions on accessing **Db2 Service Credentials**, go to **Hands-on Lab: Setup your database service instance and Access service credentials**.



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
dsn_driver <- "{IBM DB2 ODBC Driver}"
dsn_database <- "BLUDB"            # e.g. "BLUDB"
dsn_hostname <- "<Enter Hostname>" # e.g.: "dashdb-txn-sbox-yp-dal09-11.services.dal.bluemix.net"
dsn_port <- "50000"                # e.g. "50000" 
dsn_protocol <- "TCPIP"            # i.e. "TCPIP"
dsn_uid <- "<Enter UserID>"        # e.g. "zjh17769"
dsn_pwd <- "<Enter Password>"      # e.g. "zcwd4+8gbq9bm5k4"  
```

</details>


<a id="ref6e"></a>

<h3>e. Create a database connection</h3>


Create a connection string and connect:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
conn_path <- paste("DRIVER=",...
                  ";DATABASE=",...
                  ";HOSTNAME=",...
                  ";PORT=",...
                  ";PROTOCOL=",...
                  ";UID=",...
                  ";PWD=",...")
conn <- ...(...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
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

</div>


<a id="ref6f"></a>

<h3>f. Connection Attributes</h3>


Let’s examine the connection attributes:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
...(conn)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
attributes(conn)
```

</details>


<a id="ref6g"></a>

<h3>g. Connection Metadata</h3>


And review the connection metadata using  the odbcGetInfo() function:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
conn.... <- odbc...(conn) 
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
conn.info <- odbcGetInfo(conn) 
```

</details>



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
conn....["DBMS_..."]
conn....["DBMS_..."] 
conn....["Driver_..._..."]
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
conn.info["DBMS_Name"]
conn.info["DBMS_Ver"] 
conn.info["Driver_ODBC_Ver"]
```

</details>


<a id="ref6h"></a>

<h3>h. Supported Datatypes</h3>


Let’s now examine the datatypes supported by the database:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
sql.... <- sql...(conn)
print(sql....[c(1,...)], row....=FALSE) 
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
sql.info <- sqlTypeInfo(conn)
print(sql.info[c(1,3)], row.names=FALSE) 
```

</details>


<a id="ref6i"></a>

<h3>i. List of Tables</h3>


We will use the sqlTables() function to return a dataframe with information about table-like objects (i.e. TABLEs, VIEWs, ALIASes, etc.) in the Db2 system Schema **SYSIBM**. First we will output the number of tables in the schema, and then display their names.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
tab.... <- sql...(conn, ...="<Enter Schema>")
nrow(tab....)
tab.frame$...
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
tab.frame <- sqlTables(conn, schema="<Enter Schema>") # e.g. "SYSIBM"
nrow(tab.frame)
tab.frame$TABLE_NAME
```

</details>


<a id="ref6j"></a>

<h3>j. Columns in a Table</h3>


Next, let’s look at column metadata for columns in the system catalog table **SYSSCHEMATA**:



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
tab.... <- "...."
col.detail <- sql...(conn, tab....)
print(....detail[c(...,...,7,...,...)], row....=FALSE)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
tab.name <- "<Enter Table>" # e.g. "SYSSCHEMATA"
col.detail <- sqlColumns(conn, tab.name)
print(col.detail[c(2,3,4,6,7,9,18)], row.names=FALSE)
```

</details>


<a id="ref6k"></a>

<h3>k. Dis-connect</h3>


Finally, as a best practice we should close the database connection once we're done with it.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
odbc...()
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
odbcCloseAll()
```

</details>


<a id="ref6o"></a>

<h3>Summary</h3>


In this lab you accessed data in a Db2 on Cloud database using RODBC connection from a R notebook in Jupyter, and discovered different metadata.


<hr>


#### Thank you for completing this lab on getting connected and querying databases using RODBC.


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

