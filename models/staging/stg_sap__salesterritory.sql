with
    source as (
        select
            cast(territoryid as int) as territoryid
            , name as region
            , countryregioncode as country_code
            , `group` as continent
            , cast(salesytd as numeric) as regionsalesyear
            , cast(saleslastyear as numeric) as regionsaleslastyear
        from {{ source('sap_adw', 'salesterritory') }}
    )
select *
from source
