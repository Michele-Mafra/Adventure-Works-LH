with
    endereco as (
        select *
        from {{ ref('stg_adw__enderecos') }}
    )
    
    , estados as (
        select *
        from {{ ref('stg_adw__estados') }}
    )
   
    , regiao_pais as (
        select * 
        from {{ ref('stg_adw__regiao_pais') }}
    )

    , pessoas_entidade as (
        select *
        from {{ ref('stg_sap_adw__endereco_da_entidade_comercial') }}
    )

    , tipo_endereco as (
        select *
        from {{ ref('stg_sap_adw__tipo_endereco') }}
    )

    , int_pessoas as (
        select *
        from {{ ref('int_pessoas') }}
    )

       
    , join_tables as (
        select 
            endereco.id_endereco
            --, endereco.id_estado
            , endereco.ds_endereco
            , endereco.nome_cidade
            , estados.nome_estado
            , regiao_pais.nome_pais
            , endereco.nr_cep
            , estados.codigo_estado
            , estados.codigo_pais
            --, estados.is_estado_pais
            --, estados.id_territorio
            , pessoas_entidade.id_pessoa
            , pessoas_entidade.id_tipo_endereco
            , tipo_endereco.nome as tipo_endereco_nome
            , int_pessoas.nome_pessoa
        from endereco
        left join estados on endereco.id_estado = estados.id_estado
        left join regiao_pais on estados.codigo_pais = regiao_pais.codigo_pais
        left join pessoas_entidade on pessoas_entidade.id_endereco = endereco.id_endereco
        left join tipo_endereco on pessoas_entidade.id_tipo_endereco = tipo_endereco.id_endereco
        left join int_pessoas on int_pessoas.id_pessoa = pessoas_entidade.id_pessoa
        
        

    )

    , join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_endereco']) }} as sk_endereco
            ,join_tables.*      
        from join_tables
        
    )



select *
from join_tables_final   
    