with source as (
    select
        salesorderdetailid as orderdetail_id,
        salesorderid as order_id,
        productid as product_id,
        specialofferid as offer_id,
        orderqty as order_qty,
        unitprice as unit_price,
        unitpricediscount as discount
    from {{ source('sap_adw', 'salesorderdetail') }}
)

select * from source
