with 

tipo_telefone as (

    select 
        cast(phonenumbertypeid as int) id_tipo_nr_telefone
        , name as nome
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao 
    from {{ source('sap_adw', 'phonenumbertype') }}

)

select * 
from tipo_telefone

