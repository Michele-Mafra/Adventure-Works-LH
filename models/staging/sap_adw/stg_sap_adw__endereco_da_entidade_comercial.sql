with 

    endereco_da_entidade_comercial as (

        select  
            cast(businessentityid as int) as id_pessoa
            , cast(addressid as int) as id_endereco
            , cast(addresstypeid as int) as id_tipo_endereco
            , cast(rowguid as string) as guia_linha
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as dt_modificacao
                
        from {{ source('sap_adw', 'businessentityaddress') }}

    )


select *
from endereco_da_entidade_comercial

    