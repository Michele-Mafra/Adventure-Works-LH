with 

    vendedores as (

        select 
            cast(businessentityid as int) as id_vendedor
            , cast(territoryid as int) as id_territorio
            , coalesce(round(cast(salesquota as numeric),2),0) as voluma_cota_vendas
            , coalesce(round(cast(bonus as numeric),2),0) as volume_bonus
            , coalesce(round(cast(commissionpct as numeric),3),0) as comissao
            , coalesce(round(cast(salesytd as numeric),2),0) as volume_vendas
            , coalesce(round(cast(saleslastyear as numeric),2),0) volume_ultima_venda_por_ano
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao

        from {{ source('sap_adw', 'salesperson') }}

    )

select * 
from vendedores
