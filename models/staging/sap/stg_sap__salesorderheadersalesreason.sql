with source as (
    select
        salesorderid 
        , salesreasonid 
    from {{ source('sap_adw', 'salesorderheadersalesreason') }}
)

select *
from source
