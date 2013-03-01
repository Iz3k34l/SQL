 

DECLARE @nameTable table (
	n_fullname char(45) not null,
	n_agentid char(3) not null)

INSERT into @nameTable (n_fullname, n_agentid)
	SELECT agent.name, agent.code  from agent
	



SELECT TOP 5 * FROM @nameTable
	

