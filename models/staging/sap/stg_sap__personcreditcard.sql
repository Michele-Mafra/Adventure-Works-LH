with source as (
    select
    creditcardid 
    , businessentityid 
    from {{ source('sap_adw', 'personcreditcard') }}
)

select * from source
