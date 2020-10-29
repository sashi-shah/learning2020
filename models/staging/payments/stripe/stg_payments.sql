with stg_payment as (
 select id as payment_id,
          orderid as order_id,
          paymentmethod,
         status,
        amount/100 as amount
        from raw.stripe.payment
 )
 select * from stg_payment