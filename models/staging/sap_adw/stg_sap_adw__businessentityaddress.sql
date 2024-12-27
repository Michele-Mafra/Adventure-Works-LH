with 

    endereco_da_entidade_comercial as (

        select  
            businessentityid
            , addressid
            , addresstypeid
            , rowguid
            , modifieddate
        
        
        from {{ source('sap_adw', 'businessentityaddress') }}

    )


select *
from endereco_da_entidade_comercial
