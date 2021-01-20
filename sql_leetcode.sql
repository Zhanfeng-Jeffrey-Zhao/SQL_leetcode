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

#1113
SELECT extra as report_reason, COUNT(distinct post_id) as report_count
FROM Actions
WHERE action_date = '2019-07-04' and action ='report'
GROUP BY extra

#1098 
select book_id, name
from Books
where available_from<'2019-05-23' and book_id not in (
    select book_id
    from Orders
    where dispatch_date>'2018-06-23'
    group by book_id
having sum(quantity)>=10)

#1141
select activity_date as day, count(distinct user_id) as active_users
from Activity
where datediff('2019-07-27', activity_date) <30
group by activity_date

#1142
Select ifnull(round(count(distinct session_id) /count(distinct user_id),2) ,0)as average_sessions_per_user
from Activity
where datediff('2019-07-27', activity_date) <30

#1148
select distinct author_id as id
from Views
where author_id=viewer_id
order by author_id

#1173
select round(100*( select count(*)
                from Delivery 
              where order_date=customer_pref_delivery_date)/count(*),2)as immediate_percentage 
from Delivery

#1179
select id, 
	max(case when month = 'Jan' then revenue else null end) as Jan_Revenue,
	max(case when month = 'Feb' then revenue else null end) as Feb_Revenue,
	max(case when month = 'Mar' then revenue else null end) as Mar_Revenue,
	max(case when month = 'Apr' then revenue else null end) as Apr_Revenue,
	max(case when month = 'May' then revenue else null end) as May_Revenue,
	max(case when month = 'Jun' then revenue else null end) as Jun_Revenue,
	max(case when month = 'Jul' then revenue else null end) as Jul_Revenue,
	max(case when month = 'Aug' then revenue else null end) as Aug_Revenue,
	max(case when month = 'Sep' then revenue else null end) as Sep_Revenue,
	max(case when month = 'Oct' then revenue else null end) as Oct_Revenue,
	max(case when month = 'Nov' then revenue else null end) as Nov_Revenue,
	max(case when month = 'Dec' then revenue else null end) as Dec_Revenue
from department
group by id
order by id

#1303
select distinct a.employee_id, count(*) as team_size
from employee a, employee b
where a.team_id=b.team_id
group by a.employee_id, a.team_id

#1607
select seller_name 
from seller
where seller_id not in( select seller_id
                    from Orders
                   where year(sale_date)=2020)
order by seller_name

# 1322
select t.ad_id, if(t.clicked+t.viewed=0,0,round(100*t.clicked/(t.clicked+t.viewed),2)) as ctr
from (select ad_id, count(case when action='Clicked' then 1 end ) as clicked, 
  count(case when action='Viewed' then 1 end)as viewed
from Ads
group by ad_id) as t
group by t.ad_id
order by ctr desc, ad_id

#1327
select p.product_name,sum(unit) as unit
from Orders o
left join products p on o.product_id=p.product_id
where year(o.order_date)=2020 and month(o.order_date)=02
group by o.product_id
having unit>=100

#1571
select w.name as  warehouse_name,sum(w.units*p.v1) as volume
from warehouse w
left join (select product_id, width*Length*Height as v1
         from Products)  as p on  p.product_id=w.product_id
group by 1

#1252 
select u.product_id, round(sum(u.units*p.price)/sum(u.units),2) as average_price
from unitssold u
left join prices p on p.product_id=u.product_id and u.purchase_date between p.start_date and p.end_date
group by u.product_id

#1294
select country_name, 
case when avg(w.weather_state)<=15 then 'Cold'
     when avg(w.weather_state)>=25 then'Hot'
     else 'Warm'
     end as weather_type 
 from weather w
 left join countries c on w.country_id=c.country_id
 where year(w.day)=2019 and Month(w.day)=11
 group by w.country_id

#1350
select id, name
from students
where department_id  not in (
                select id
                from departments)

#1407
select u.name,ifnull(sum(r.distance),0) as travelled_distance
from users u
left join rides r on u.id=r.user_id
group by r.user_id
order by travelled_distance desc, name

#1729
select distinct user_id, count(*) as followers_count
from followers
group by user_id
order by 1

#1341
(select u.name as results
from movie_rating m
left join users u on u.user_id=m.user_id
group by  m.user_id
order by count(m.user_id) desc,u.name
limit 1)
union
(select m.title as results
from movie_rating mr
left join movies m on m.movie_id=mr.movie_id
where year(created_at)=2020 and month(created_at)=02
group by mr.movie_id
order by avg(mr.rating) desc, title
limit 1)

#1683
select tweet_id
from tweets
where length(content)>15

#1587
select u.name, sum(t.amount) as balance
from transactions t
left join users u on t.account=u.account
group by t.account
having sum(t.amount)>10000

# 1581
select distinct customer_id , count(*) as count_no_trans 
from visits
where visit_id not in (select distinct visit_id
                       from transactions )
group by customer_id


