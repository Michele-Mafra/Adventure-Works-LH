with source as (
    select
    businessentityid
    , territoryid
    , salesquota
    , bonus
    , commissionpct
    , salesytd
    , saleslastyear
    from {{ source('sap_adw', 'salesperson') }}
)

select *
from source
