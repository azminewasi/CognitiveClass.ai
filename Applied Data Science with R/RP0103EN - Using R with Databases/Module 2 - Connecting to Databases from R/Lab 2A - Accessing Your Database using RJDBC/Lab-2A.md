<center><img src = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0103EN-SkillsNetwork/labs/module%201/images/IDSNlogo.png" width = 250></center>

<h1 align=center> <font size = 6>Hands-on Lab: Accessing Your Database using RJDBC</font></h1>


### Welcome!

In this hands-on lab, we will discover how to connect and query data from database servers with R using RJDBC.


<div class="alert alert-block alert-info" style="margin-top: 20px">
<h3>Tasks</h3>
<ol><ol><ol>
<li><a href="#refa">Load the RJDBC library</a></li>
<li><a href="#refb">Provide database credentials</a></li>
<li><a href="#refc">Connect to the database</a></li>
<li><a href="#refd">Execute a Query (and retrieve results)</a></li>
<li><a href="#refe">Dis-connect</a></li>
</ol></ol></ol>
<p></p>
Estimated Time Needed: <strong>10 min</strong>
</div>


**Pre-requisite**: In this lab we will use Jupyter Notebooks within SN Labs to access data in a Db2 on Cloud database using RJDBC.  Information about Jupyter notebooks, SN Labs, and Db2 services is provided in the previous labs.


<a id="refa"></a>

### a. Load the RJDBC library

The RJDBC package is pre-installed in SN Labs. Let’s load the RJDBC package by clicking on the following cell and executing it (Shift+Enter):



```R
library(RJDBC);
```

<a id="refb"></a>

### b. Provide database credentials

In the following cell enter the connection details for your instance of **Db2** and run it. Remember to update the values for hostname, userid, and password.

For instructions on accessing **Db2 Service Credentials**, go to **Hands-on Lab: Setup your database service instance and Access service credentials**.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
dsn_driver = "com.ibm.db2.jcc.DB2Driver"
dsn_database = "..."            
dsn_hostname = "<yourhostname>"  
dsn_port = "..."               
dsn_protocol = "..."           
dsn_uid = "<username>"        
dsn_pwd = "<password>"      
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
#Enter the values for you database connection
dsn_driver = "com.ibm.db2.jcc.DB2Driver"
dsn_database = "BLUDB"            # e.g. "BLUDB"
dsn_hostname = "<yourhostname>"   # e.g. replace <yourhostname> with your hostname
dsn_port = "50000"                # e.g. "50000" 
dsn_protocol = "TCPIP"            # i.e. "TCPIP"
dsn_uid = "<username>"              # e.g. replace <username> with your userid
dsn_pwd = "<password>"            # e.g. replace <password> with your password
```

</details>


<a id="refc"></a>

### c. Connect to the database

First we will specify which database driver to use. Then create a JDBC connection string.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
jcc = JDBC("com.ibm.db2.jcc....r", "/home/jupyterlab/.rlang/db2jcc-db2jcc4.jar");
jdbc_path = paste("jdbc:db2://",  dsn_port, ":", ..., "/", dsn_database, ...);
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
jcc = JDBC("com.ibm.db2.jcc.DB2Driver", "/home/jupyterlab/.rlang/db2jcc-db2jcc4.jar");
jdbc_path = paste("jdbc:db2://",  dsn_hostname, ":", dsn_port, "/", dsn_database, sep="");
```

</details>


Now, let's use the driver and connection string to actually connect to the database using the RJDBC function dbConnect().



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
conn = dbConnect(..., ..., user=..., password=...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
conn = dbConnect(jcc, jdbc_path, user=dsn_uid, password=dsn_pwd)
```

</details>


<a id="refd"></a>

### d. Execute a Query (and return the results)

Next, execute a query against the Db2 system catalog table **SYSIBM.SYSSCHEMATA** and fetch the results into a R dataframe.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
Fill in the ...
query = "SELECT * FROM ...";
rs = dbSendQuery(...);
df = fetch(...);
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
query = "SELECT * FROM SYSIBM.SYSSCHEMATA";
rs = dbSendQuery(conn, query);
df = fetch(rs, -1);
```

</details>


Let’s examine the contents of the dataframe by looking at the first few rows: 



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
head(df)
```

</details>


<a id="refe"></a>

### e. Dis-connect

Finally, as a best practice we should close the database connection once we're done with it.



```R

```

<details>
<summary>Click here to view/hide hint</summary>
<p>

```
# Fill in the ...
dbDisconnect(...)
```

</details>


<details>
<summary>Click here to view/hide solution</summary>
<p>

```
dbDisconnect(conn)
```

</details>


<a id="ref4g"></a>

### Summary

In this lab you accessed data in a Db2 on Cloud database using RJDBC connection from a R notebook in Jupyter, and fetched the results of a query for analysis in a R dataframe.


<HR>


#### Thank you for completing this lab on getting connected and querying databases using RJDBC.


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

