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
        select 
        id_pedido_venda
        , nr_revisao_pedido
        , date(data_pedido) as data_pedido
        , data_pagamento
        , data_envio
        , cd_status
        , pedido_realizado_online
        , nr_ordem_compra
        , nr_conta_financeira
        , id_cliente
        , id_vendedor
        , id_territorio
        , id_endereco_cobranca
        , id_endereco
        , id_forma_envio
        , id_cartao_credito
        , cd_aprovacao_cartao_credito
        , id_taxa_cambio
        , valor_subtotal
        , valor_imposto
        , valor_frete
        , valor_total
        , comentario
         
        from {{ ref('stg_sap_adw__status_da_venda_pedidos') }}
    )

    , dim_datas as (
        select *
        from {{ ref('dim_datas') }}
    )

    , dim_cartao_credito as (
        select *
        from {{ ref('dim_cartao_credito') }}
    )  
    
    , dim_formas_de_envios as (
        select *
        from {{ ref('dim_formas_de_envios') }}
    )

    , dim_endereco as (
        select *
        from {{ ref('dim_endereco') }}
    )

    , dim_motivo_vendas as (
        select *
        from {{ ref('dim_motivo_venda') }}
    )

    , dim_vendedor as (
        select *
        from {{ ref('dim_vendedores') }}
    )

    , dim_produtos as (
        select *
        from {{ ref('dim_produtos') }}
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
            , stg_status_da_venda_pedidos.id_endereco_cobranca
            , stg_status_da_venda_pedidos.id_cartao_credito
            , stg_status_da_venda_pedidos.cd_status
            , stg_status_da_venda_pedidos.data_pedido
            , stg_status_da_venda_pedidos.valor_total
            , (valor_unitario_item * qt_pedido_item) as valor_bruto -- sem desconto
            , ((1 - stg_sap_adw__vendas_item_pedidos.desconto_item) * (stg_sap_adw__vendas_item_pedidos.valor_unitario_item * stg_sap_adw__vendas_item_pedidos.qt_pedido_item)) as valor_liquido -- com desconto
            , dim_localizacao.sk_localizacao
            , dim_cliente.sk_cliente
            , dim_datas.sk_data
            , dim_cartao_credito.sk_cartao_credito
            , dim_endereco.sk_endereco
            --, dim_forma_de_envios.sk_forma_envio
            --, dim_motivo_vendas.sk_motivo_venda
            , dim_produtos.sk_produto
            , dim_vendedor.sk_vendedor
            
            
        from stg_sap_adw__vendas_item_pedidos
        left join stg_status_da_venda_pedidos on stg_sap_adw__vendas_item_pedidos.id_pedido_venda =  stg_status_da_venda_pedidos.id_pedido_venda
        left join dim_datas on stg_status_da_venda_pedidos.data_pedido = dim_datas.dia
        left join dim_localizacao on stg_status_da_venda_pedidos.id_endereco = dim_localizacao.id_endereco
        left join dim_cliente on dim_cliente.id_cliente = stg_status_da_venda_pedidos.id_cliente
        left join dim_cartao_credito on stg_status_da_venda_pedidos.id_pedido_venda = dim_cartao_credito.id_cartao_credito
        left join dim_endereco on dim_localizacao.id_endereco = dim_endereco.id_endereco
        left join dim_produtos on stg_sap_adw__vendas_item_pedidos.id_pedido_venda_item = dim_produtos.id_produto
        left join dim_vendedor on dim_cliente.id_cliente = dim_vendedor.id_vendedor
        --left join dim_formas_de_envios on stg_status_da_venda_pedidos.id_pedido_venda = dim_formas_de_envios.id_forma_envio


        
        


    )

    , join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_pedido_venda','id_endereco','id_cliente']) }} as sk_fct_vendas_pedidos
            ,fct_vendas.*
        from fct_vendas

    )



select *
from join_tables_final

