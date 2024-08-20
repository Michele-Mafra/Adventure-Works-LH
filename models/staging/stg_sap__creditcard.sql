with
    source as (
        select
            cast(creditcardid as int) as creditcardid 
            , cardtype as card_type
        from {{ source('sap_adw', 'creditcard') }}
    )

select * 
from source
