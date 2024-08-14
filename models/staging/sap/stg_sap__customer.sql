with source as (
    select
    customerid 
    , personid 
    , storeid 
    , territoryid
    from {{ source('sap_adw', 'customer') }}
)

select *
from source