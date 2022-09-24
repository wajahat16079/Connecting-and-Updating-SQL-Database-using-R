

## Packages Required

library(RMySQL)


# Connecting to a database

## Credentials for Database 

## You need to fill your database connections here

host = "#####"
port = 1122
dbname = "#####"
user= "#####"
password = "#####"


source("credentials.R") 
# I am loading mine from this, you just need to set yours up there and need not to add this line of code



## Configuring connection with the database

cn <- dbConnect(drv      = RMySQL::MySQL(),
                username = user,
                password = password,
                host     = host,
                port     = port,
                dbname   = dbname)


## Check the connection
print(cn)

## Getting list of all the tables in the database
dbListTables(cn)


## Loading a table from the database 
## (Paste a SQL Query inside the quotes)

PlayerData <- dbGetQuery(cn, "SELECT * FROM PlayerData;")

## Looking at the column names of the table
names(PlayerData)

## Updating the table 

## (Use SQL Query for update)
Query = paste0("UPDATE PlayerData SET password = '","HelloWorld123",
               "' WHERE playerid = ",1,";")

## It is imporatnat to add "'" around strings

print(Query)

## send the query to the database
dbSendQuery(cn,Query)

## See whether the database was updated or not
PlayerDataUpdated <- dbGetQuery(cn, "SELECT * FROM PlayerData;")


## Add a new row in the table

Query = paste0("INSERT INTO PlayerData (username,password,playerid)",
               " VALUES( '","Viz IT (1)","','","SeeMoreToDoMore(1)","', '",13,"');")


print(Query)

dbSendQuery(cn,Query)

## See whether the database was updated or not

PlayerDataUpdated1 <- dbGetQuery(cn, "SELECT * FROM PlayerData;")




## Disconnecting from the database

dbDisconnect(cn)


## if you want to kill all the opened connection use this

## load function
killDbConnections <- function () {
  
  all_cons <- dbListConnections(MySQL())
  
  print(all_cons)
  
  for(con in all_cons)
    +  dbDisconnect(con)
  
  print(paste(length(all_cons), " connections killed."))
  
}

killDbConnections()

# Music: https://creativecommons.org/licenses/by/4.0/






