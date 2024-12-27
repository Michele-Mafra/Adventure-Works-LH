with
    regiao_pais as (
        select
            countryregioncode as codigo_pais
            , name as nome_pais
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao

        from  {{ source('sap_adw', 'countryregion') }}
    )

select *
from regiao_pais
