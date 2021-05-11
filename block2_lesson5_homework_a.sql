--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов
-- на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

create view pages_all_products as (
select
	model,
	case when num%2=0 then num/2 else num/2+1 end page_num,
	total
from (
select
	t1.model,
	row_number ()over(order by t1.model) as num,
	count(*)over()as total
from product t1
inner join (
select model from pc
union
select model from printer
union
select model from laptop
) t2
on t1.model=t2.model) a)

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу 
--устройства. Вывод: производитель,
create view distribution_by_type as (
	select distinct
		type,
		cast(cast(count(*)over(partition by type)as numeric)/cast(count(*)over() as numeric) as numeric(5,2)) as rat
	from product)

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму

--select * from distribution_by_type

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов

create table ships_two_words as (
	select * from ships 
	where name like '% %'
)

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select * 
from ships
where class is null
and name like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

select * from (
	select
		t1.model,
		price,
		avg(price)over(partition by t1.type='D') as avg_price_d
	from product t1
	inner join printer t2
	on t1.model=t2.model
	where maker = 'A') a
where price > avg_price_d