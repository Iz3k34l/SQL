DECLARE @nameTable table (
	n_fullname char(45) not null,
	n_agentid char(3) not null)

INSERT into @nameTable (n_fullname, n_agentid)
	SELECT agent.name, agent.code  from agent
	
DECLARE @statsTable table (
    n_dialdate smalldatetime not null,
	n_campaign char(3) not null,
	n_calls int not null,
	n_holdtime int not null,
	n_talktime int not null,
	n_wrapuptime int not null,
	n_dialtime int not null,
	n_pitches int not null,
	n_agent char(3) not null)

INSERT into @statsTable (n_agent, n_dialdate, n_campaign, n_calls, 
                         n_holdtime, n_talktime, n_wrapuptime,
						  n_dialtime, n_pitches)
	SELECT  agent, dialdate, campaign, calls, holdtime, talktime, wrapuptime,
           dialtime, pitches from stats


SELECT TOP 5 * FROM @statsTable where n_agent !=''
	

