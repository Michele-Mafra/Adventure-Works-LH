with source as (
    select
        countryregioncode 
        , name as country_name
    from {{ source('sap_adw', 'countryregion') }}
)

select *
from source