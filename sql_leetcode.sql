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

#1378
select eu.unique_id, e.name
from employees e
left join employeeuni eu on e.id=eu.id

#1623
select a.student_name AS member_A,
       b.student_name as member_B,
        c.student_name as member_C
from SchoolA a, SchoolB b,SchoolC c
where a.student_id!=b.student_id 
      and b.student_id!=c.student_id 
      and a.student_id!=c.student_id 
      and a.student_name!=b.student_name 
      and a.student_name!=c.student_name 
      and b.student_name!=c.student_name

#1484
select sell_date, count(distinct product) as num_sold, GROUP_CONCAT(DISTINCT product ORDER BY product) AS products
from Activities
group by sell_date
order by sell_date

#1565
select left(order_date, 7) as month, count(distinct order_id) as order_count, count(distinct customer_id) as customer_count
from orders
where invoice>20
group by month

#1661
select machine_id, round(avg(case when activity_type='end' then timestamp end)-avg(case when activity_type='start' then timestamp end),3) as processing_time
from activity
group by 1

#1435
SELECT '[0-5>' AS bin,sum(case when duration/60<5 then 1 else 0 end) as total
from sessions union
SELECT '[5-10>' AS bin, sum(CASE WHEN duration/60>=5 and duration/60<10  THEN 1 ELSE 0 END) AS total FROM Sessions  union
SELECT '[10-15>' AS bin, sum(CASE WHEN duration/60>=10 and duration/60<15 THEN 1 ELSE 0 END) AS total FROM Sessions union 
SELECT '15 or more' AS bin, sum(CASE WHEN (duration/60)>=15  THEN 1 ELSE 0 END) AS total FROM Sessions
##Method2
SELECT '[0-5>' AS bin,count(case when duration/60<5 then 1 else null end) as total
from sessions union
SELECT '[5-10>' AS bin, count(CASE WHEN duration/60>=5 and duration/60<10  THEN 1 ELSE null END) AS total FROM Sessions  union
SELECT '[10-15>' AS bin, count(CASE WHEN duration/60>=10 and duration/60<15 THEN 1 ELSE null END) AS total FROM Sessions union 
SELECT '15 or more' AS bin, count(CASE WHEN (duration/60)>=15  THEN 1 ELSE null END) AS total FROM Sessions

#1565
select p.name, sum(i.rest) as rest,sum(i.paid) as paid,sum(i.canceled) as canceled,sum(i.refunded) as refunded
from invoice i
left join product p on p.product_id=i.product_id
group by 1
order by 1

#1527
SELECT * 
FROM Patients
WHERE conditions LIKE "DIAB1%" OR conditions LIKE "% DIAB1%"

#1633
select contest_id, round(100*count(distinct user_id)/(select count(distinct user_id) from users),2) as percentage
from register
group by 1
order by percentage desc, contest_id

#1517
select *
from users
where mail REGEXP '^[A-Za-z ][A-Za-z0-9_./-]*@leetcode.com$'

#1211
select query_name,round(sum(rating/position)/count(*),2) as quality,
round(100*sum(case when rating<3 then 1 else 0 end)/count(*),2) as poor_query_percentage 
from queries
group by query_name

#1543
select lower(trim(product_name))as product_name, left(sale_date, 7) as sale_date,count(*) as total 
from sales
group by 1,2
order by 1,2

#1241
select distinct s1.sub_id as post_id, count(distinct s2.sub_id) as number_of_comments
from submissions s1
left join submissions s2 on s2.parent_id=s1.sub_id
where s1.parent_id is null
group by 1

#1667
SELECT user_id, concat(upper(left(name,1)),lower(right(name,length(name)-1))) as name FROM Users
order by user_id

#1495
select distinct c.title
from content c
left join tvprogram tv on c.content_id=tv.content_id
where kids_content='Y' and year(program_date)=2020 and month(program_date)=06 and content_type='Movies'

#1731
select distinct e1.reports_to as employee_id,  e2.name, count(*) as reports_count, round(avg(e1.age)) as average_age
from employees e1
left join employees  e2  on e1.reports_to=e2.employee_id
where  e1.reports_to is not null
group by 1
order by 1

