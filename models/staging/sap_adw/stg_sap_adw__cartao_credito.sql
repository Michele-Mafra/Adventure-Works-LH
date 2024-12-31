with 

    cartao_credito as (

        select 
            cast(creditcardid as int) as id_cartao_credito
            , trim(cardtype) as tipo_cartao_credito
            , cast(cardnumber as int) as numero_cartao_credito
            , cast(expmonth as int) as numero_expiracao_mes_cartao_credito
            , cast(expyear as int) as numero_expiracao_ano_cartao_credito
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao 
        from {{ source('sap_adw', 'creditcard') }}

    )

    

select * 
from cartao_credito

