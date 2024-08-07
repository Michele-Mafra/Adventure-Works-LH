-- models/facts/fact_sales.sql

with sales_order as (
  select
    OrderID as order_id,
    CustomerID as customer_id,
    ProductID as product_id,
    OrderDate as order_date,
    SalesTerritoryID as sales_territory_id,
    PaymentMethodID as payment_method_id,
    Quantity as quantity,
    SalesAmount as sales_amount,
    DiscountAmount as discount_amount
  from
    {{ ref('salesorderheader') }}
),
customer as (
  select * from {{ ref('dim_customer') }}
),
product as (
  select * from {{ ref('dim_product') }}
),
date as (
  select * from {{ ref('dim_date') }}
),
sales_territory as (
  select * from {{ ref('dim_sale_region') }}
),
payment_method as (
  select * from {{ ref('dim_payment_method') }}
)

select
  s.order_id,
  c.customer_name,
  p.product_name,
  d.date,
  t.region as sales_region,
  pm.method_name as payment_method,
  s.quantity,
  s.sales_amount,
  s.discount_amount
from
  sales_order s
  left join customer c on s.customer_id = c.customer_id
  left join product p on s.product_id = p.product_id
  left join date d on s.order_date = d.date
  left join sales_territory t on s.sales_territory_id = t.sales_territory_id
  left join payment_method pm on s.payment_method_id = pm.payment_method_id
