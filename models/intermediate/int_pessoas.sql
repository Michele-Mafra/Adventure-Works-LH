with
    stg_pessoas as (
        select *
        from {{ ref('stg_sap_adw__pessoas') }}
    )
    , stg_telefones_pessoas as (
        select *
        from {{ ref('stg_sap_adw__telefone_pessoas') }}      
    )

    , stg_tipo_telefones as (
        select *
        from {{ ref('stg_sap_adw__tipo_telefones') }}
    )

    , stg_pessoas_email as (
        select *
        from {{ ref('stg_sap_adw__pessoas_email') }}
    )

    , join_tables as (
        select
            stg_pessoas.id_pessoa
            , stg_pessoas.tipo_pessoa
            --, stg_pessoas.estilo_de_nome
            , stg_pessoas.nome_pessoa
            , stg_pessoas.email_promocional
            , stg_pessoas.contato_adicional
            , stg_telefones_pessoas.numero_telefone
            , stg_pessoas.dados_demograficos
            --, stg_pessoas.linha_guia
            --, stg_pessoas.data_modificacao
            --, stg_telefones_pessoas.id_pessoa
            , stg_telefones_pessoas.id_telefone
            --, stg_telefones_pessoas.data_modificacao
            --, stg_tipo_telefones.id_telefone
            , stg_tipo_telefones.nome as tipo_telefone
            --, stg_tipo_telefones.data_modificacao
            --, stg_pessoas_email.id_pessoa
            , stg_pessoas_email.id_endereco_email
            --, stg_pessoas_email.endereco_email
            --, stg_pessoas_email.linha_guia
            , stg_pessoas_email.data_modificacao
         from stg_pessoas
        left join stg_pessoas_email 
            on stg_pessoas_email.id_pessoa = stg_pessoas.id_pessoa
        left join stg_telefones_pessoas 
            on stg_telefones_pessoas.id_pessoa = stg_pessoas.id_pessoa
        left join stg_tipo_telefones 
            on stg_telefones_pessoas.id_telefone = stg_tipo_telefones.id_telefone


    )

select * 
from join_tables
    
    