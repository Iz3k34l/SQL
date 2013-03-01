DECLARE @flag int
	SET  @flag = 1
		WHILE (@flag < 10)
begin 
begin
print @flag
	SET @flag  = @flag +1
end

IF (@flag > 5)
	BREAK
ELSE
continue
END 

	select agentid, sum(callcount) as sumcalls,sum(s__amount) as sumAmount, sum(D_AMOUNT) as sumDamount, 
		sum(UP_AMOUNT) sumUpamount, sum(MD_AMOUNT) as sumMDamount
		FROM results_c01
		where lcdate = '02-28-2013' and agentid != '' GROUP BY agentid ORDER BY SUM(up_amount) DESC  
	
		results_NRF or results_c01 or 
end
Print 'its all done'

SELECT u_agent, u_fullname, SUM(u_calls) as sumCalls,
	   SUM(u_holdtime) as sumHoldtime, SUM(u_talktime) as sumTalktime, SUM(u_wrapuptime) as sumWrapuptime,
       SUM(u_dialtime) as sumDialtime, SUM(u_pitches) as sumPitches FROM ##usersTable where u_dialdate = '02-28-2013'
	   GROUP BY u_agent, u_fullname ORDER BY SUM(u_wrapuptime) ASC, sum(u_dialtime) DESC