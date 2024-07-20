"""
OVERVIEW: In this SQL query, I identify numbers that appear at least three times consecutively 
in the Logs table. The query first ensures that there are two subsequent IDs after the current 
ID, making it possible to check for three consecutive instances. It then checks if the numbers 
associated with the next two IDs match the number of the current ID. If both conditions are met, 
the number is included in the result set. The final output consists of distinct numbers that
meet the criteria of appearing consecutively at least three times.
"""
  
SELECT 
    DISTINCT num as ConsecutiveNums

FROM Logs

-- This makes sure there are two instances of IDs after
-- Otherwise it's not possible to have three consecutive
WHERE id + 2 IN (SELECT id FROM Logs)

-- These check if the next 2 IDs have the same num
AND (id + 1, num) IN (SELECT id, num FROM Logs)
AND (id + 2, num) IN (SELECT id, num FROM Logs);
-- If the both have that same num in that following 2 ID's
-- Values then that means there were 3 consective 

/* DIRECTIONS 

Table: Logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.
 
Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 
Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/
