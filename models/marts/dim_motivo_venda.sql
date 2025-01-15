with
    --stg_status_da_venda_pedidos as (
    --    select *
    --    from {{ ref('stg_sap_adw__status_da_venda_pedidos') }}
    --)

    stg_motivo_vendas as (
        select *
        from {{ ref('stg_sap_adw__motivo_vendas') }}
    )

    , stg_nome_motivo_venda as (
        select *
        from {{ ref('stg_sap_adw__nome_motivo_venda') }}
    )
            
    
    , join_tables as (
        select
            stg_motivo_vendas.id_pedido_venda
            --, stg_motivo_vendas.id_motivo_venda
            , stg_nome_motivo_venda.id_motivo_venda
            , stg_nome_motivo_venda.nm_motivo_venda
            , stg_nome_motivo_venda.cd_motivo_venda
        from stg_motivo_vendas
        left join stg_nome_motivo_venda on stg_nome_motivo_venda.id_motivo_venda = stg_motivo_vendas.id_motivo_venda

    )

    , join_tables_final as (

            select 
                {{ dbt_utils.generate_surrogate_key(['id_motivo_venda']) }} as sk_motivo_venda
                ,join_tables.*      
            from join_tables
        )

select *
from join_tables_final


    
    
    
    
    
    
    
    --, join_tables as (
    --    select
    --        stg_status_da_venda_pedidos.id_pedido_venda
    --        , stg_motivo_vendas.id_motivo_venda
    --        , stg_status_da_venda_pedidos.id_vendedor
    --        , stg_status_da_venda_pedidos.id_territorio
    --        --, stg_status_da_venda_pedidos.id_endereco_cobranca
    --        --, stg_status_da_venda_pedidos.id_endereco_entrega
    --        , stg_status_da_venda_pedidos.id_forma_envio
    --        , stg_status_da_venda_pedidos.id_cartao_credito
    --        , stg_status_da_venda_pedidos.cd_aprovacao_cartao_credito
    --        --, stg_status_da_venda_pedidos.id_taxa_cambio
    --        , stg_status_da_venda_pedidos.valor_subtotal
    --        , stg_status_da_venda_pedidos.valor_imposto
    --        , stg_status_da_venda_pedidos.valor_frete
    --        , stg_status_da_venda_pedidos.valor_total
    --        , stg_status_da_venda_pedidos.comentario
    --        --, stg_status_da_venda_pedidos.linha_guia
    --        , stg_status_da_venda_pedidos.dt_modificacao
    --        , stg_nome_motivo_venda.nm_motivo_venda
    --        , stg_nome_motivo_venda.cd_motivo_venda
--
    --    from stg_motivo_vendas 
    --    --inner join stg_motivo_vendas 
    --        --on stg_status_da_venda_pedidos.id_pedido_venda = stg_motivo_vendas.id_pedido_venda
    --    left join stg_nome_motivo_venda 
    --        on stg_motivo_vendas.id_motivo_venda = stg_nome_motivo_venda.id_motivo_venda
    --)
--

    l