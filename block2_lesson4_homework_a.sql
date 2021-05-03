--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
create view all_products_flag_300 as (
	select model, price,
		case 
			when price > 300 then 1
			else 0
		end flag
	from (
		select model,price from pc
		union all
		select model,price from laptop 
		union all
		select model,price from printer
		) a
)

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
-- тот случай когда WITH пригодился)
create view all_products_flag_avg_price as (
	with a as 
		(select model,price from pc
		union all
		select model,price from laptop 
		union all
		select model,price from printer)
	select distinct 
		model, price,
		case 
			when price > (select avg(price) from a) then 1
			else 0
		end flag
	from a)

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create view count_products_by_makers as (
	select
		maker,
		count(*) as cnt
	from product
	group by maker)

--task7 (lesson4)
-- По предыдущему iew (count_products_by_makers) сделать график в colab (X: maker, y: count)

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as (
	select * from printer);

delete from printer_updated
where model in (select model from product where maker = 'D' and type = 'Printer');

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
create view printer_updated_with_makers as (
	select
		t1.*, maker
	from printer_updated t1
	inner join product t2
	on t1.model=t2.model)

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
create view sunk_ships_by_classes as (
	select
		coalesce (class,'0') as class,
		count(*)
	from ships t1
	right join outcomes t2
	on t1.name=t2.ship
	where result = 'sunk'
	group by class)

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

	
--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
create view classes_with_flag as (
	select 
		*,
		case
			when bore >=9 then 1
			else 0
		end flag
	from classes)


--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
	
--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
