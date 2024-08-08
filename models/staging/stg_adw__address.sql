with source as (
    select
        addressid as address_id
        , stateprovinceid as stateprovince_id
        , city
        , addressline1 as address1
        , addressline2 as address2
        , postalcode as postal_code
    from {{ source('sap_adw', 'address') }}
)

select *
from source