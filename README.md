# MYOB_TAKE_HOME_TASK

My mind about the SQL question: 
1)	A successful event should be finished in one hour, otherwise it will be automated closed. Because the payment usually require users to pay within a short time to avoid risks, like cyber-attack or the password leak:
In the first temporary table, Event_define, I used a self-join to query the successful events within one hour; 

2)	The users are exposed to campaign, which still can be affected in the following short time. So I define the users in the following 3 days who are driving to be successful applicant can be count on the FB campaign as well. 
In the second temporary table, session_event, I created a left join relationship between web_session table and Event_define table to query userId and the month which both meet the requirement. 

3)	The third temporary table, I query the month and number of unique applications.

4)	The moving average is a time series technique for analyzing and determining trends in data. According to the calculate formula, from three consecutive months—the month in question and the two previous month. So I use a window function, denoted with an OVER clause. As explained earlier, the rows are not collapsed, and each row has its own window over which a calculation is performed. The size of the window in this case is three. For each given row, I take the row itself and the two previous rows, and I calculate the average price from those three rows. This is denoted by the ROW keyword in the statement: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW. This statement says that, for each row in the table, something is calculated as an aggregation of the current and the previous two rows. This means that the moving average for each row is calculated as the mean value from the given day and the two previous months.

