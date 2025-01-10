with
    cliente as (
        select *
        from {{ ref('stg_sap_adw__clientes') }}
    )

    , pessoa as (
        select *            
        from {{ ref('stg_sap_adw__pessoas') }}
    )

    , lojas as (
        select*
        from {{ ref('stg_sap_adw__lojas') }}
    )

   
  
    , join_tables as (
        select
            cliente.id_cliente
            , cliente.id_loja
            , pessoa.id_pessoa
            , pessoa.tipo_pessoa
            , pessoa.nome_pessoa
            --, lojas.id_pessoa
            , lojas.name_loja
        from cliente
        left join pessoa on pessoa.id_pessoa = cliente.id_pessoa
        left join lojas on lojas.id_pessoa = cliente.id_pessoa
        
        
    )
    
    , refined as (
        select 
            {{ dbt_utils.generate_surrogate_key(['id_cliente']) }} as sk_cliente
            ,join_tables.*
            from join_tables
    )

select *
from refined
