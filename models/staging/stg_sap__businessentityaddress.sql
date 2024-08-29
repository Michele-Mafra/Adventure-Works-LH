with
    source as (
        select
            cast(addressid as int) as addressid           
            , cast(businessentityid as int) as businessentityid
        from {{ source('sap_adw', 'businessentityaddress') }}
    )
select *
from source
