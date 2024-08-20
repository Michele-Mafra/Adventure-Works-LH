with
    source as (
        select
        cast(businessentityid as int) as businessentityid
        , cast(addressid as int) as addressid
        , case 
            when addresstypeid = 1 then 'Billing'
            when addresstypeid = 2 then 'Home'
            when addresstypeid = 3 then 'Main Office'
            when addresstypeid = 4 then 'Primary'
            when addresstypeid = 5 then 'Shipping'
            when addresstypeid = 6 then 'Archive'
            end as address_type
        from {{ source('sap_adw', 'businessentityaddress') }}
    )

select * 
from source
