with 

pessoa_cartao_credito as (

    select
        cast(businessentityid as int) as id_entidade_empresarial
        , cast(creditcardid as int) as id_cartao_credito
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao 
    from {{ source('sap_adw', 'personcreditcard') }}

)

select *
from pessoa_cartao_credito
