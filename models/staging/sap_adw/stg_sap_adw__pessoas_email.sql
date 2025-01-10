with 

    endereco_email as (

        select 
            cast(businessentityid as int) as id_pessoa
            , cast(emailaddressid as int) as id_endereco_email
            , emailaddress.emailaddress as endereco_email
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'emailaddress') }}

    )


select *
from endereco_email

