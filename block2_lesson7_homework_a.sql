--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко
create table table1 as (
	select 
		generate_series(1,1000) as id, 
		cast((random ()*1000) as int) as column1,
		cast((random ()*1000) as int) as column2,
		cast((random ()*1000) as int) as column3
);

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select distinct t1.email from Person t1
inner join Person t2
on t1.id<>t2.id
and t1.email=t2.email;

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select t1.name as Employee 
from Employee t1
inner join Employee t2
on t1.ManagerId=t2.id
and t1.salary>t2.salary;

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

select 
    score,
    dense_rank()over(order by score desc) as rank
from Scores;

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select firstname, lastname, city, state from Person t1
left join address t2
on t1.personid=t2.personid;
