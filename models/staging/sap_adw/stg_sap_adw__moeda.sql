with 

    moeda as (

        select 
        
            cast(currencycode as string) as codigo_moeda
            , cast(name as string) as nome
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        
        from {{ source('sap_adw', 'currency') }}


    )

select *
from moeda
