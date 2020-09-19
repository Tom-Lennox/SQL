-- 1億行のデータ処理、速度比較

use rel


--# ▼ ループ処理
10万件の処理に14秒。論外。
dbcc dropcleanbuffers
dbcc freeproccache
go

waitfor delay '00:00:02'

declare @start_count	int = 1
		--,@end_count		int = 10000000
		,@end_count		int = 100000
		,@start_time datetime = getdate()
		,@processed_time datetime = '1900-01-01 00:00:00.000'

while @start_count <= @end_count
begin
	INSERT INTO [dbo].[customer]
           ([sys_inserted_date]
           ,[sys_updated_date]
           ,[sys_condition_div]
           ,[sys_operation_div]
           ,[customer_name]
           ,[customer_name_kana]
           ,[customer_age])
     VALUES
           (SYSDATETIME ()
           ,SYSDATETIME ()
           ,1
           ,1
           ,'customer.taro'
           ,'customer.taro'
           ,'29')
	set @start_count = @start_count + 1;
end

set @processed_time = (getdate() - @start_time)

select format(@processed_time, 'mm:ss.fff') as '処理時間'

--delete from dbo.customer

--# ▼ 再帰クエリ
--# ▽ 再帰クエリでn分レコードがあるテーブルを作成する。
--# ▽ withで使い回せるようにする。

--100万件	⇒ 1秒
--1000万件	⇒ 16秒
declare @insert_count int 
set @insert_count = 1000000; 
with kari as
  (
    select 1 as n
    union all
    select n+1 from kari where n < @insert_count
  )
  insert into customer 
  　select SYSDATETIME ()
           ,SYSDATETIME ()
           ,1
           ,1
           ,'customer.taro'
           ,'customer.taro'
           ,'29'
	from kari where n <= @insert_count

option (MaxRecursion 0); 

--# ▲ 再帰クエリ
print(row_number() over 1)
--# ▼ 再帰クエリ(2)
-- ※再帰上限を変更しても処理できない。
declare @insert_count bigint 
set @insert_count = 100000; 

WITH Base AS
  (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Base WHERE n < CEILING(SQRT(@insert_count))
  ),
  Expand AS
  (
    SELECT 1 AS C FROM Base AS B1, Base AS B2
  ),
  Nums AS
  (
    SELECT Row_Number() OVER(ORDER BY C) AS n FROM Expand
  )
  select * from Base
  insert into customer 
  　select SYSDATETIME ()
           ,SYSDATETIME ()
           ,1
           ,1
           ,'customer.taro'
           ,'customer.taro'
           ,'29'
	from Base where n <= @insert_count

OPTION (MaxRecursion 0); 
--# ▲ 再帰クエリ(2)


declare @insert_count int 
set @insert_count = 100000000; 
WITH Base AS
  (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Base WHERE n < CEILING(SQRT(@insert_count))
  ),
  Expand AS
  (
    SELECT 1 AS C FROM Base AS B1, Base AS B2
  ),
  Nums AS
  (
    SELECT Row_Number() OVER(ORDER BY C) AS n FROM Expand
  )
  select * from Base
 -- insert into customer 
 -- 　select SYSDATETIME ()
 --          ,SYSDATETIME ()
 --          ,1
 --          ,1
 --          ,'customer.taro'
 --          ,'customer.taro'
 --          ,'29'
	--from Base where n <= @insert_count

OPTION (MaxRecursion 30000); 