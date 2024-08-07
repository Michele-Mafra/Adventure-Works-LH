with salesreason as (
    select
        reason_id,
        reason,
        reason_type
    from {{ ref('stg_adw__salesreason') }}
),

salesheadersalesreason as (
    select
        order_id,
        reason_id
    from {{ ref('stg_adw__salesheadersalesreason') }}
)

select
    sr.reason_id,
    shsr.order_id,
    sr.reason,
    sr.reason_type
from salesreason sr
join salesheadersalesreason shsr on sr.reason_id = shsr.reason_id
