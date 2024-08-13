with salesorderheader as (
    select 
        distinct(creditcardid)
    from {{ref('stg_sap__salesorderheader')}}
    where creditcardid is not null
)

, creditcard as (
    select *
    from {{ref('stg_sap__creditcard')}}
)

, transformed as (
    select 
        row_number() over (order by salesorderheader.creditcardid) as sk_creditcard -- auto-incremental surrogate key	
        , salesorderheader.creditcardid
        , creditcard.card_type
        , creditcard.card_number
    from salesorderheader 
    left join creditcard on salesorderheader.creditcardid = creditcard.creditcardid
)

select *
from transformed