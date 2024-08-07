with source as (
    select
        stateprovinceid as stateprovince_id,
        countryregioncode as country_code,
        stateprovincecode as state_code,
        name as statename
    from {{ source('sap_adw', 'stateprovince') }}
)

select * from source
