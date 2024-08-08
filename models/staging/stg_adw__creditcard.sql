with source as (
    select
        creditcardid as creditcard_id
        , cardtype as card_type
        , cardnumber as card_number
        from {{ source('sap_adw', 'creditcard') }}
)

select * 
from source
