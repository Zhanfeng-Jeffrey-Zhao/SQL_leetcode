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

Jan/14/2020

