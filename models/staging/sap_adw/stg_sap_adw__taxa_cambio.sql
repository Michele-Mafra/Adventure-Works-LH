with 

taxa_cambio as (

    select 
        cast(currencyrateid as int) as id_taxa_cambio
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(currencyratedate as timestamp)) as timestamp) as data_taxa_cambio
        , cast(fromcurrencycode as string) as para_codigo_moeda 
        , cast(tocurrencycode as string) as de_codigo_moeda
        , coalesce(round(cast(averagerate as numeric),4),0) as taxa_media
        , coalesce(round(cast(endofdayrate as numeric),4),0) as taxa_fim_do_dia
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
    
    from {{ source('sap_adw', 'currencyrate') }}

)

select * 
from taxa_cambio

