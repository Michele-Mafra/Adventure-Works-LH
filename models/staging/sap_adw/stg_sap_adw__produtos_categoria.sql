with 

produto_categoria as (

    select 
        cast(productcategoryid as int) as id_produto_categoria
        , name as nome_categoria
        , rowguid as linha_guia
       , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
   
    from {{ source('sap_adw', 'productcategory') }}

)

select *
from produto_categoria