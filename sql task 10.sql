use jolin22 ;
CREATE TABLE monthly_sales (
    sale_month DATE,
    customer_name VARCHAR(50),
    sales DECIMAL(12,2)
);

INSERT INTO monthly_sales (sale_month, customer_name, sales)
VALUES
('2026-01-02', 'siya', 100000),
('2026-02-02', 'diya', 120000),
('2026-03-02', 'riya', 110000),
('2026-04-02', 'Dhanush', 150000),
('2026-05-02', 'visha', 130000),
('2026-06-02', 'deepa', 140000),
('2026-07-02', 'Divya', 150000),
('2026-08-02', 'Bala', 160000),
('2026-09-02', 'Arun', 140000),
('2026-10-02', 'Divya', 180000),
('2026-11-02', 'Bala', 170000),
('2026-12-02', 'Arun', 160000),
('2027-01-02', 'Arun', 130000),
('2027-02-02', 'Bala', 150000),
('2027-03-02', 'Arun', 140000),
('2027-04-02', 'Divya', 170000),
('2027-05-02', 'Bala', 160000),
('2027-06-02', 'Arun', 155000),
('2027-07-02', 'Divya', 180000),
('2027-08-02', 'Bala', 175000),
('2027-09-02', 'Arun', 165000),
('2027-10-02', 'Divya', 190000),
('2027-11-02', 'Bala', 185000),
('2027-12-02', 'Arun', 175000);

SELECT * FROM monthly_sales;

select sale_month,customer_name,sales,
     rank() over(order by sales desc) as sales_rank
from monthly_sales;

select sale_month,customer_name,sales,
     dense_rank() over(order by sales desc) as sales_dense_rank
from monthly_sales;

select sale_month,customer_name,sales,
     row_number() over(order by sales desc) as sales_row_number
from monthly_sales;

select sale_month,sales,
      lag(sales) over ( order by sale_month) as previous_month_sales
from monthly_sales;

select sale_month,sales,
      lead(sales) over ( order by sale_month) as next_month_sales
from monthly_sales;

select sale_month,sales,
      lag(sales,12) over ( order by sale_month) as previous_year_sales
from monthly_sales;

select sale_month,sales,
      lead(sales,12) over ( order by sale_month) as next_year_sales
from monthly_sales;

select sale_month,sales,sum(sales) over (order by sale_month) as running_total from monthly_sales;

select sale_month,sales,lag(sales,12) over (order by sale_month) as previous_year_sales,
((sales-lag(sales,12) over (order by sale_month))/lag(sales,12) over (order by sale_month))*100 as yoy_growth
from monthly_sales;

select sale_month,customer_name,sales, 
rank() over(order by sales desc) as sales_rank,
dense_rank() over(order by sales desc) as sales_dense_rank,
row_number() over(order by sales desc) as sales_row_number,
lag(sales) over ( order by sale_month) as previous_month_sales,
lead(sales) over ( order by sale_month) as next_month_sales
from monthly_sales;