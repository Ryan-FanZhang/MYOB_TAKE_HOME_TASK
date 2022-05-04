WITH Event_define AS (
	SELECT
		b.userid,
		b.TIMESTAMP AS event_start,
		c.TIMESTAMP AS event_end,
		timestampdiff( MINUTE, b.TIMESTAMP, c.TIMESTAMP ) AS event_length 
	FROM
		oip_events b
		LEFT JOIN oip_events c ON b.userid = c.userid 
	WHERE
		b.action = 'applicationStarted' 
		AND b.TIMESTAMP <= c.TIMESTAMP 
		AND c.action = 'applicationCompleted' 
		AND timestampdiff( MINUTE, b.TIMESTAMP, c.TIMESTAMP ) <= 60 /* assume a successful subscription should finish in 1 hour*/	
	ORDER BY
		1,
		2 
	),
	session_event AS (
	SELECT
		a.userid,
		DATE_format( a.TIMESTAMP, '%Y%M' ) AS MONTH,
		timestampdiff( DAY, a.TIMESTAMP, e.event_start ) AS expo_sub_diff 
	FROM
		web_sessions a
		LEFT JOIN Event_define e ON a.userid = e.userid 
	WHERE
		a.source = 'Facebook' 
		AND a.campaign = 'OIP_campaign' 
		AND timestampdiff( DAY, a.TIMESTAMP, e.event_start ) <= 3 /* assume any success subscription after 3 days later counts on FB cam */
	ORDER BY
		a.userid,
		a.TIMESTAMP 
	) 
SELECT
	se.MONTH,
	COUNT( DISTINCT se.userid ) AS Uni_Sub,
	AVG(COUNT( DISTINCT se.userid )) OVER ( ORDER BY MONTH ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS Moving_3mon_Avg 
FROM
	session_event se 
GROUP BY
	se.MONTH 
ORDER BY
	1

  
  