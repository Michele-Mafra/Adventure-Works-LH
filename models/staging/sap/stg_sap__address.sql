with source as (
    select
    addressid
    , stateprovinceid 
    , city
    , addressline1 as address1
    , addressline2 as address2
    , postalcode
    from {{ source('sap_adw', 'address') }}
)

select *
from source