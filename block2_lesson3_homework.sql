--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.

select
	class,
	count(*)
from outcomes t1
left join ships t2
on t1.ship=t2.name
where result = 'sunk'
group by class

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.

select
	class,
	min(launched)
from ships
group by class

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.

select
	class,
	count(*) as cnt_sunk
from ships
where class in 
(select
	class
from outcomes t1
inner join ships t2
on t1.ship = t2.name
where result = 'sunk')
group by class
having count(*)>3


--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).

select 
	t1.class,
	name,
	displacement,
	bore
from classes t1
left join ships t2
on t1.class = t2.class
where (displacement, bore) in (
select
	displacement,
	max(bore)
from classes t1
left join outcomes t2
on t1.class=t2.ship
group by displacement)

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker

select
	t1.maker
from product t1
inner join pc t2
on t1.model=t2.model
inner join (select distinct maker from product  where type = 'Printer') t3
on t1.maker = t3.maker
where ram = (select min(ram) from pc)
and speed = (
select 
	max(speed)
from pc
where ram = (select min(ram) from pc))

