# Week 8 SQL and R

install.packages("DBI")
install.packages("RSQLite")

drv = dbDriver("SQLite")
chinook_db = dbConnect(drv, dbname = "~/Documents/PSTAT 10 /Chinook_Sqlite (1).sqlite")
#an object in R, it's just a persistent connection that connect to database
dbListTables(chinook_db) 

dbListFields(chinook_db, "Customer")

#Importing a table as a data frame
customer = dbReadTable(chinook_db, "Customer")
class(customer)

dim(customer)

dbGetQuery(chinook_db, 
           'select CustomerID, FirstName, LastName, City, Country
           from Customer
           limit 6')
#the below code gives error, needs ""
customer[1:6, c('CustomerID', 'FirstName', 'LastName', 'City', 'Country')]

customer[1:6, c("CustomerId", "FirstName", "LastName","City", "Country")]

dbGetQuery(chinook_db, 
           'select CustomerID, FirstName, LastName, City, Country
           from Customer 
           ORDER BY FirstName DESC 
           limit 10')
dbDisconnect(chinook_db)
# express relational information between tables. 
dbGetQuery(chinook_db, "pragma table_info(Customer)")
# NVARCHAR is a database data type, not in R

dbExecute(chinook_db,
          paste("insert into customer",
                "(CustomerId, FirstName, LastName, Email)",
                "values",
                "(1, 'Luis','Armstrong','LuisArmstrong@pstat.ucsb.edu')"))
dbGetQuery(chinook_db, 
           "pragma foreign_key_list(customer)")
# supportive ID from customer data points to employee id in employee table 

#Foreign keys must either point to an existing value or be NULL

dbGetQuery(chinook_db, "select max(EmployeeId) from employee")

dbExecute(chinook_db,
          "insert into customer
          (CustomerId, FirstName, LastName, Email, SupportRepId)
          values
          (888, 'Luis', 'Armstrong',
          'luisArmstrong@pstat.ucsb.edu', 88)")
# 888 is not part of the foreign key


################################################################################

#Week 9

dbGetQuery(chinook_db,
           "SELECT TrackId, Name, AlbumId, Milliseconds, Bytes, UnitPrice
FROM track
limit 5")

dbGetQuery(chinook_db,
           "SELECT AlbumId, MediaTypeId,AVG(Bytes) as AvgBytes
FROM Track
WHERE AlbumId <= 160
GROUP BY AlbumId
ORDER BY AvgBytes DESC
LIMIT 10")

dbGetQuery(chinook_db,
           "SELECT AlbumId, MediaTypeId,AVG(Bytes) as AvgBytes
FROM Track
WHERE AlbumId >= 160
GROUP BY AlbumId
HAVING AvgBytes >= 25000000
ORDER BY AVG(Bytes) DESC
LIMIT 10")

dbGetQuery(chinook_db,
           "SELECT AlbumId, MediaTypeId,AVG(Bytes) as AvgBytes
FROM Track
WHERE AlbumId >= 160 AND AvgBytes >= 25000000
GROUP BY AlbumId
ORDER BY AVG(Bytes) DESC
LIMIT 10") # Error 

# Having clause is used to impose condition on GROUP function and is used after 
# GROUP BY clause in the query

dbGetQuery(chinook_db, "select TrackId, Name, Track.AlbumId, Title
from Track inner join Album
on Track.AlbumId = Album.AlbumId
where Track.AlbumId = 250
limit 10")

dbGetQuery(chinook_db, "SELECT TrackId, Track.Name, AlbumId, MediaType.MediaTypeId, 
           MediaType.Name From Track inner join MediaType 
           on Track.MediaTypeId = MediaType.MediaTypeId
           WHERE AlbumId = 10
           limit 10")
dbGetQuery(chinook_db, "SELECT * From Track inner join MediaType 
           on Track.MediaTypeId = MediaType.MediaTypeId
           WHERE AlbumId = 10
           limit 10")
dbGetQuery(chinook_db, "SELECT trackid, Track.Name, AlbumId, MediaType.MediaTypeId, 
           MediaType.Name From Track inner join MediaType 
           on Track.MediaTypeId = MediaType.MediaTypeId
           WHERE AlbumId = 10
           limit 10")

dbGetQuery(chinook_db,
           "select TrackId, Track.Name, Track.AlbumId, Title, Artist.Name
from Track
inner join Album on Track.AlbumId = Album.AlbumId
inner join Artist on Album.ArtistId = Artist.ArtistId
where Track.AlbumId = 250
limit 5")

dbGetQuery(chinook_db,
           "select TrackId, t.Name as TrackName, t.AlbumId,
Title as AlbumTitle, g.Name as GenreName
from Track t
inner join Album al on t.AlbumId = al.AlbumId
inner join Genre g on t.GenreId = g.GenreId
where t.AlbumId = 250
limit 5")

################################################################################

dbExecute(tinyclothes, "insert into 
          customer(CUST_NO, NAME, ADDRESS)
          values('C7', 'Luis','Storke')")
dbGetQuery(tinyclothes, )
dbExecute(tinyclothes, "DELETE FROM CUSTOMER 
          WHERE NAME like 'l%'")
#Create new table
dbSendQuery(tinyclothes, "Create TABLE SOFT_TOYS
            (TOY_ID TEXT NOT NULL PRIMARY KEY,
            NAME TEXT,
            COLOR TEXT,
            PRICE TEXT)")
dbSendQuery(tinyclothes, "Create TABLE TOY_SUPPLIER
            (SUPPLIER_ID TEXT NOT NULL PRIMARY KEY,
            SUPPLIER_NAME TEXT,
            TOY_ID TEXT,
            FOREIGN KEY(TOY_ID) TEXT)")

dbGetQuery(tinyclothes,    
           "SELECT * FROM SALES_ORDER_LINE WHERE PROD_NO IN ('p1','p2','p3')")
dbGetQuery(tinyclothes,    
           "SELECT * FROM SALES_ORDER_LINE")
dbGetQuery(tinyclothes, "Select prod_no, name, color from product order by prod_no desc")
dbGetQuery(tinyclothes, "Select prod_no, name, color from product order by 1 desc")
dbGetQuery(tinyclothes, "Select name, prod_no, color from product order by prod_no desc")

dbGetQuery(chinook_db,
           "SELECT count(*) FROM Track GROUP BY AlbumID WHERE AlbumID = 3")


My_function <- function (a){ 
  for (i    in    1:a) { 
    b <-  i^2       
    print(b)}  
  }  
My_function(4) 

dbGetQuery(tinyclothes, 'SELECT  ORDER_NO, SUM(QUANTITY) 
           FROM INVOICES' ) 

dbGetQuery(tinyclothes, 'SELECT  ORDER_NO, quantity FROM INVOICES' ) 

dbGetQuery(tinyclothes, 'SELECT  ORDER_NO, SUM(QUANTITY) 
           FROM INVOICES  GROUP BY ORDER_NO' ) 


a <- c(1,2,3,4)
b <- 10:13

(b-a)^2 /12

dbListTables(chinook_db)

dbQuery()





