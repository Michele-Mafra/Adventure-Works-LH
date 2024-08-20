with
    source as (
        select
        cast(businessentityid as int) as businessentityid
        from {{ source('sap_adw', 'businessentity') }}
    )

select * 
from source
