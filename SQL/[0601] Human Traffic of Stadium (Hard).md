# Overview

In this SQL query, I find records from the `Stadium` table where there are three or more consecutive rows  
with people counts greater than or equal to 100. I first create a CTE that uses window functions to get  
the `people` count for the two preceding and two succeeding records for each row. This enables testing  
for sequences where the current row, along with the next two or previous two, has `people` counts meeting  
the threshold. The main query then filters for rows that meet one of three patterns of three consecutive  
counts greater than or equal to 100, ordering results by `visit_date` in ascending order.

```sql
-- This CTE gets the number of people in the 2 records before (lagging) and 2 records after (leading)
-- so that in the main query we can test for if there are 3+ consecutive records of people>= 100
with cte as(
    select 
        id,
        visit_date,
        people,
        lead(people, 1) over(order by id) as lead1,
        lead(people, 2) over(order by id) as lead2,
        lag(people,1) over(order by id) as lag1,
        lag(people, 2) over(order by id) as lag2
    from Stadium
)
-- Main query 
select 
    id,
    visit_date,
    people
from cte 

-- Current people always has to be >= 100
where people >= 100 

-- Then one of the following lines must evaluate to True for there to be 3 consecutive >= 100
and ((lead1 >= 100 and lead2 >= 100)  -- Option 1: Two leads >= 100
or (lag1 >= 100 and lag2 >= 100)      -- Option 2: Two lags >= 100
or (lag1 >= 100 and lead1 >= 100))    -- Option 3: One lead and one lag >= 100
```

# Directions

Table: Stadium

| Column Name | Type |
|-------------|------|
| id          | int  |
| visit_date  | date |
| people      | int  |

`visit_date` is the column with unique values for this table. Each row of this table contains the  
visit date and visit ID to the stadium with the number of people during the visit. As the `id`  
increases, the date increases as well.

Write a solution to display the records with three or more rows with consecutive IDs, and the  
number of people is greater than or equal to 100 for each. Return the result table ordered by  
`visit_date` in ascending order.

Example 1:

Input: 

Stadium table:

| id | visit_date | people |
|----|------------|--------|
| 1  | 2017-01-01 | 10     |
| 2  | 2017-01-02 | 109    |
| 3  | 2017-01-03 | 150    |
| 4  | 2017-01-04 | 99     |
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-09 | 188    |

Output: 

| id | visit_date | people |
|----|------------|--------|
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-09 | 188    |

Explanation:  
The four rows with ids 5, 6, 7, and 8 have consecutive IDs, and each of them has >= 100 people attended.  
Note that row 8 was included even though the `visit_date` was not the next day after row 7. The rows  
with ids 2 and 3 are not included because we need at least three consecutive IDs.
