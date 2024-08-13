with source as (
    select
        salesorderdetailid as orderdetail_id
        , salesorderid as order_id
        , productid as product_id
        , specialofferid as offer_id
        , orderqty as order_qty
        , unitprice as unit_price
        , unitpricediscount as discount
    from {{ source('sap_adw', 'salesorderdetail') }}
),

-- Calcula o valor total de cada pedido
order_totals as (
    select
        order_id
        , sum(order_qty * (unit_price - unit_price * discount)) as total_order_value
    from source
    group by order_id
),

-- Calcula o número de itens por pedido (se necessário para o ticket médio por item)
order_item_counts as (
    select
        order_id
        , count(orderdetail_id) as item_count
    from source
    group by order_id
),

-- Combina as informações de valor total e contagem de itens por pedido
order_summary as (
    select
        o.order_id
        , o.total_order_value
        , i.item_count
        , total_order_value / nullif(item_count, 0) as average_ticket_value_per_item
    from order_totals o
    join order_item_counts i
    on o.order_id = i.order_id
)

-- Seleciona o ticket médio por pedido
select
    order_id
    , cast(average_ticket_value_per_item as integer) as average_ticket_value
from order_summary