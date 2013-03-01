create table #campaign (
      c_name nvarchar(128) not null
)
INSERT INTO #campaign (c_name )
	SELECT TABLE_NAME  FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' 

SELECT * FROM #campaign where c_name LIKE 'result%'

DROP TABLE #campaign 