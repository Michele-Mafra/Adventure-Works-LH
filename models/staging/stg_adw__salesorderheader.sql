with source as (
    select
        salesorderid as order_id,
        customerid as customer_id,
        territoryid as territory_id,
        creditcardid as creditcard_id,
        shiptoaddressid as shiptoaddress_id,
        orderdate as order_date,
        duedate as due_date,
        shipdate as ship_date,
        status,
        subtotal,
        taxamt as tax,
        freight,
        totaldue as total
    from {{ source('sap_adw', 'salesorderheader') }}
)

select * from source
