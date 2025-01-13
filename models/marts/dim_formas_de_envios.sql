with

    stg_formas_de_envios as (
        select 
            id_forma_envio
            , nm_forma_envio
            , valor_envio_minimo
            , valor_envio_por_kg
        from {{ ref('stg_sap_adw_formas_envios') }}
    ) 

    , join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_forma_envio']) }} as sk_forma_envio
            , stg_formas_de_envios.*      
        from stg_formas_de_envios
        
    )



select *
from join_tables_final   