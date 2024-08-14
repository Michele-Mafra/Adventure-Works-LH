with
    source as (
        select
            businessentityid as salesperson_id
            , salesquota
            , bonus
            , commissionpct
            , salesytd
            , saleslastyear
        from {{ source('sap_adw', 'salesperson') }}
    )
select *
from source