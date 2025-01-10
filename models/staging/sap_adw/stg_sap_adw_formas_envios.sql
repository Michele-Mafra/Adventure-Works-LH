
with 

    stg_formas_envios as (

        select  
            cast(shipmethodid as int) as id_forma_envio
            , cast(name as string) as nm_forma_envio
            , coalesce(round(cast(shipbase as numeric),2),1) as valor_envio_minimo
            , coalesce(round(cast(shiprate as numeric),2),1) as valor_envio_por_kg
            , rowguid as linha_guia
            , format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as data_modificacao 
        from {{ source('sap_adw', 'shipmethod') }}

    )

select * 
from stg_formas_envios