#1445
select  sale_date, sum(case when fruit='apples' then sold_num else -sold_num end) as diff
from sales
group by 1

#1393
select stock_name, sum(case when operation='sell' then price else -price end) as capital_gain_loss
from stocks
group by 1

#1270
SELECT e1.employee_id
FROM Employees e1,
     Employees e2,
     Employees e3
WHERE e1.manager_id = e2.employee_id
  AND e2.manager_id = e3.employee_id
  AND e3.manager_id = 1 
  AND e1.employee_id != 1

#1308
select s1.gender, s1.day, sum(s2.score_points) as total
from scores s1
left join scores s2 on s1.day>=s2.day and s1.gender=s2.gender 
group by 1, 2
order by 1,2
#method 2
SELECT gender, day, 
       SUM(score_points) OVER(PARTITION BY gender ORDER BY day) AS total
FROM Scores

#1285
SELECT min(log_id) as start_id, 
       max(log_id) as end_id
FROM (SELECT log_id, RANK() OVER(ORDER BY log_id) as num
      FROM Logs) a
GROUP BY log_id – num

#1699
select LEAST(from_id, to_id) as person1, GREATEST(from_id, to_id) as person2,
count(*) as call_count, sum(duration) as total_duration
from calls
group by 1,2

#1596
WITH fre AS (
SELECT customer_id, product_id, COUNT(product_id) as freq
FROM Orders 
GROUP BY 1,2 )

SELECT f.customer_id, f.product_id, p.product_name
FROM fre f
left join Products p on p.product_id=f.product_id
WHERE freq = (SELECT MAX(freq)
              FROM fre f2
            WHERE f.customer_id=f2.customer_id )
#method 2
SELECT customer_id, product_id, product_name
FROM (
    SELECT O.customer_id, O.product_id, P.product_name, 
    RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(O.product_id) DESC) AS rnk
    FROM Orders O
    JOIN Products P ON O.product_id = P.product_id  
    GROUP BY customer_id, product_id
) temp
WHERE rnk = 1 
ORDER BY customer_id, product_id

#614
select distinct followee as follower, count(distinct follower) as num
from follow
where followee in (select distinct follower from follow ) 
group by 1
order by 1

#177
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
       select distinct Salary
      from 
      (select DENSE_RANK() over (order by Salary desc) as r, Salary
        from Employee
       ) as t
      where r =N
      
  );
END

#184
SELECT dep.Name as Department, emp.Name as Employee, emp.Salary 
from Department dep
left join Employee emp on emp.DepartmentId=dep.Id 
where  emp.Salary=(Select max(Salary) from Employee e2  where e2.DepartmentId=dep.Id)

#178
Select score, dense_rank() over(order by score DESC) as rank
from scores;

#180
select distinct x.num as ConsecutiveNums
from( select num,Lag(num, 1) over(order by id) as num_2,
                 Lag(num, 2) over(order by id) as num_3
      from logs) x
where x.num = x.num_2 and x.num = x.num_3

#626
SELECT CASE WHEN id%2=1 AND id<(SELECT COUNT(*) FROM seat) THEN id+1
            WHEN id%2=0 THEN id-1 ELSE id END AS id,student
 FROM seat 
 ORDER BY id;
#method 2
select id,
case when id%2=0 then (select student from seat where id=s.id-1)
when id%2 = 1 and id<(select count(*) from seat) then (select student from seat where id=(s.id+1))
else student end as student
from seat s

#1355
with a as (select activity,count(*) as num from Friends group by activity)
select activity
from a
where num != (select min(num) from a) and num !=(select max(num) from a)

#1454
SELECT DISTINCT a.id, (SELECT name FROM Accounts WHERE id=a.id) name
FROM Logins a, Logins b
WHERE a.id=b.id AND
DATEDIFF(a.login_date,b.login_date) BETWEEN 1 AND 4
GROUP BY a.id, a.login_date
HAVING COUNT(DISTINCT b.login_date)=4

#1204
with a as (select person_name, turn, sum(weight) over(order by turn) as total
          from queue)

select person_name 
from a
where turn in (select max(turn)
              from a
              where total<=1000)

#1126
with a as(select business_id,event_type, occurences, avg(occurences) over (partition by event_type) as ave
from events)

