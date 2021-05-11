--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ��������� (�� ����� ���� ���������
-- �� ����� ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

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
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� 
--����������. �����: �������������,
create view distribution_by_type as (
	select distinct
		type,
		cast(cast(count(*)over(partition by type)as numeric)/cast(count(*)over() as numeric) as numeric(5,2)) as rat
	from product)

--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������

--select * from distribution_by_type

--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����

create table ships_two_words as (
	select * from ships 
	where name like '% %'
)

--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

select * 
from ships
where class is null
and name like 'S%'

--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'C' � ��� ����� ������� (����� ������� �������). ������� model

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