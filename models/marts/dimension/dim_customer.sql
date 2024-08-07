with person as (
    select
        businessentity_id,
        first_name,
        last_name,
        name
    from {{ ref('stg_adw__person') }}
),

personcreditcard as (
    select
        creditcard_id,
        businessentity_id
    from {{ ref('stg_adw__personcreditcard') }}
),

creditcard as (
    select
        creditcard_id,
        card_type,
        card_number
    from {{ ref('stg_adw__creditcard') }}
),

customer as (
    select
        customer_id,
        store_id,
        territory_id,
        person_id
    from {{ ref('stg_adw__customer') }}
)

select
    c.customer_id,
    c.store_id,
    c.territory_id,
    c.person_id,
    p.first_name,
    p.last_name,
    p.name,
    pc.creditcard_id,
    cc.card_type,
    cc.card_number
from customer c
left join person p on c.person_id = p.businessentity_id
left join personcreditcard pc on p.businessentity_id = pc.businessentity_id
left join creditcard cc on pc.creditcard_id = cc.creditcard_id
