with 

    contato_da_entidade_empresarial as (

        select 
            cast(businessentityid as int) as id_entidadede_empresarial
            , cast(personid as int) as id_pessoa
            , cast(contacttypeid as int) id_tipo_contato
            , cast(rowguid as string) as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as dt_modificacao
        from {{ source('sap_adw', 'businessentitycontact') }}

    )



select *
from contato_da_entidade_empresarial
