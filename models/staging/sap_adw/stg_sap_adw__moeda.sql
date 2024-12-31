with 

    moeda as (

        select 
        
            trim(currencycode) as codigo_moeda
            , trim(name) as nome
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        
        from {{ source('sap_adw', 'currency') }}


    )

select *
from moeda
