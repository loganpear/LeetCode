"""
OVERVIEW: In this SQL query, I determine the prices of all products as of 2019-08-16 by using a Common Table Expression (CTE)
and a UNION operation. I first create a CTE called pre_max_date to identify the latest date before or on 2019-08-16
for each product. This is achieved by selecting the maximum change date for each product that is on or before the specified
date. The main query then selects the product IDs and their corresponding prices from the products table where the change
date matches the date in the CTE. Finally, the UNION operation ensures that products without any prior specified price are
assigned a default price of 10. The resulting output consists of all product IDs along with their respective prices
as of 2019-08-16.
"""
-- CTE for only the latest date before or at 2019-08-16 for each product_id
WITH pre_max_date AS 
(
    SELECT 
        product_id, 
        MAX(change_date) AS pre_date
    FROM products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)
-- Selects records from the product table where the record is on the latest date before or at 2019-08-16   
SELECT 
    p.product_id,  
    p.new_price AS price
FROM products p 
JOIN pre_max_date pre
ON p.product_id = pre.product_id
AND p.change_date = pre.pre_date

-- Unions all products without prior specified price as 10
UNION 

SELECT 
    DISTINCT product_id,
    10 AS price
FROM products
WHERE product_id NOT IN (
    SELECT product_id 
    FROM pre_max_date); 

/* DIRECTIONS 

Table: Products
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/
