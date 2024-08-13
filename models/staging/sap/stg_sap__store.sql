with source as (
    select
    businessentityid 
    , salespersonid 
    , name as store_name
    from {{ source('sap_adw', 'store') }}
)

select *
from source