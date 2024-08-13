with salesorderheadersalesreason as (
    select *
    from {{ref('stg_sap__salesorderheadersalesreason')}}
)

, salesreason as (
    select *
    from {{ref('stg_sap__salesreason')}}
)

, reasonbyorderid as (
    select 
        salesorderheadersalesreason.salesorderid
        , salesreason.reason
        , salesreason.reason_type
    from salesorderheadersalesreason
    left join salesreason on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid 
)

, transformed as (
    select
        salesorderid
        , reason
        , reason_type
    from reasonbyorderid
)

select *
from transformed


