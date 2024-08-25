with
    salesreason as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )
    , salesorderheadersalesreason as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )
    , aggregated_reasons as (
        select
            salesorderheadersalesreason.salesorderid
            , string_agg(salesreason.reason, ', ') as combined_reasons -- Combine the salesreason per saleorderid
        from salesorderheadersalesreason
        left join salesreason on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid
        group by salesorderheadersalesreason.salesorderid
    )
    
select
    {{ surrogate_key('salesorderid') }} as sk_salesreason 
    , salesorderid
    , combined_reasons 
from aggregated_reasons
