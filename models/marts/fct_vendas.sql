with
    dim_cliente as (
        select *
        from {{ ref('dim_cliente') }}
    )
    
    , dim_vendedores as (
        select*
        from {{ ref('dim_vendedores') }}
    )

    , dim_produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )

    , dim_forma_envios as (
        select *
        from {{ ref('dim_formas_de_envios') }}
    )

    , dim_datas as (
        select *
        from {{ ref('dim_datas') }}
    )

    , dim_cartao_credito as (
        select *
        from {{ ref('dim_cartao_credito') }}
    )
    , vendas_status as (
        select *
        from {{ ref('stg_sap_adw__status_da_venda_pedidos') }}
    )

    , dim_localizacoa as (
        select *
        from {{ ref('dim_localizacao') }}
    )
    )




