with payment_methods as (
  select distinct
    CreditCardID as payment_method_id,
    'Credit Card' as method_name
  from
    {{ ref('salesorderheader') }}
  union all
  select distinct
    NULL as payment_method_id,
    'Other' as method_name
)

select
  payment_method_id,
  method_name
from
  payment_methods