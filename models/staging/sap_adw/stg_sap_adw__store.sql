with 

    lojas as (

        select 
            cast(businessentityid as int) as id_entidade_empresarial
            , trim(name) as name_loja
            , cast(salespersonid as int) as id_vendedor
            , demographics as dados_demografico
            , rowguid as guia_de_linha
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'store') }}

    )



select *
from lojas
