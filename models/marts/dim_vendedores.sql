with
    stg_vendedores as (
        select *
        from {{ ref('stg_sap_adw__vendedor') }}
    )

    , dim_endereco as (
        select *
        from {{ ref('dim_endereco') }}
    )

    , stg_status_da_venda_pedidos as (
        select *
        from {{ ref('stg_sap_adw__status_da_venda_pedidos') }}
    )
    
    , stg_vendas_item_pedidos as (
        select *
        from {{ ref('stg_sap_adw__vendas_item_pedidos') }}
    )

       

    , vendas_vendedor as (
        select 
            id_vendedor
            , min(data_pedido) as dt_primeira_venda
            , max(data_envio) as data_ultima_venda
            , count(distinct id_pedido_venda) as qt_pedidos_venda
            , sum(valor_total) as valor_total_venda
            --, vendas_vendedor.dt_modificacao
        from {{ ref('stg_sap_adw__status_da_venda_pedidos') }} as stg_venda_pedidos
        group by id_vendedor

    )

    , join_tables as (
        
        select
           
            stg_vendedores.id_vendedor
            , dim_endereco.nome_pessoa
            , dim_endereco.ds_endereco
            , dim_endereco.nome_cidade
            , dim_endereco.nome_estado
            , dim_endereco.nome_pais
            , round(stg_vendedores.voluma_cota_vendas,2) as valor_conta_vendas
            , round(stg_vendedores.volume_bonus,2) as valor_bonus
            , round(stg_vendedores.comissao,1) as comissao
            , round(stg_vendedores.volume_ultima_venda_por_ano) as valor_ultima_venda_ano
            , vendas_vendedor.dt_primeira_venda
            , vendas_vendedor.data_ultima_venda
            , coalesce(vendas_vendedor.qt_pedidos_venda,0) as qt_pedidos_venda
            , ROUND(coalesce(vendas_vendedor.valor_total_venda,0),2) as valor_total_venda
           
        from stg_vendedores
        inner join vendas_vendedor on stg_vendedores.id_vendedor = vendas_vendedor.id_vendedor
        left join dim_endereco on dim_endereco.id_pessoa = stg_vendedores.id_vendedor
    )

    ,join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_vendedor']) }} as sk_vendedor
            ,join_tables.* 
        from join_tables
        
    )

select *
from join_tables_final
