with
    dim_localizacao as (
        select *
        from {{ ref('dim_localizacao') }}
    )

    , stg_sap_adw__pessoas as (
        select *
        from {{ ref('stg_sap_adw__pessoas') }}
    )  

    , dim_cliente as (
        select *
        from {{ ref('dim_cliente') }}
    )

    , stg_sap_adw__vendas_item_pedidos as (
        select *
        from {{ ref('stg_sap_adw__vendas_item_pedidos') }}
    )

    , stg_status_da_venda_pedidos as (
        select *
        from {{ ref('stg_sap_adw__status_da_venda_pedidos') }}
    )

      
    
    , fct_vendas as (
        select 
            stg_sap_adw__vendas_item_pedidos.id_pedido_venda
            , dim_cliente.id_cliente
            , dim_localizacao.id_endereco
            , dim_cliente.nome_pessoa
            , dim_cliente.id_vendedor
            , stg_sap_adw__vendas_item_pedidos.id_pedido_venda_item
            , stg_sap_adw__vendas_item_pedidos.numero_rastreamento
            , stg_sap_adw__vendas_item_pedidos.qt_pedido_item
            , stg_sap_adw__vendas_item_pedidos.id_produto
            , stg_sap_adw__vendas_item_pedidos.id_promocao
            , stg_sap_adw__vendas_item_pedidos.valor_unitario_item
            , stg_sap_adw__vendas_item_pedidos.desconto_item 
            , stg_status_da_venda_pedidos.valor_imposto
            , stg_status_da_venda_pedidos.valor_subtotal
            , stg_status_da_venda_pedidos.valor_frete
            , stg_status_da_venda_pedidos.id_territorio
            --, stg_sap_adw__pessoas.id_pessoa
            
            --, stg_status_da_venda_pedidos.id_vendedor
            , stg_status_da_venda_pedidos.id_endereco_cobranca
            , stg_status_da_venda_pedidos.id_cartao_credito
            , stg_status_da_venda_pedidos.cd_status
            , stg_status_da_venda_pedidos.data_pedido
            , stg_status_da_venda_pedidos.valor_total
            , (valor_unitario_item * qt_pedido_item) as valor_bruto -- sem desconto
            , ((1 - stg_sap_adw__vendas_item_pedidos.desconto_item) * (stg_sap_adw__vendas_item_pedidos.valor_unitario_item * stg_sap_adw__vendas_item_pedidos.qt_pedido_item)) as valor_liquido -- com desconto
            
        from stg_sap_adw__vendas_item_pedidos
        left join stg_status_da_venda_pedidos on stg_sap_adw__vendas_item_pedidos.id_pedido_venda =  stg_status_da_venda_pedidos.id_pedido_venda
        left join dim_localizacao on stg_status_da_venda_pedidos.id_endereco = dim_localizacao.id_endereco
        left join dim_cliente on dim_cliente.id_cliente = stg_status_da_venda_pedidos.id_cliente 
    )

    , join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_pedido_venda','id_endereco','id_cliente']) }} as sk_fct_vendas_pedidos
            ,fct_vendas.*
        from fct_vendas

    )



select *
from join_tables_final

