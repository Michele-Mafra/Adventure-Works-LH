with 

unidade_de_medidas as (

    select
        cast(unitmeasurecode as string) as codigo_unidade_de_medidas
        , cast(name as string) as nome_unidade_medidas
        , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as codigo_data_modificacao
    from {{ source('sap_adw', 'unitmeasure') }}

)



select *
from unidade_de_medidas
