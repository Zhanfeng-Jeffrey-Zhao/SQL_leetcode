#512
select player_id, device_id
from Activity
where (player_id,event_date) in ( 
    select  player_id,min(event_date)
    from Activity
    group by player_id)
    
#511
select player_id, device_id
from Activity
where (player_id,event_date) in ( 
    select  player_id,min(event_date)
    from Activity
    group by player_id)

#1511
select c.customer_id, c.name 
from Customers c
inner join Orders o on (c.customer_id=o.customer_id)
inner join Product p on (p.product_id=o.product_id)
group by c.customer_id
HAVING SUM(IF( MONTH(o.order_date)= 06, o.quantity, 0) * p.price) >= 100
    AND SUM(IF( MONTh(o.order_date)= 07, o.quantity, 0) *p.price) >= 100
    
#613
SELECT MIN(a.x - b.x) AS shortest
FROM point a, point b
WHERE a.x > b.x;

#610
select *,
case when x+y>z and x+z>y and y+z>x then 'Yes'
     else 'No'
     end as 'triangle'
from triangle

#607
select name
from salesperson 
where sales_id not in (
   SELECT o.sales_id 
    FROM  orders o
    JOIN company c ON o.com_id = c.com_id
    WHERE c.name = 'RED')
    
#597
select ifnull(round((count(distinct requester_id,accepter_id)/count(distinct sender_id,send_to_id)),2),0) as accept_rate
from FriendRequest,RequestAccepted

#596
select class
from courses
group by class
having count( distinct student)>=5

#595
select name, population, area
from World
where area>3000000 or population >25000000

#586
 select customer_number from orders
group by customer_number
order by count(*) desc limit 1

#584
select name
from customer
where ifnull(referee_id, 0)!=2

#577
select e.name, b.bonus
from Employee e 
left join Bonus b on (e.empId=b.empId) 
where b.bonus<1000 or b. bonus is null

#197
select w1.id
from Weather w1
join Weather w2 on  w1.recordDate =(w2.recordDate+INTERVAL 1 DAY)
where w1.Temperature>w2.Temperature

#196
delete p1
from Person p1,Person p2 
where p1.Email = p2.Email and p1.Id > p2.Id

#183
select c.name as 'Customers'
from Customers c
left join orders o on c.Id=o.CustomerId
where o.id is null

#182
select Email
from Person
group by email
having count(email)>1

#181
select e1.Name as 'Employee'
from Employee e1
join Employee e2 on e1.ManagerId=e2.Id
where e1.Salary>e2.Salary

#176
select max(salary) as 'SecondHighestSalary'
from Employee
where salary<(select max(salary) from Employee)

#175
select p.FirstName, p.LastName,a.City, a.State
from Person p
left join Address a on p.personId=a.PersonId

#1693
select date_id, make_name, count(distinct lead_id) as 'unique_leads', count(distinct partner_id) as 'unique_partners'
from DailySales
group by date_id, make_name

#619
select max(num) as 'num'
from (
    select num
    from my_numbers
    group by num
    having count(*)=1) as temp_tab

#620
select *
from cinema
where (id % 2)!=0 and description not like 'boring'
order by rating desc

#627
update salary 
set sex = case  sex
when 'm' then 'f'
else 'm'
end;

#1050
select actor_id, director_id
from ActorDirector
group by 1,2
having count(*)>=3

#1068
select p.product_name, s.year, s.price
from product p
join sales s on s.product_id=p.product_id

#1069
select s.product_id, sum(s.quantity) as total_quantity
from Sales s, Product p
where s.product_id=p.product_id
group by product_id

#1075
select project_id, round(sum(e.experience_years)/count(e.employee_id),2) as average_years
from Project p,Employee e
where p.employee_id=e.employee_id
group by project_id

#1076
select project_id
from Project
group by project_id
having count(employee_id)=(
        select count(employee_id)
        from Project
        group by project_id
        order by count(employee_id)desc
        limit 1)

#1082
select seller_id
from sales
group by seller_id
having sum(price)=(
     select sum(price)
     from sales
     group by seller_id
     order by sum(price) desc
     limit 1)

#1083
select distinct s.buyer_id
from Sales s
left join Product p on s.product_id=p.product_id
where s.buyer_id not in (select distinct s.buyer_id
                    from sales s 
                    left join product p on s.product_id=p.product_id
                    where p.product_name = 'iPhone' ) and p.product_name='S8'

#1084
select s.product_id, p.product_name
from sales s
left join Product p on s.product_id=p.product_id
group by s.product_id
having min(s.sale_date)>='2019-01-01' and max(s.sale_date)<='2019-03-31'