select distinct business_id
from a
where occurences>ave
group by business_id
having count(distinct event_type)>1

#262
select request_at as 'Day', round(sum(case when status='completed' then 0 else 1 end)/count(*),2) as 'Cancellation Rate'
from trips
where client_id in (select users_id from users where banned='No')
   and  driver_id in (select users_id from users where banned='No')
   and request_at between '2013-10-01' and  '2013-10-03'
group by 1

#185
with tem as (select name, salary, DepartmentId,
         dense_rank()over(partition by DepartmentId order by salary desc) as rnk
          from employee)

select d.name as department, t.name as employee, salary
from tem t
join department d on t.DepartmentId=d.Id
where rnk<=3

#601
select distinct s1.*
from stadium s1,stadium s2,stadium s3
where s1.people>=100 and s2.people>=100 and s3.people>=100
and (
    (s1.id-s2.id=1 and s1.id-s3.id=2) 
    or(s3.id-s1.id=1 and s1.id-s2.id=1)
    or (s2.id-s1.id=1 and s3.id-s1.id=2)
)
order by s1.visit_date

#1479
select item_category as CATEGORY, 
sum(case when weekday(order_date)=0 then quantity else 0 end) as 'MONDAY',
sum(case when weekday(order_date)=1 then quantity else 0 end) as 'TUESDAY',
sum(case when weekday(order_date)=2 then quantity else 0 end) as 'WEDNESDAY',
sum(case when weekday(order_date)=3 then quantity else 0 end) as 'THURSDAY',
sum(case when weekday(order_date)=4 then quantity else 0 end) as 'FRIDAY',
sum(case when weekday(order_date)=5 then quantity else 0 end) as 'SATURDAY',
sum(case when weekday(order_date)=6 then quantity else 0 end) as 'SUNDAY'
from orders o
right join items i on  o.item_id=i.item_id
group by 1
order by 1

#1412
WITH tem AS 
(
	SELECT exam_id, student_id, 
	RANK() OVER(partition by exam_id order by score DESC) AS s1,
	RANK() OVER(partition by exam_id order by score) AS s2
	FROM Exam 
)

SELECT DISTINCT e.student_id, s.student_name
FROM Exam e 
LEFT JOIN Student s ON s.student_id = e.student_id
WHERE e.student_id NOT IN (SELECT student_id FROM tem WHERE s1 = 1 OR s2 = 1)
order by 1

#1194
with tem as (select first_player as player, first_score as score
        from matches
        Union all
        select second_player as player, second_score as score
        from matches),

tem2 as (select player, sum(score) as total
          from tem
        group by player)

select distinct p.group_id, 
FIRST_VALUE(t2.player) OVER(partition by p.group_id ORDER BY  total desc,player) as player_id
from tem2 t2
left join players p on p.player_id=t2.player

#1421
select q.id, q.year, ifnull(n.npv,0) as npv
from queries q
left join npv n on (q.id=n.id) and (q.year=n.year)

#1468
select company_id,employee_id,employee_name,
case when max(salary) over(partition by company_id)<1000 then salary
when max(salary) over(partition by company_id) between 1000 and 10000 then round(salary*(1-0.24))
else round(salary*(1-0.49))
end  as salary
from salaries

#1398
select * 
from customers
where customer_id in(select customer_id from orders where product_name='A')
and customer_id in(select customer_id from orders where product_name='B')
and customer_id not in(select customer_id from orders where product_name='C')

#1709 
select user_id, max(diff) as biggest_window
from (select *,
      datediff(lead (visit_date,1,'2021-1-1') over(partition by user_id order by visit_date),
               visit_date) as diff
      from uservisits) a
group by 1
order by 1

#1715
select sum(b.apple_count+ifnull(c.apple_count,0)) as apple_count,
sum(b.orange_count+ifnull(c.orange_count,0) ) as orange_count
from boxes b
left join chests c on b.chest_id=c.chest_id

#1741
select event_day as day, emp_id, sum(out_time-in_time) as total_time
from employees
group by 1,2
order by 3

