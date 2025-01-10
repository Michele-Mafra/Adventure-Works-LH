with 

    lojas as (

        select 
            cast(businessentityid as int) as id_pessoa
            , cast(name as string) as name_loja
            , cast(salespersonid as int) as id_vendedor
            , cast(demographics as string) as dados_demografico
            , cast(rowguid as string) as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'store') }}

    )



select *
from lojas
