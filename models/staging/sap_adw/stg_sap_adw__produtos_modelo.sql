with 

produto_modelo as (

    select 
        cast(productmodelid as int) as id_produto_modelo
        , cast(name as string) as nome_modelo_produto
        , case 
            when catalogdescription = '[NULL]'
            then null else catalogdescription 
            end as descricao_catalago
        , case
            when instructions = '[NULL]' 
            then null else instructions
            end as instrucoes 
        , cast(rowguid as string) as linha_guia
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
    from {{ source('sap_adw', 'productmodel') }}

)

select * 
from produto_modelo