#1532
select name as customer_name, customers.customer_id, order_id, order_date
from( select order_id, customer_id,order_date,
dense_rank() over (partition by customer_id order by order_date desc) as rnk
from orders) tem
left join customers on customers.customer_id=tem.customer_id
where rnk<=3
order by customer_name,customers.customer_id,order_date desc

#1112
select student_id, course_id, grade
from( select *, 
     dense_rank() over(partition by student_id order by grade desc,course_id asc) as rnk
     from Enrollments) tem
where rnk=1

#1747
select distinct l1.account_id
from loginfo l1
left join loginfo l2 on (l1.account_id=l2.account_id) and (l1.ip_address!=l2.ip_address) 
where (l2.login<=l1.login and l1.login<=l2.logout)
  or ( l2.login<=l1.logout and l1.logout<=l2.logout)

#1321
SELECT * 
FROM (select distinct visited_on, 
sum(amount)over(order by visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW ) as amount,
round(sum(amount)over(order by visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW)/7,2) as average_amount
from customer) tem
WHERE visited_on >= (SELECT min(visited_on) FROM Customer) + 6
ORDER BY 1

#608
select id,
case when p_id is null then 'Root'
when id not in (select distinct p_id from tree where p_id is not null) then 'Leaf'
else 'Inner' end as Type
from tree

#1193
select left(trans_date,7) as month,
country, count(*) as trans_count, count(case when state='approved' then 1 end) as approved_count,sum(amount) as trans_total_amount, sum(case when state='approved' then amount else 0 end)  as approved_total_amount
from transactions
group by 1,2

#1264
select distinct page_id as recommended_page
from likes
where user_id in(select user1_id as id from friendship where user2_id=1
                union all
                select user2_id as id from friendship where user1_id=1)
 and page_id not in (select page_id from likes where user_id=1)

#1132
with a as (select count(distinct id)/count(distinct post) as average
from(select a.post_id as post,a.action_date ,r.post_id as id
from actions a
left join removals r on a.post_id=r.post_id
where a.extra='spam') tem
group by action_date)
select round(100*avg(average),2) as average_daily_percent
from a

#1369 
select username, activity, startDate, endDate
from(select *, 
dense_rank()over(partition by username order by startDate desc, endDate desc) as rnk,
count(username)over(partition by username) as cnt
from useractivity) tem
where rnk=2 or cnt=1

#1045
select customer_id
from customer
group by 1
having count(distinct product_key) =(select count(distinct product_key) from product)

#1164
select product_id, new_price as price
from( select product_id,new_price, 
dense_rank()over(partition by product_id order by change_date desc) as rnk
from products
where change_date<='2019-08-16') tem
where rnk=1
union
select product_id,  10  as price
from products
group by product_id 
having min(change_date)>'2019-08-16'

#534
select player_id, event_date,
sum(games_played) over(partition by player_id order by event_date) as games_played_so_far 
from activity

#1364
with tem as (
    select cu.customer_id, cu.customer_name,count(ct.contact_name) as contacts_cnt,
     sum(case when contact_name in (select customer_name from customers) then 1 else 0 end ) as          trusted_contacts_cnt 
     from customers cu
      left join contacts ct on cu.customer_id=ct.user_id
       group by 1)
select invoice_id, customer_name,price, contacts_cnt,trusted_contacts_cnt 
from invoices i
left join tem t on i.user_id=t.customer_id
order by 1

#1077
select project_id, employee_id
from (select p.project_id,e.employee_id,dense_rank() over(partition by p.project_id order by experience_years desc) as rnk
from project p 
left join employee e on e. employee_id=p.employee_id) tem
where rnk=1

#1440
select e.left_operand,e.operator,e.right_operand,
case when v1.value>v2.value and operator='>' then 'true'
     when  v1.value=v2.value and operator='=' then 'true'
     when  v1.value<v2.value and operator='<' then 'true'
     else 'false' end as  value
from expressions e
left join Variables v1 on v1.name=left_operand
left  join Variables v2 on v2.name=right_operand

#1613
with RECURSIVE seq as (
    select 1 as id
    union all
    select id+1 
    from seq
    where id<(select max(customer_id)from customers))    
select id as ids
from seq s
left join customers  c on s.id=c.customer_id
where c.customer_id is null

