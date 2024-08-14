with source as (
    select
        stateprovinceid
        , territoryid 
        , countryregioncode 
        , stateprovincecode as state_code
        , name as state_name
    from {{ source('sap_adw', 'stateprovince') }}
)

select *
from source
