with source as (
    select
        countryregioncode as country_code,
        name as country_name
    from {{ source('sap_adw', 'countryregion') }}
)

select * from source