select round(100*sum(case when order_date=customer_pref_delivery_date then 1 else 0 end)/count(distinct customer_id),2) as immediate_percentage 
from delivery
where (customer_id,order_date) in (select customer_id, min(order_date) as order_date 
                                   from delivery
                                    group by 1 )
#612
select min(round(sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2)),2)) as shortest
from point_2d p1
join point_2d p2 on p1.x!=p2.x or p1.y!=p2.y

#1555
with a as (select u.user_id,u.user_name,
u.credit-ifnull(t1.amount,0)+ifnull(t2.amount,0) as amount
from users u
left join (select paid_by,sum(amount) as amount
           from transactions
           group by 1) t1 on t1.paid_by=u.user_id
left join (select paid_to,sum(amount) as amount
           from transactions
           group by 1) t2 on  t2.paid_to=u.user_id)
select user_id,user_name, amount as credit,
case when amount<0 then "Yes" else 'No' end as credit_limit_breached
from a

#585
select  sum(TIV_2016) as TIV_2016
from insurance
where TIV_2015 in (select TIV_2015
                  from insurance 
                  group by 1
                  having count(*)>1)
    and (LAT,LON) in(select LAT,LON
                    from insurance
                    group by LAT,LON
                    having count(*)=1)

#1107
select login_date, count(*) as user_count
from (select min(activity_date) as login_date, user_id as user_count
from traffic
where activity='login' 
group by 2
having datediff('2019-06-30',login_date)<=90) tem
group by 1
order by 1

#1459
select p_1.id as p1, p_2.id as p2,
abs(p_1.x_value-p_2.x_value)*abs(p_1.y_value-p_2.y_value) as area
from points p_1, points p_2
where  p_1.id<p_2.id and (p_1.x_value!=p_2.x_value) and (p_1.y_value!=p_2.y_value)
order by area desc, p1, p2

#1501
with a as (select c.name,c1.duration as duration
from Country c
left join person p on left(p.phone_number,3)=c.country_code
left join calls c1 on c1.caller_id=p.id
union all
select c.name,duration as duration
from Country c
left join person p on left(p.phone_number,3)=c.country_code
left join calls c1 on c1.callee_id=p.id)
select name as country 
from a
group by 1
having avg(duration)>(select avg(duration) from calls)

#1149
select distinct viewer_id as id
from views
group by viewer_id ,view_date
having count(distinct article_id)>1
order by 1

#1205
with a as (select *
from transactions
where state='approved'
union all
select c.trans_id as id, t.country,'chargeback' as state,t.amount,c.trans_date
from  chargebacks c
join transactions t on c.trans_id=t.id)
select left(trans_date,7) as month, country, 
count(case when state='approved' then 1 end) as approved_count, 
sum(case when state='approved' then amount else 0 end) as approved_amount,
count(case when state='chargeback' then 1 end) as chargeback_count, 
sum(case when state='chargeback' then amount else 0 end) as chargeback_amount 
from a
group by 1,2

#1158
select u.user_id as buyer_id, u.join_date, 
count(case when year(o.order_date)=2019 then 1 end) as orders_in_2019 
from users u
left join orders o on u.user_id=o.buyer_id
group by 1
order by 1

#1070
select product_id, year as first_year,quantity , price
from sales
where (product_id, year) in (select product_id, min(year)
                            from sales
                            group by 1)

#602
with a as (select id, count(*) as cnt
from (select requester_id as id
      from request_accepted
      union all
      select accepter_id as id
      from request_accepted) tem
group by 1)
select id, cnt as num
from a
where  cnt in (select max(cnt)
               from a)

#580
select dept_name, count(s.student_id) as student_number
from department d
left join student s on s.dept_id=d.dept_id
group by 1
order by 2 desc,1

#578
select question_id as survey_log
from survey_log
group by 1
order by count(answer_id)/sum(if(action='show',1,0)) desc
limit 1

#574
select name
from candidate c
right join vote v on c.id=v.candidateId
group by v.candidateId
order by count(v.candidateId) desc
limit 1

