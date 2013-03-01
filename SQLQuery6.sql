select * from stats WHERE agent = 'txy';
(SELECT SUM(calls) FROM stats where agent = 'txy' and dialdate ='2013-02-20 00:00:00')

