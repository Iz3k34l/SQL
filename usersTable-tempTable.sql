--Begin the create the temp name table
CREATE table #nameTable(
	n_fullname char(45) not null,
	n_agentid char(3) not null)

INSERT into #nameTable (n_fullname, n_agentid)
	SELECT agent.name, agent.code  from agent
--end of the name table creation and population

--Begin the create and insertions of the stats table	
create table #statsTable(
    s_dialdate smalldatetime not null,
	s_campaign char(3) not null,
	s_calls int not null,
	s_holdtime int not null,
	s_talktime int not null,
	s_wrapuptime int not null,
	s_dialtime int not null,
	s_pitches int not null,
	s_agent char(3) not null)

INSERT into #statsTable (s_agent, s_dialdate, s_campaign, s_calls, 
                         s_holdtime, s_talktime, s_wrapuptime,
						  s_dialtime, s_pitches)
	SELECT  agent, dialdate, campaign, calls, holdtime, talktime, wrapuptime,
           dialtime, pitches from stats
--End the creation and insertion of the stats temp table

--Begin the creations and insertion of the results table
create table #resultsTable(
    r_lcdate smalldatetime not null,
	r_termcd char(2) not null,
	r_agentid char(3) not null,
	r_samount decimal(20,2) not null,
	r_damount decimal(10,2) not null,
	r_upamount numeric (10,0) not null,
	r_mdamount decimal (12,2) not null)

INSERT INTO #resultsTable (r_lcdate, r_termcd, r_agentid, 
							r_samount,r_damount, r_upamount, r_mdamount)
   SELECT lcdate, termcd, agentid, s__amount, D_AMOUNT, UP_AMOUNT, MD_AMOUNT 
          FROM results_NRF  where 
		lcdate = '02-27-2013' AND  agentid != ''
--End of the creation and insertion of the results table     


--Begin creation of the users table wich will compile all the data from the above table and 
--make the data available globaly
create table ##usersTable(
	u_agent char(3) not null,            --this is theagent id
	u_fullname char(45) not null,	     --This is the agent full name
    u_dialdate smalldatetime not null,   --This is the date last dialed
	u_campaign char(3) not null,         --This is the Campaign 3 character ID
	u_calls int not null,                --This is the number of call per campaign, per user
	u_holdtime int not null,
	u_talktime int not null,
	u_wrapuptime int not null,
	u_dialtime int not null,
	u_pitches int not null,
	u_samount decimal(18,2) not null,
	u_damount decimal(10,2) not null,
	u_upamount decimal(18,2) not null,
	u_mdamount decimal(12,2) not null)


INSERT into ##usersTable (u_agent, u_fullname, u_dialdate, u_campaign, u_calls, 
                         u_holdtime, u_talktime, u_wrapuptime,
						  u_dialtime, u_pitches, u_samount,u_damount,u_upamount, u_mdamount)
	SELECT  #statsTable.s_agent, #nameTable.n_fullname, #statsTable.s_dialdate,
		    #statsTable.s_campaign, 
			sum(#statsTable.s_calls) as sumCalls,
			SUM(#statsTable.s_holdtime) as sumHoldtime,
			SUM(#statsTable.s_talktime) as sumTalktime,
			SUM(#statsTable.s_wrapuptime) as sumWrapuptime,
			SUM(#statsTable.s_dialtime) as sumDialtime,
			SUM(#statsTable.s_pitches) as sumPitches,
			SUM(results_NRF.s__amount) as sumSmount,
			sum(results_NRF.D_AMOUNT) as sumDamount,
			SUM(results_NRF.UP_AMOUNT) as sumUpamount, 
			sum(results_NRF.MD_AMOUNT) as sumMdamount    
		
		from  #statsTable
			join #nameTable 
			on #statsTable.s_agent = #nameTable.n_agentid
			JOIN results_NRF 
			ON #statsTable.s_agent = results_NRF.agentid

where s_dialdate = '02-27-2013'  

GROUP BY s_dialdate,s_campaign,  s_agent, n_fullname ORDER BY sum(results_NRF.UP_AMOUNT) DESC
			
--End of the creation and insertion of the Users table data
--I may insert a drop table operator here to dump the other tables once the users
--table is populated.

	

   


--test area
SELECT * FROM ##usersTable where u_dialdate = '02-27-2013' AND  u_agent = 'rnx'
	
SELECT s_agent, sum(s_calls) as sumCalls, 
	SUM(s_holdtime) as SumHoldtime,
	SUM(s_talktime) as sumTalktime,
	SUM(s_wrapuptime) as sumWrapuptime,
	SUM(s_dialtime) as sumDialtime,
	SUM(s_pitches) as sumPitches

 FROM #statsTable where 
		s_dialdate = '02-27-2013' AND  
		 
		s_agent = 'rnx'
GROUP BY s_agent 

SELECT * FROM stats where 
		dialdate = '02-27-2013' AND  agent = 'rnx'

<!-- drop tables before end of session-->
DROP TABLE #nameTable, #statsTable, #resultsTable, ##usersTable