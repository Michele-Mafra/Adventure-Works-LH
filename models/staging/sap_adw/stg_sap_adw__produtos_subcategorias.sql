with 

subcategorya_produtos as (

    select 
        cast(productsubcategoryid as int) as id_subcategoria_produto
        , cast(productcategoryid as int) as id_categoria_produto
        , name as nome_subcategoria_produto
        , rowguid as linhas_guias
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
    from {{ source('sap_adw', 'productsubcategory') }}

)



select *
from subcategorya_produtos
