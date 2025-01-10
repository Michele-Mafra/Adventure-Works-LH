with
    estados as (
        select 
            cast(stateprovinceid as int) as id_estado
            , cast(stateprovincecode as string) as codigo_estado
            , cast(countryregioncode as string) as codigo_pais
            , cast(isonlystateprovinceflag as boolean) as is_estado_pais
            , cast(name as string) as nome_estado
            , cast(territoryid as int) as id_territorio
            , cast(rowguid as string) as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao     

        from {{ source('sap_adw', 'stateprovince') }}
    )

select *
from estados


    