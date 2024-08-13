with source as (
    select
    businessentityid 
    from {{ source('sap_adw', 'businessentity') }}
)

select * 
from source