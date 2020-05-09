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
--100万件 ⇒ 11秒くらい。
DECLARE @insert_count Bigint 
SELECT @insert_count = 1000000; 
WITH Base AS
  (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Base WHERE n < @insert_count
  ),
  Nums AS
  (
    SELECT Row_Number() OVER(ORDER BY n) AS n FROM Base
  )
  
  INSERT INTO customer 
  　SELECT SYSDATETIME ()
           ,SYSDATETIME ()
           ,1
           ,1
           ,'customer.taro'
           ,'customer.taro'
           ,'29'
   　FROM Nums  WHERE n <= @insert_count

OPTION (MaxRecursion 0); 
