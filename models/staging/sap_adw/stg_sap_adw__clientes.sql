with 

    clientes as (

        select 
            cast(customerid as int) as id_cliente
            , cast(personid as int) as id_pessoa
            , cast(storeid as int) as id_loja
            , cast(territoryid as int) id_territorio
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%m %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'customer') }}

    )

select *
from clientes
