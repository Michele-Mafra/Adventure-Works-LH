with
    source as (
        select
            cast(salesreasonid as int) as salesreasonid 
            , name as reason
            , reasontype as reason_type
        from {{ source('sap_adw', 'salesreason') }}
    )

select *
from source
