with 

    pessoas_telefone as (

        select 
            cast(businessentityid as int) as id_pessoas
            , trim(regexp_replace(phonenumber, '[^0-9]', '')) as numero_telefone
            , cast(phonenumbertypeid as int) id_numero_telefone
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao

        from {{ source('sap_adw', 'personphone') }}

    )

select * 
from pessoas_telefone

