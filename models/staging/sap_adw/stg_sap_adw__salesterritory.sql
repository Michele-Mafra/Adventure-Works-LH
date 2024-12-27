with 

    territorio_de_vendas as (

        select 
            cast(territoryid as int) as id_territorio
            , name as nome_territorio
            , trim(countryregioncode) as codigo_pais
            , trim(`group`) as grupo_territorial
            , coalesce(round(cast(salesytd as numeric),2),0) as vl_venda_ytd
            , coalesce(round(cast(saleslastyear as numeric),2),0) as vl_venda_ultimo_ano
            , coalesce(round(cast(costytd as numeric),2),0) as vl_custo_ytd
            , coalesce(round(cast(costlastyear as numeric),2),0) as vl_custo_ultimo_ano
            , rowguid
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as dt_modificacao        

            
        from {{ source('sap_adw', 'salesterritory') }}
    )



select*
from territorio_de_vendas
