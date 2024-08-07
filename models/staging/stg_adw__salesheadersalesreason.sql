with source as (
    select
        salesorderid as order_id,
        salesreasonid as reason_id
    from {{ source('sap_adw', 'salesorderheadersalesreason') }}
)

select * from source
