use geeksforgeeks;
select * from swiggy;
-- 1. Which restaurant of Bangalore is visited by least number of people?

select name,rating_count
from restaurants
where city='bangalore'
order by rating_count asc
limit 1
;

-- 2. Which restaurant has generated maximum revenue all over india? 
select name,city,cost,(rating_count*cost) as revenue
from restaurants
order by revenue desc
limit 1;

-- 3. How many restaurants have rating more than the average rating?
select count(*) 
from restaurants
where rating>(select avg(rating) from restaurants);

-- 4. Which restaurant of Delhi has generated max revenue?
select name, city, (rating_count*cost) as revenue
from restaurants
where city='delhi'
order by revenue desc
limit 1;

-- 5. Which restaurant chain has maximum number of restaurants?

select name, count(*) as restaurant_count
from restaurants
group by name
order by restaurant_count desc
limit 1;

-- 6. Which restaurant chain has generated maximum revenue?
select name, sum(rating_count*cost) as revenue
from restaurants
group by name
order by revenue desc
limit 1;

-- 7. Which city has maximum number of restaurants?
select city, count(*)
from restaurants
group by city
order by count(*) desc
limit 1;
-- 8. Which city has generated maximum revenue all over india?
select city, sum(rating_count*cost) as revenue
from restaurants
group by city
order by revenue desc
limit 1;

-- 9. List 10 least expensive cuisines?
select cuisine, sum(rating_count*cost) as revenue
from restaurants
group by cuisine
order by revenue asc
limit 10;



-- 10. List 10 most expensive cuisines?
select cuisine, sum(rating_count*cost) as revenue
from restaurants
group by cuisine
order by revenue desc
limit 10;

-- 11. Which city has Biryani as most popular cuisine.
use geeksforgeeks;
select * from restaurants;
select city,cuisine,sum(rating*rating_count) as rating
from restaurants
group by city,cuisine
having cuisine='Biryani'
order by rating desc
limit 1;

-- 12. List top 10 restaurants generate maximum revenue
select name,sum(rating_count*cost) revenue
from restaurants
group by name
order by revenue desc
limit 10;

-- 13. Find the names of restaurants that serve unique cuisines in their city.
 with uniqueCuisine as(
 SELECT cuisine, city
    FROM restaurants
    GROUP BY cuisine, city
    HAVING COUNT(*) = 1
)
select r.name,r.cuisine, r.city 
from restaurants r
join uniqueCuisine uc
on r.city=uc.city and r.cuisine=uc.cuisine;

-- 15. Which restaurants are more affordable, with costs below the average cost of restaurants in the same city?
with cte as(
select city, avg(cost)
from restaurants 
group by city
)
select name,cost
from restaurants r
join cte c
on r.city=c.city
order by name;



-- 16. Which restaurants have the highest rating in their city?
with cte as(
select city,sum(rating*rating_count) rating
from restaurants
group by city
)
select name,c.rating,r.city
from restaurants r
join cte c
on r.city=c.city ;

-- 17. Find the names of restaurants that serve unique cuisines in their city.
SELECT city, cuisine
FROM restaurants
GROUP BY city, cuisine
HAVING COUNT(*) = 1;
