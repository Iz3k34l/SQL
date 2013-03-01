--Begin the create and insertions of the stats table	
create table #statsTable(
	s_fullname char(45),
	s_dialdate smalldatetime,
	s_campaign char(3),
	s_calls int,
	s_holdtime int,
	s_talktime int,
	s_wrapuptime int ,
	s_dialtime int ,
	s_pitches int ,
	s_agent char(3) ,
	s_samount decimal(20,2),
	s_damount decimal(10,2) ,
	s_upamount numeric (10,0),
	s_mdamount decimal (12,2))
--End the creation of the stats temp table

INSERT  INTO #statsTable (s_fullname, s_agent, s_calls, 
				s_holdtime, s_talktime, s_wrapuptime, s_pitches, s_dialtime, s_campaign,
				s_dialdate)
	select agent.name, agent.code, calls, holdtime, 
				talktime, wrapuptime, pitches, dialtime, campaign,
				dialdate  
			from stats,agent 
			where agent.code like stats.agent AND  dialdate = '02-27-2013'
			
	INSERT INTO  #statsTable (s_dialdate, s_samount ,
					   s_damount , s_upamount,
				       s_mdamount)
			SELECT  results_NFP.lcdate, results_NFP.s__amount, results_NFP.D_AMOUNT,
					results_nfp.UP_ASK, results_NFP.md_amount
					     
					FROM results_NFP, #statsTable  
  
					WHERE s_dialdate = results_NFP.lcdate AND lcdate = '02-27-2013' AND results_NFP.campaignid = s_campaign 

  
			
			
			
			

UPDATE #statsTable SET s_dialdate = results_NFP.lcdate, s_samount = results_NFP.s__amount,
					   s_damount = results_NFP.d_amount, s_upamount = results_NFP.up_amount,
				       s_mdamount  = results_NFP.md_amount

					FROM results_NFP, #statsTable  
  
					WHERE s_dialdate = results_NFP.lcdate AND lcdate = '02-27-2013'

  



	
 	

				   
DROP TABLE #statsTable


SELECT * FROM #statsTable where s_agent = 'rnx' AND s_dialdate = '02-27-2013'
SELECT dialdate, agent, calls, holdtime, talktime, wrapuptime,dialtime, pitches FROM stats where agent = 'rnx' AND dialdate = '02-27-2013'
SELECT lcdate, campaignid, agentid, s__amount, D_AMOUNT, UP_AMOUNT,MD_AMOUNT FROM results_nfp where (agentid = 'rnx' AND lcdate = '02-27-2013')

