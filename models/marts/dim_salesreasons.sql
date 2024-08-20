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
                , 'salesorderheadersalesreason.salesreasonid'
            ]) }} as sk_salesreason
            , salesorderheadersalesreason.salesorderid
            , salesorderheadersalesreason.salesreasonid
            , CONCAT(salesreason.reason, ' - ', salesreason.reason_type) AS reason_and_type
        from salesorderheadersalesreason
        left join salesreason on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid
    )
    
select *
from transformed
