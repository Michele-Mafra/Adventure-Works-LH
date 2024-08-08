with source as (
    select
        stateprovinceid as stateprovince_id,
        countryregioncode as country_code,
        stateprovincecode as state_code,
        name as state_name
    from {{ source('sap_adw', 'stateprovince') }}
)

select * from source
