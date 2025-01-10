with 

motivo_vendas_por_pedido as (

    select 
        cast(salesorderid as int) as id_pedido_venda
        , cast(salesreasonid as int) as id_motivo_venda
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as dt_modificacao
    from {{ source('sap_adw', 'salesorderheadersalesreason') }}



)

select * 
from motivo_vendas_por_pedido
