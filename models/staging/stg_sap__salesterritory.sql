with
    source as (
        select
            cast(territoryid as int) as territoryid
            , name as region_name
            , countryregioncode as country_code
            , `group` as continent
            , cast(salesytd as numeric) as yearsales
            , cast(saleslastyear as numeric) as saleslastyear 
        from {{ source('sap_adw', 'salesterritory') }}
    )
select *
from source
