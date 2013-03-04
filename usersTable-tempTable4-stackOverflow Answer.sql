INSERT  INTO #statsTable 
            (
            s_fullname, 
            s_agent, 
            s_calls, 
            s_holdtime, 
            s_talktime, 
            s_wrapuptime, 
            s_pitches, 
            s_dialtime, 
            s_campaign,
            s_dialdate,
            s_upamount  --<<new
            )
SELECT      agent.name, 
            agent.code, 
            calls, 
            holdtime, 
            talktime, 
            wrapuptime, 
            pitches, 
            dialtime, 
            campaign,
            dialdate,
            r.UP_AMOUNT      --<<like this?  
FROM    "stats" s
            INNER JOIN agent a 
                ON s.agent = a.code
            INNER JOIN results_a03 r 
                ON s.campaign  = r.campaignid  
WHERE   dialdate = '02-27-2013';


SELECT * 
FROM #statsTable;