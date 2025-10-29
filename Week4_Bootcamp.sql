-- 1050. Actors and Directors Who Worked Together in at Least 3 Movies
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;

-- 1667. Fix Names in a Table
SELECT 
    user_id,
    CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;

-- 175. Combine Two Tables
SELECT 
    Person.firstName,
    Person.lastName,
    Address.city,
    Address.state
FROM Person
LEFT JOIN Address
ON Person.personId = Address.personId;

-- 176. Second Highest Salary
SELECT 
    (SELECT DISTINCT salary
     FROM Employee
     ORDER BY salary DESC
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;


-- 1327. List the Products Ordered in a Period
SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100
ORDER BY unit DESC;

-- 1378. Replace Employee ID with the Unique Identifier
SELECT 
    euni.unique_id,
    e.name
FROM Employees e
LEFT JOIN EmployeeUNI euni
    ON e.id = euni.id;

-- 550. Game Play Analysis IV
SELECT
    ROUND(
        COUNT(DISTINCT player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY))
    IN (SELECT player_id, MIN(event_date) FROM Activity GROUP BY player_id);


-- 1075. Project Employees I
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- 185. Department Top Three Salaries
WITH RankedSalaries AS (
    SELECT 
        e.id,
        e.name AS Employee,
        e.salary,
        e.departmentId,
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
    FROM Employee e
)
SELECT 
    d.name AS Department,
    r.Employee,
    r.salary AS Salary
FROM RankedSalaries r
JOIN Department d
    ON r.departmentId = d.id
WHERE r.salary_rank <= 3
ORDER BY d.name, r.salary DESC;
