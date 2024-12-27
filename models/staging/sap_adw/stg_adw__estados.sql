with
    estados as (
        select 
            cast(stateprovinceid as int) as id_estado
            , trim(stateprovincecode) as codigo_estado
            , trim(countryregioncode) as codigo_pais
            , cast(isonlystateprovinceflag as boolean) as is_estado_pais
            , trim(name) as nome_estado
            , cast(territoryid as int) as id_territorio
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao     

        from {{ source('sap_adw', 'stateprovince') }}
    )

select *
from estados


    