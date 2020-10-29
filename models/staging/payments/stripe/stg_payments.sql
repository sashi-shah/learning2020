with stg_payment as (
 select id as payment_id,
          orderid as order_id,
          paymentmethod,
         status,
         created::timestamp as created,
        amount/100 as amount
        from {{source('stripe','payment')}}
 )
 select * from stg_payment