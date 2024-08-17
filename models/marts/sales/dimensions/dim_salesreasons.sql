with stg_salesorderheadersalesreason as (
    select *
    from {{ref('stg_sap__salesorderheadersalesreason')}}
)

, stg_salesreason as (
    select *
    from {{ref('stg_sap__salesreason')}}
)

, reasonbyorderid as (
    select 
        stg_salesorderheadersalesreason.salesorderid
        , stg_salesreason.reason 
    from stg_salesorderheadersalesreason
    left join stg_salesreason on stg_salesorderheadersalesreason.salesreasonid = stg_salesreason.salesreasonid 
)

, transformed as (
    select
        salesorderid
        -- function used to aggregate in one row any multiple reasons attributed to a single salesorderid
        , string_agg(reason, ', ') as reason_name
    from reasonbyorderid
    group by salesorderid
)

select *
from transformed


