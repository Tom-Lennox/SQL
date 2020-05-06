-- 1億行のデータ処理、速度比較

use rel

dbcc dropcleanbuffers
dbcc freeproccache
go

waitfor delay '00:00:02'

declare @start_count int = 1
		,@end_count int = 1000000
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