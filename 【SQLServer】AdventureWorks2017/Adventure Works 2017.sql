
use AdventureWorks2017
--構造理解の手順
--１▼主要tableをselect
--　｜SMMS使用の場合は、table右クリでslelect。
--２▼適宜joinを行う。

select
CustomerID,
*
from
Sales.Customer

select * from
Sales.SalesOrderHeader

select
* 
from
Sales.Customer

select
*
from
Sales.SalesOrderHeader
inner join Sales.Customer
on
Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID

