with source as (
    select
        creditcardid 
        , cardtype as card_type
        from {{ source('sap_adw', 'creditcard') }}
)

select * 
from source
