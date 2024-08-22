with
    salesreason as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )
    , salesorderheadersalesreason as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )
    , transformed as (
        select
            {{ surrogate_key([
                'salesorderheadersalesreason.salesorderid'
            ]) }} as sk_salesreason
            , salesorderheadersalesreason.salesorderid
            , salesorderheadersalesreason.salesreasonid
            , salesreason.reason
            , salesreason.reason_type
        from salesorderheadersalesreason
        left join salesreason on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid
    )
    
select *
from transformed
