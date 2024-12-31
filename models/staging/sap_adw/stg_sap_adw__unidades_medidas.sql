with 

unidade_de_medidas as (

    select
        trim(unitmeasurecode) as unidade_de_medidas
        , trim(name) as nome_unidade_medidas
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
    from {{ source('sap_adw', 'unitmeasure') }}

)



select *
from unidade_de_medidas
