with

    stg_cartao_credito as (
        select *
        from {{ ref('stg_sap_adw__cartao_credito') }}
    )

    , stg_pessoa_cartao_credito as (
        select *
        from {{ ref('stg_sap_adw__pessoa_cartao_credito') }}
    )

    , join_tables as (
        select
            stg_cartao_credito.id_cartao_credito
            , stg_pessoa_cartao_credito.id_entidade_empresarial
            , stg_cartao_credito.tipo_cartao_credito
            , stg_cartao_credito.numero_cartao_credito 
            , stg_cartao_credito.numero_expiracao_mes_cartao_credito || '-' || numero_expiracao_ano_cartao_credito as data_expiracao
            --, stg_cartao_credito.id_cartao_credito
            
        from stg_pessoa_cartao_credito
        left join stg_cartao_credito on 
            stg_pessoa_cartao_credito.id_cartao_credito = stg_cartao_credito.id_cartao_credito
    )

    , join_tables_final as (
        select 
            {{ dbt_utils.generate_surrogate_key(['id_cartao_credito','numero_cartao_credito']) }} as sk_cartao_credito
            ,join_tables.*
        from join_tables
    )

select *
from join_tables_final



