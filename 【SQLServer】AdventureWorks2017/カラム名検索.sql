SELECT   SCHEMA_NAME(t.schema_id) AS SchemaName, 
	 T.name AS TableName,
         C.name AS ColumnName
FROM     sys.tables AS T
            INNER JOIN sys.columns AS C
               ON T.object_id = C.object_id
WHERE    C.name = 'CustomerID'
ORDER BY SchemaName,
	 TableName,
         ColumnName;