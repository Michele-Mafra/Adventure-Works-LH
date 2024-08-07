select
  ProductID as product_id,
  Name as product_name,
  Category as product_category,
  SubCategory as product_sub_category,
  Brand as product_brand,
  Color as product_color,
  Size as product_size,
  Price as product_price
from
  {{ ref('product') }}

