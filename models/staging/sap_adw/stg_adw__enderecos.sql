with 

    endereco as (

        select 
            cast(addressid as int) as id_endereco
            , concat(addressline1,' ',coalesce(addressline2,'')) as ds_endereco
            , trim(city) as nome_cidade
            , cast(stateprovinceid as int) as id_estado
            , postalcode as nr_cep
            , spatiallocation as localizacao_espacial
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao

        
        
        from {{ source('sap_adw', 'address') }}

    )
select * 
from endereco