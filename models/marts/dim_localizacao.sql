with
    stg_endereco as (
        select *
        from {{ ref('stg_adw__enderecos') }}
    )

    , stg_estados as (
        select *
        from {{ ref('stg_adw__estados') }}
    )
   
    , stg_regiao_pais as (
        select * 
        from {{ ref('stg_adw__regiao_pais') }}
    )
       
   

    , join_tables as (
        select 
            stg_endereco.id_endereco
            , stg_endereco.id_estado
            , stg_endereco.nome_cidade
            , stg_estados.codigo_pais
            , stg_estados.nome_estado
            , stg_regiao_pais.nome_pais           
        from stg_endereco
        left join stg_estados on stg_endereco.id_estado = stg_estados.id_estado
        left join stg_regiao_pais on stg_estados.codigo_pais = stg_regiao_pais.codigo_pais
    )

    , join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_endereco']) }} as sk_localizacao
            ,join_tables.*      
        from join_tables
        
    )            

    

select*
from join_tables_final

