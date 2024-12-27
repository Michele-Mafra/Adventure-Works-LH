with 

    pais_regiao_por_moeda as (

        select 
            countryregioncode as codigo_regiao_moeda
            , trim(currencycode) as codigo_do_pais
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao

        from {{ source('sap_adw', 'countryregioncurrency') }}

    )



select * 
from pais_regiao_por_moeda
