"""
OVERVIEW: This SQL query identifies the last person who can board a bus without exceeding a 1000-kilogram 
weight limit using a Common Table Expression (CTE). The CTE, cumulative_table, calculates the cumulative sum 
of weights for each person and all preceding people by self-joining the Queue table on the turn column. The main 
query selects the person_name from the CTE where the cumulative weight is less than or equal to 1000 kilograms, 
ordered by cumulative weight in descending order, and limits the result to one entry. This identifies the last 
person who can board without surpassing the weight limit.
"""
-- This CTE includes a cumulative sum of weight between each person and everyone that's boarded before them
WITH cumulative_table AS 
(
SELECT q1.person_name, q1.turn, SUM(q2.weight) AS cumulative_weight
FROM Queue q1 JOIN Queue q2
ON q1.turn >= q2.turn
GROUP BY q1.turn
ORDER BY q1.turn
)
-- From that CTE I locate the last person to board before the cumulative_weight goes over 1000 
SELECT person_name
FROM cumulative_table
WHERE cumulative_weight <= 1000
ORDER BY cumulative_weight DESC
LIMIT 1

/* DIRECTIONS 

Table: Queue
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.
 

There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

The result format is in the following example.


Example 1:

Input: 
Queue table:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+
Output: 
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+
Explanation: The folowing table is ordered by the turn for simplicity.
+------+----+-----------+--------+--------------+
| Turn | ID | Name      | Weight | Total Weight |
+------+----+-----------+--------+--------------+
| 1    | 5  | Alice     | 250    | 250          |
| 2    | 3  | Alex      | 350    | 600          |
| 3    | 6  | John Cena | 400    | 1000         | (last person to board)
| 4    | 2  | Marie     | 200    | 1200         | (cannot board)
| 5    | 4  | Bob       | 175    | ___          |
| 6    | 1  | Winston   | 500    | ___          |
+------+----+-----------+--------+--------------+
*/
