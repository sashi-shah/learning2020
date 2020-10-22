with
orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (
 	select * from {{ ref('stg_payments') }}
 ),

paid_orders as
  (select order_id,
   sum(case when status ='success' then amount end) as amount
  from payments
  group by 1
  order by 1
),

final as (

    select
        orders.order_id,
        orders.customer_id, 
        orders.order_date,
        paid_orders.amount 
    from orders

    left join paid_orders using (order_id)

)

select * from final