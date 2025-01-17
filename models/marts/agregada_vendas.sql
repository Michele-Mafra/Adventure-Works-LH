with
    pessoa as (
     select *
     from {{ ref('stg_sap_adw__pessoas') }}

    )
    
    , fct_vendas as (
        select *
        from {{ ref('fct_vendas') }}
    )

    , regiao as (
        select *
        from {{ ref('dim_localizacao') }}
    )

    , agregacao as (
        select
          fct_vendas.id_vendedor
          , regiao.nome_estado
          , count(distinct fct_vendas.id_pedido_venda) as total_pedido
          , sum(fct_vendas.qt_pedido_item) as total_produto_qty -- pedidos comprados total
          , sum(fct_vendas.valor_total) as valor_total_vendas -- receita total
          , sum(fct_vendas.valor_subtotal) as sub_total
          , sum(fct_vendas.desconto_item) as valor_desconto --desconto
          , sum(fct_vendas.valor_frete) as total_frete
          , avg(fct_vendas.valor_total) as media_total_produto -- media do produto 
          , count(distinct fct_vendas.id_pedido_venda) as total_qty_vendas
          , count(distinct fct_vendas.id_vendedor) as total_vendedor  
        from fct_vendas
        left join pessoa on pessoa.id_pessoa = fct_vendas.id_vendedor
        left join regiao on regiao.id_endereco = fct_vendas.id_endereco_cobranca
        group by id_vendedor, nome_estado
    )

select *
from agregacao


 
  
    

