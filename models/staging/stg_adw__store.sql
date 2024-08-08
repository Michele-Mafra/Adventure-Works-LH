with source as (
    select
        businessentityid
        , name as storename
        , salespersonid
    from {{ source('sap_adw', 'store') }}
)
select *
from source