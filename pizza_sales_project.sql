create database pizzahut;

use pizzahut;

create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id)
);


create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
);


-- Q1. Retrieve the total number of orders placed
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
    
    
    
-- Q2.Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(quantity * price), 2) AS total_prize
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;


-- Q3.Identify the highest-priced pizza.
SELECT 
    t.name, p.price
FROM
    pizzas p
        JOIN
    pizza_types t ON t.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;


-- Q4.Identify the most common pizza size ordered.
SELECT 
    COUNT(o.order_id) AS total_order, p.size
FROM
    order_details o
        JOIN
    pizzas p ON o.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_order DESC;


-- Q5.List the top 5 most ordered pizza types along with their quantities.
SELECT 
    sum(o.quantity) AS total, p.name
FROM
    order_details o
        JOIN
    pizzas s ON o.pizza_id = s.pizza_id
        JOIN
    pizza_types p ON p.pizza_type_id = s.pizza_type_id
GROUP BY p.name
ORDER BY total DESC
LIMIT 5;


-- Q6.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    SUM(o.quantity) AS total, p.category
FROM
    order_details o
        JOIN
    pizzas s ON o.pizza_id = s.pizza_id
        JOIN
    pizza_types p ON p.pizza_type_id = s.pizza_type_id
GROUP BY p.category
ORDER BY total DESC; 


-- Q7.Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hours, COUNT(order_id)
FROM
    orders
GROUP BY hours;


-- Q8.Join relevant tables to find the category-wise distribution of pizzas.
select  category, count(name) from pizza_types group by category;


-- Q9.Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    round(AVG(quantity),0) as avg_pizza_order_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS total_order;


-- Q10.Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name, ROUND(SUM(quantity * price), 2) AS total_price
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
    join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id
    group by  pizza_types.name order by total_price desc limit 3;
    
    
    
-- Q11.Calculate the percentage contribution of each pizza type to total revenue.

    
SELECT 
    pizza_types.category, (SUM(quantity * price)/(SELECT 
    ROUND(SUM(quantity * price), 2) AS total_prize
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id))*100 as total_price
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
    join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id
    group by  pizza_types.category order by total_price desc;
    
    
SELECT 
    pt.category, SUM(od.quantity * p.price) AS category_sales
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity * p.price) > (SELECT 
        SUM(od2.quantity * p2.price) * 0.1
    FROM
        order_details od2
            JOIN
        pizzas p2 ON od2.pizza_id = p2.pizza_id)
ORDER BY category_sales DESC;



-- Q12.Analyze the cumulative revenue generated over time.
select order_date,sum(revenue) over (order by order_date) as cum_revenue 
from
(SELECT 
        orders.order_date, SUM(order_details.quantity*pizzas.price) AS revenue
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    join pizzas on pizzas.pizza_id=order_details.pizza_id
    GROUP BY orders.order_date) as sales ;
    
    

-- Q13.Determine the top 3 most ordered pizza types based on revenue for each category.
select name, revenue,ranks from
(select category, name, revenue , rank() over(partition by category order by revenue desc)as ranks from
(select pizza_types.category,pizza_types.name,sum(order_details.quantity*pizzas.price)as revenue
from order_details join pizzas on order_details.pizza_id = pizzas.pizza_id
join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id
group by pizza_types.category,pizza_types.name
order by revenue) as a) as b
where ranks<=3 ;  


   