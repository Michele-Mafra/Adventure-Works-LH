with
    source as (
        select
            territoryid
            , name as region_name
            , countryregioncode as country_code
            , `group` as continent
            , salesytd as salesyear
            , saleslastyear as saleslastyear
        from {{ source('sap_adw', 'salesterritory') }}
    )
select *
from source