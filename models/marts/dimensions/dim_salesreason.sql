with salesreason as (
    select
        reason_id,
        reason,
        reason_type
    from {{ ref('stg_adw__salesreason') }}
),

salesorderheadersalesreason as (
    select
        order_id,
        reason_id
    from {{ ref('stg_adw__salesorderheadersalesreason') }}
)

select
    sr.reason_id,
    shsr.order_id,
    sr.reason,
    sr.reason_type
from salesreason sr
join salesorderheadersalesreason shsr on sr.reason_id = shsr.reason_id