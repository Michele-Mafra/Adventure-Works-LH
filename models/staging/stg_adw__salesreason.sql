with source as (
    select
        salesreasonid as reason_id
        , name as reason
        , reasontype as reason_type
    from {{ source('sap_adw', 'salesreason') }}
)

select *
from source