#1127
with tem as (select distinct spend_date, 'desktop' platform from spending 
    union all
    select distinct spend_date, 'mobile' platform from spending 
    union all
    select distinct spend_date, 'both' platform from spending),
    
  res as (
      select user_id, spend_date,
      case when count(*)=1 then platform else 'both' end as platform,
        sum(amount) as amount
       from spending
       group by 1, 2)
          
          
select t.spend_date, t.platform, ifnull(sum(r.amount),0) as  total_amount , count(user_id) as total_users
from tem t
left join res r on t.spend_date=r.spend_date and t.platform=r.platform
group by 1,2

#1225
with 
tem1 as (SELECT datediff(fail_date,'2019-01-01' ) as diff,RANK() OVER (ORDER BY fail_date) AS rk,fail_date AS day
FROM Failed
WHERE year(fail_date)=2019),
tem2 as (SELECT datediff(success_date,'2019-01-01') as diff,RANK() OVER (ORDER BY success_date) AS rk, success_date AS day
FROM Succeeded
WHERE year(success_date)=2019),
tem3 as (select 'failed' as period_state, min(day) as start_date, max(day) as end_date   
         from tem1
         group by diff-rk
         union all
         select 'succeeded' as period_state, min(day) as start_date, max(day) as end_date 
         from tem2
         group by CAST(rk AS SIGNED)-diff)
select *
from tem3
order by  start_date 

#1159
with tem as (select seller_id, item_id, rank()over(partition by seller_id order by order_date) as rk
from orders)
select u.user_id as seller_id,
case when u.favorite_brand=i.item_brand then'yes' else 'no' end as 2nd_item_fav_brand 
from users u
left join tem t on u.user_id=t.seller_id and t.rk=2
left join items i on i.item_id=t.item_id

#1757
select product_id
from products
where low_fats ='Y' and recyclable='Y'

#1097
with tem as (select player_id, min(event_date) as install_dt,
case when (player_id,  min(event_date)+1) in (select player_id, event_date from Activity) then 1 else 0 end as retention         
from activity
group by player_id)
select install_dt, count(player_id) as installs,round(sum( retention)/count(player_id),2) as Day1_retention 
from tem
group by 1

#618
with Am as (select ROW_NUMBER() over(order by name) as row_n,name as 'America'
from student
where continent ='America'),
Asia as (select ROW_NUMBER() over(order by name) as row_n,name as 'Asia'
from student
where continent ='Asia'),
Europe as (select ROW_NUMBER() over(order by name) as row_n,name as 'Europe'
from student
where continent ='Europe')
select Am.America,Asia.Asia,Europe.Europe
from Am
left join Asia on Am.row_n=Asia.row_n
left join Europe on Am.row_n=Europe.row_n

#615
with tem1 as (select left(pay_date,7) as pay_month,department_id, avg(amount) as avg_s
from salary s 
join employee e on s.employee_id=e.employee_id
group by department_id,pay_month),
tem2 as (select left(pay_date,7) as pay_month,department_id, avg(amount) as total_avg
from salary s 
join employee e on s.employee_id=e.employee_id
group by pay_month),
tem3 as (select t1.pay_month, t1.department_id, t1.avg_s, t2.total_avg
from tem1 t1
join tem2 t2 on t1.pay_month=t2.pay_month)
select pay_month,department_id,
case when avg_s>total_avg then 'higher'
when  avg_s=total_avg then 'same'
else 'lower' end as comparison  
from tem3

#579
with tem as (select id, month, sum(salary) over (partition by id order by month rows between 2 preceding and current row) as salary,
rank() over(partition by id order by month desc) as rnk
from  Employee)
select id, month, salary
from tem
where rnk!=1

#1635
# Write your MySQL query statement below
with recursive months as (
select 1 as month
union all
select month+1
from months
where month<12),
tem1 as (
select month (requested_at) as month,count(driver_id) as cnt
from rides r 
left join acceptedrides  a on r.ride_id=a.ride_id 
where year(requested_at)=2020
group by 1),
tem2 as (select month(join_date) as month,cnt as active_drivers
       from (select join_date, count(driver_id) over (order by join_date) as cnt
              from drivers
              where year(join_date) <= 2020) a
       where year(join_date)=2020)
select distinct m.month,ifnull(max(active_drivers) over (order by m.month),0) as active_drivers,ifnull(cnt,0) as accepted_rides
from months m
left join tem1  t1 on m.month=t1.month
left join tem2 t2 on m.month=t2.month

