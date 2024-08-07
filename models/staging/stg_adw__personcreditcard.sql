with source as (
    select
        creditcardid as creditcard_id,
        businessentityid as businessentity_id
    from {{ source('sap_adw', 'personcreditcard') }}
)

select * from source
