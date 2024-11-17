with
    source as (
        select
        cast(addressid as int) as addressid
        , cast(stateprovinceid as int) as stateprovinceid
        , city
        from {{ source('sap_adw', 'address') }}
    )

select *
from source
