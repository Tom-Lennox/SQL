
use AdventureWorks2017
--�\�������̎菇
--�P����vtable��select
--�@�bSMMS�g�p�̏ꍇ�́Atable�E�N����slelect�B
--�Q���K�Xjoin���s���B

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

