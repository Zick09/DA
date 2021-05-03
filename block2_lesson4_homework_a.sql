--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag
-- ��� ������ ����� WITH ����������)
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
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

create view count_products_by_makers as (
	select
		maker,
		count(*) as cnt
	from product
	group by maker)

--task7 (lesson4)
-- �� ����������� iew (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
create table printer_updated as (
	select * from printer);

delete from printer_updated
where model in (select model from product where maker = 'D' and type = 'Printer');

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)
create view printer_updated_with_makers as (
	select
		t1.*, maker
	from printer_updated t1
	inner join product t2
	on t1.model=t2.model)

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
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
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

	
--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0
create view classes_with_flag as (
	select 
		*,
		case
			when bore >=9 then 1
			else 0
		end flag
	from classes)


--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)
	
--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
