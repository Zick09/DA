--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select 
    t2.name as Department, 
    t1.name as Employee, 
    salary 
from (
    select
        id,
        name,
        salary,
        departmentid,
        row_number()over(partition by DepartmentId order by salary desc) as r
    from Employee) t1
inner join Department t2
on t1.departmentid=t2.id
where r<=3

--task2  (lesson8)

-- https://sql-academy.org/ru/trainer/tasks/17
SELECT 
    member_name,
    status,
    costs
from FamilyMembers t1
inner join (
SELECT
    family_member,
    sum(unit_price*amount) as costs
from Payments t1
inner join FamilyMembers t2
on t1.family_member=t2.member_id
where date >= date'2005-01-01' and date<=date'2005-12-31'
group by family_member
) t2
on t1.member_id=t2.family_member

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select distinct t1.name 
from Passenger t1
inner join Passenger t2
on t1.name=t2.name and t1.id<>t2.id

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count(*) as count from Student
where first_name = 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

SELECT count(classroom) as count 
from Schedule
where date = date'2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

см. task4

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT floor(AVG(floor(datediff(current_date,birthday)/365.25))) as age
FROM FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

SELECT 
    good_type_name,
    sum(unit_price*amount) as costs
from Goods t1
inner join Payments t2
on t1.good_id=t2.good
inner join GoodTypes t3
on t1.type=t3.good_type_id
where date>=date'2005-01-01' and date<=date'2005-12-31'
group by type

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

SELECT MIN(age) as year 
FROM (SELECT floor(datediff(current_date,birthday)/365.25) as age
FROM Student) a

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

SELECT max(floor(datediff(current_date,birthday) / 365.25)) as max_year
FROM Class t1
INNER JOIN Student_in_class t2
ON t1.id=t2.class
INNER JOIN Student t3
ON t2.student=t3.id
WHERE t1.name LIKE '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

SELECT 
    status,
    member_name,
    sum(unit_price*amount) as costs
from Payments t1
inner join Goods t2
ON t1.good=t2.good_id
inner join GoodTypes t3
ON t2.type=t3.good_type_id
inner join FamilyMembers t4
on t1.family_member=t4.member_id
where good_type_name = 'entertainment'
GROUP BY family_member

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from Company
where id in (
select 
    company
from Trip
GROUP BY company
HAVING COUNT(*) = (
select min(cnt) as m_cnt from(
SELECT 
    company,
    count(*) over(partition by company) as cnt
from Trip) a))

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select classroom
from Schedule
GROUP BY classroom
having count(*) = (
select max(cnt) from (
SELECT 
    classroom,
    count(*)over(partition by classroom) as cnt
FROM Schedule) a)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select t3.last_name 
from Schedule t1
inner join Subject t2
on t1.subject=t2.id
inner join Teacher t3
on t1.teacher=t3.id
where t2.name = 'Physical Culture'
order by last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

SELECT concat(last_name,'.',LEFT (first_name,1),'.',LEFT (middle_name,1),'.') as name FROM Student
order by name
