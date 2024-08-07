select
  CustomerID as customer_id,
  Name as customer_name,
  Email as customer_email,
  Address as customer_address,
  City as customer_city,
  State as customer_state,
  Country as customer_country,
  ZipCode as customer_zipcode
from
  {{ ref('customer') }}
