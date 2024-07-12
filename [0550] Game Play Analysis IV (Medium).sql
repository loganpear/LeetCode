"""
OVERVIEW: In this SQL query I calculate the fraction of players who logged in again on the day after their 
first login. I first identify each player's first login date using a subquery. 
It then joins this information with the Activity table to find instances where a player logged 
in on consecutive days. The final result is the count of players meeting this criterion divided by the
total number of distinct players in the Activity table.
"""
  
SELECT
    ROUND(COUNT(a1.player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity),2) AS fraction

FROM ( -- Subquery to find the first login date
    SELECT 
        player_id, 
        MIN(event_date) AS start_date 
    FROM Activity 
    GROUP BY player_id
) AS a1

-- Inner Join to join only first login dates 
JOIN Activity a2 ON a1.player_id = a2.player_id
-- Only show instances WHERE the player logged in the day after their first day
WHERE DATEDIFF(a2.event_date, a1.start_date) = 1;

/* DIRECTIONS 

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
*/
