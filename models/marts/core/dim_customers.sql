 with customers as (
    select * from {{ ref('stg_customers')}}
),
orders as (
    select * from {{ ref('stg_orders')}}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

orderval as (
 	select 
    distinct order_id as order_id,
    amount as amount 
    from payments
    
 ),

customer_orders as (
    select
        orders.customer_id as customer_id, 
        orders.order_id as order_id,
        orderval.amount as amount
    from orders
    inner join orderval using (order_id) 
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name, 
        count(customer_orders.order_id),
        sum(customer_orders.amount ) amount 
    from customers
    left join customer_orders using (customer_id)
    group by customers.customer_id,
        customers.first_name,
        customers.last_name
)
select * from final 