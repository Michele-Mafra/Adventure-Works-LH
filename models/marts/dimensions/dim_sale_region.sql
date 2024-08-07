select
  TerritoryID as sales_territory_id,
  Region as sales_region,
  Country as sales_country,
  City as sales_city
from
  {{ ref('salesterritory') }}
