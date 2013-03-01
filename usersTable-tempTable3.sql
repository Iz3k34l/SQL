--Begin the create and insertions of the stats table	
create table #statsTable(
	s_fullname char(45) not null,
	s_dialdate smalldatetime not null,
	s_campaign char(3) not null,
	s_calls int not null,
	s_holdtime int not null,
	s_talktime int not null,
	s_wrapuptime int not null,
	s_dialtime int not null,
	s_pitches int not null,
	s_agent char(3) not null,
	s_samount decimal(20,2) not null,
	s_damount decimal(10,2) not null,
	s_upamount numeric (10,0) not null,
	s_mdamount decimal (12,2) not null)

--End the creation of the stats temp table

--Begin the creations and insertion of the results table
create table #resultsTable(
    r_lcdate smalldatetime not null,
	r_termcd char(2) not null,
	r_agentid char(3) not null,
	r_samount decimal(20,2) not null,
	r_damount decimal(10,2) not null,
	r_upamount numeric (10,0) not null,
	r_mdamount decimal (12,2) not null)


--End of the creation of the results table
--Insert Data into both tables
--ResultsTable
INSERT INTO #resultsTable (r_lcdate, r_termcd, r_agentid, 
							r_samount,r_damount, r_upamount, r_mdamount)
   SELECT lcdate, termcd, agentid, s__amount, D_AMOUNT, UP_AMOUNT, MD_AMOUNT 
          FROM results_NRF  where 
		  agentid != '' and s__amount !='0.00'
--End of reults Table

--Insert into stats Table
INSERT into #statsTable (s_agent, s_fullname,  s_dialdate, s_campaign, s_calls, 
                         s_holdtime, s_talktime, s_wrapuptime,
						  s_dialtime, s_pitches, s_samount, s_damount, s_upamount, s_mdamount)

	SELECT  stats.agent, agent.name, dialdate, campaign, calls, holdtime, talktime, wrapuptime,
           dialtime, pitches,
		   SUM(r_samount) as sumSamount, 
		   SUM(r_damount) as sumDamount,
		   SUM(r_upamount) as sumUpmount,
		   SUM(r_mdamount) as SumMdamount
     from stats
		JOIN agent
			on stats.agent = agent.code
		JOIN #resultsTable
			on #statsTable.s_agent = #resultsTable.r_agentid
group BY r_agentid
--End of statsTable





--Test Area

SELECT #statsTable.s_fullname, sum(#statsTable.s_calls) as sumCalls,
		    SUM(#statsTable.s_holdtime) as sumHoldtime,
			SUM(#statsTable.s_talktime) as sumTalktime,
			SUM(#statsTable.s_wrapuptime) as sumWrapuptime,
			SUM(#statsTable.s_dialtime) as sumDialtime,
			SUM(#statsTable.s_pitches) as sumPitches,
			SUM(#resultsTable.r_samount) as sumSmount,
			sum(#resultsTable.r_damount) as sumDamount,
			SUM(#resultsTable.r_upamount) as sumUpamount, 
			sum(#resultsTable.r_mdamount) as sumMdamount 
	FROM #statsTable 
		join #resultsTable 
			on #statsTable.s_agent = #resultsTable.r_agentid
where r_lcdate = '02-27-2013' AND r_agentid = 'rnx'

GROUP BY #statsTable.s_fullname order BY SUM(r_upamount) DESC
     
--Working
SELECT  SUM(r_samount) as sumSamount, SUM(r_damount) as sumDamount,
		SUM(r_upamount) as sumUpmount,
		SUM(r_mdamount) as SumMdamount FROM #resultsTable  where r_lcdate = '02-27-2013'  
group BY r_agentid 
--End

drop TABLE  #statsTable, #resultsTable 