#1645
with recursive months as (
select 1 as month
union all
select month+1
from months
where month<12),
tem1 as (select month(requested_at) as month,count(distinct a.driver_id) as cnt1
from rides r
join acceptedRides a on r.ride_id=a.ride_id
join drivers d on d.driver_id=a.driver_id and (d.join_date<=r.requested_at)
where year(requested_at)=2020 
group by month),
tem2 as (select month(join_date) as month,cnt as active_drivers
       from (select join_date, count(driver_id) over (order by join_date) as cnt
              from drivers
              where year(join_date) <= 2020) a
       where year(join_date)=2020)
select m.month, ifnull(round(100*ifnull(cnt1, 0)/ifnull(max(active_drivers) over (order by m.month),0),2),0)as working_percentage
from months m
left join tem1 t1 on m.month=t1.month
left join tem2 t2 on m.month=t2.month
order by 1

#1336
with tem1 as (select v.user_id, visit_date,count(transaction_date) as transactions
from visits v
left join transactions t on v.user_id=t.user_id and v.visit_date=t.transaction_date
group by 1,2),
tem2 as (select transactions as transactions_count, count(user_id) as visits_count 
from tem1
group by 1),
tem3 as (SELECT ROW_NUMBER() OVER() row_num
FROM Transactions
UNION 
SELECT 0)
select row_num as transactions_count ,ifnull(visits_count,0) as visits_count
from tem3 t3
left  join tem2  t2 on t2.transactions_count=t3.row_num
where row_num<=(select max(transactions) from tem1)
order by 1 

#1384
with tem1 as (select s.product_id,product_name, '2018' as report_year,
case when year(period_start)=2018 and year(period_end)>2018 then average_daily_sales*(datediff('2018-12-31',period_start)+1)
when year(period_start)=2018 and year(period_end)=2018  then average_daily_sales*(datediff(period_end,period_start)+1)
else null end as  total_amount
from product p
join sales  s on p.product_id=s.product_id),
tem2 as (select s.product_id,product_name, '2019' as report_year,
case when year(period_start)<2019 and year(period_end)=2019 then average_daily_sales*(datediff(period_end,'2019-01-01')+1)
when year(period_start)<2019 and year(period_end)>2019  then average_daily_sales*365
when year(period_start)=2019 and year(period_end)=2019  then average_daily_sales*(datediff(period_end,period_start)+1)
when year(period_start)=2019 and year(period_end)>2019 then average_daily_sales*(datediff('2019-12-31',period_start)+1)
else null end as  total_amount
from product p
join sales  s on p.product_id=s.product_id),
tem3 as (select s.product_id,product_name, '2020' as report_year,
case when year(period_start)<2020 and year(period_end)=2020 then average_daily_sales*(datediff(period_end,'2020-01-01')+1)
when year(period_start)=2020 and year(period_end)=2020  then average_daily_sales*(datediff(period_end,period_start)+1)
else null end as total_amount
from product p
join sales  s on p.product_id=s.product_id),
tem4 as (select * from tem3
where total_amount
union all
select * from tem1
where total_amount
union all
select * from tem2
where total_amount)
select * from tem4
order by product_id,report_year

#596
with tem as (select *, ROW_NUMBER() OVER(PARTITION BY COMPANY ORDER BY Salary ASC, Id ASC) AS RN_ASC,
ROW_NUMBER() OVER(PARTITION BY COMPANY ORDER BY Salary DESC, Id DESC) AS RN_DESC
from employee)
select id, company, salary
from tem
where RN_ASC BETWEEN RN_DESC - 1 AND RN_DESC + 1

#1280
select s.student_id,s.student_name,s2.subject_name,count(e.subject_name) as attended_exams 
from students s
cross join subjects s2
left join examinations e on e.student_id=s.student_id and s2.subject_name=e.subject_name
group by 2,3
order by 1,3

#571
with t as (select *, sum(frequency) over(order by number) freq, 
           (sum(frequency) over())/2 median_num
           from numbers)
           
select avg(number) as median
from t
where median_num between (freq-frequency) and freq



