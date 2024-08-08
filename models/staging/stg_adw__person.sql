with source as (
    select
        businessentityid as businessentity_id
        , firstname as first_name
        , lastname as last_name
        , concat(firstname, ' ', lastname) as name
    from {{ source('sap_adw', 'person') }}
)

select *
from source
