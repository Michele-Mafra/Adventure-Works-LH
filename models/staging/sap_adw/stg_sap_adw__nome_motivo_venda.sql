with
   
    nome_motivo_venda as (
        select
            cast(salesreasonid as int) as id_motivo_venda
            ,cast(name as string) as nm_motivo_venda
            ,cast(reasontype as string) as cd_motivo_venda
            ,cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao        
        
        from {{ source('sap_adw', 'salesreason') }}
    )

select * 
from nome_motivo_venda

