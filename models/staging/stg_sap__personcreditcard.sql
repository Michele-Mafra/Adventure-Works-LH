with
    source as (
        select
        cast(creditcardid as int) as creditcardid
        , cast(businessentityid as int) as businessentityid
        from {{ source('sap_adw', 'personcreditcard') }}
    )

select *
from source
