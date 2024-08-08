with source as (
    select
        customerid as customer_id
        , storeid as store_id
        , territoryid as territory_id
        , personid as person_id
    from {{ source('sap_adw', 'customer') }}
)

select *
from source
