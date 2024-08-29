with
    source as (
        select
            cast(businessentityid as int) as salesperson_id
            , cast(salesquota as int) as salesquota
            , cast(bonus as int) as bonus
            , cast(commissionpct as numeric) as commissionpct
            , cast(salesytd as numeric) as salesytd
            , cast(saleslastyear as numeric) as saleslastyear
        from {{ source('sap_adw', 'salesperson') }}
    )
select *
from source
