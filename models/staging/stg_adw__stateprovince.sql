with source as (
    select
        stateprovinceid as stateprovince_id
        , countryregioncode as country_code
        , stateprovincecode as state_code
        , name as state_name
        , territoryid as territory_id
    from {{ source('sap_adw', 'stateprovince') }}
)

select *
from source
