library(RODBC);

dsn_driver <- "{IBM DB2 ODBC Driver}"
dsn_database <- "BLUDB"            
dsn_hostname <- "dashdb-txn-sbox-yp-dal09-08.services.dal.bluemix.net" 
dsn_port <- "50000"                
dsn_protocol <-"TCPIP"           
dsn_uid <- "vgh86276"        
dsn_pwd <- "5ft1hr51@rfbgt26"  

conn_path <- paste("DRIVER=",dsn_driver,
                  ";DATABASE=",dsn_database,
                  ";HOSTNAME=",dsn_hostname,
                  ";PORT=",dsn_port,
                  ";PROTOCOL=",dsn_protocol,
                  ";UID=",dsn_uid,
                  ";PWD=",dsn_pwd,sep="")
conn <- odbcDriverConnect(conn_path)
conn

sql.info <- sqlTypeInfo(conn)
conn.info <- odbcGetInfo(conn)
conn.info["DBMS_Name"]
conn.info["DBMS_Ver"]
conn.info["Driver_ODBC_Ver"]

myschema <- "ZJH17769" # e.g. "ZJH17769"
tables <- c("BOARD", "SCHOOL")
    
    for (table in tables){  
      # Drop School table if it already exists
      out <- sqlTables(conn, tableType = "TABLE", schema = myschema, tableName =table)
      if (nrow(out)>0) {
        err <- sqlDrop (conn, paste(myschema,".",table,sep=""), errors=FALSE)  
        if (err==-1){
          cat("An error has occurred.\n")
          err.msg <- odbcGetErrMsg(conn)
          for (error in err.msg) {
            cat(error,"\n")
          }
        } else {
          cat ("Table: ",  myschema,".",table," was dropped\n")
        }
      } else {
          cat ("Table: ",  myschema,".",table," does not exist\n")
      }
    }

df1 <- sqlQuery(conn, "CREATE TABLE BOARD (
                            B_ID CHAR(6) NOT NULL, 
                            B_NAME VARCHAR(75) NOT NULL, 
                            TYPE VARCHAR(50) NOT NULL, 
                            LANGUAGE VARCHAR(50), 
                            PRIMARY KEY (B_ID))", 
                errors=FALSE)

if (df1 == -1){
  cat ("An error has occurred.\n")
  msg <- odbcGetErrMsg(conn)
  print (msg)
} else {
  cat ("Table was created successfully.\n")
}

df2 <- sqlQuery(conn, "CREATE TABLE SCHOOL (
                  B_ID CHAR(6) NOT NULL, 
                  S_ID CHAR(6) NOT NULL, 
                  S_NAME VARCHAR(100), 
                  LEVEL VARCHAR(70), 
                  ENROLLMENT INTEGER WITH DEFAULT 10,
                  PRIMARY KEY (B_ID, S_ID))", errors=FALSE)

if (df2 == -1){
  cat ("An error has occurred.\n")
  msg <- odbcGetErrMsg(conn)
  print (msg)
} else {
  cat ("Table was created successfully.\n")
}

tab.frame <- sqlTables(conn, schema=myschema)
nrow(tab.frame)
tab.frame$TABLE_NAME

for (table in tables){  
        cat ("\nColumn info for table", table, ":\n")
        col.detail <- sqlColumns(conn, table)
        print(col.detail[c(4,6,7,18)], row.names=FALSE)
}

boarddf <- read.csv("board.csv", header = FALSE)

head(boarddf)

sqlSave(conn, boarddf, "BOARD", append=TRUE, fast=FALSE, rownames=FALSE, colnames=FALSE, verbose=FALSE)

schooldf <- read.csv("school.csv", header = FALSE)

head(schooldf)

schooldf$V3 <- iconv(schooldf$V3, "latin1", "ASCII//TRANSLIT")

sqlSave(conn, schooldf, "SCHOOL", append=TRUE, fast=FALSE, rownames=FALSE, colnames=FALSE, verbose=FALSE)

boarddb <- sqlFetch(conn, "BOARD")
tail(boarddb)

schooldb <- sqlFetch(conn, "SCHOOL")
tail(schooldb)

library(ggplot2);

elequery <- query <- paste("select s.enrollment as ENROLLMENT 
from school s, board b 
where b.b_name = 'Toronto DSB' and b.b_id=s.b_id 
and s.level = 'Elementary' 
order by enrollment desc")

eledf <- sqlQuery(conn, elequery)
dim(eledf)

qplot(ENROLLMENT, data=eledf, geom="density",  main="TDSB School Size - Elementary")

secquery <- paste("select s.enrollment as ENROLLMENT 
from school s, board b 
where b.b_name = 'Toronto DSB' and b.b_id=s.b_id 
and s.level = 'Secondary' 
order by enrollment desc")

secdf <- sqlQuery(conn, secquery)

qplot(ENROLLMENT, data=secdf, geom="density", main="TDSB School Size - Secondary")

denquery <- paste("select b.b_name, s.s_name, level as LEVEL, enrollment 
 from board b, school s where b.b_id = s.b_id and b.b_name = 'Toronto DSB'")

dendf <- sqlQuery(conn, denquery)

dendf$LEVEL <- as.factor(dendf$LEVEL)
boxplot(ENROLLMENT ~ LEVEL, dendf, names =c("Secondary","Elementary"), main="Toronto DSB")

close(conn)
