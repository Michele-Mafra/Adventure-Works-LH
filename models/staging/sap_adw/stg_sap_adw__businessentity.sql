with 

    id_entidade_empresarial as (

        select 
            cast(businessentityid as int) id_entidade_empresarial
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'businessentity') }}

    )



select * 
from id_entidade_empresarial
