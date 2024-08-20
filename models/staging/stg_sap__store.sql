with 
    source as (
        select
        cast(businessentityid as int) as businessentityid 
        , cast(salespersonid as int) as salespersonid
        , name as store_name
    from {{ source('sap_adw', 'store') }}
    )

select *
from source
