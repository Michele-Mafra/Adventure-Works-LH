with 

    contato_da_enntidade_empresarial as (

        select 
            businessentityid
            , personid
            , contacttypeid
            , rowguid
            , modifieddate
        from {{ source('sap_adw', 'businessentitycontact') }}

    )



select *
from contato_da_enntidade_empresarial
