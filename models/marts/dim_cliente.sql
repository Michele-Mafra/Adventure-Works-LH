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
            , pessoa.nome_pessoa
            , cliente.id_loja
            , pessoa.tipo_pessoa
            , lojas.id_pessoa
            , lojas.name_loja
            , lojas.id_vendedor
        from cliente
        left join pessoa on pessoa.id_pessoa = cliente.id_pessoa
        left join lojas on lojas.id_pessoa = cliente.id_loja
        
        
        
    )
    
    , join_tables_final as (
        select 
            {{ dbt_utils.generate_surrogate_key(['id_cliente']) }} as sk_cliente
            ,join_tables.*
            from join_tables
    )

select *
from join_tables_final
