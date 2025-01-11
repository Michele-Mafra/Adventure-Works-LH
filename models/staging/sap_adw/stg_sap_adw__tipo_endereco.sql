with 

    tipo_de_endereco as (

        select 
            cast(addresstypeid as int) as id_endereco
            , cast(name as string) as nome
            , cast(rowguid as string) as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'addresstype') }}

    )

select * 
from tipo_de_endereco 
