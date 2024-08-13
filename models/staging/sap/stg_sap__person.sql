with source as (
    select
        businessentityid 
        , concat(firstname, ' ', lastname) as name
        , firstname as first_name
        , lastname as last_name
        , case
            when persontype = 'SC' then 'Store' 
            when persontype = 'IN' then 'Retail Customer'
            when persontype = 'SP' then 'Sales Person'
            when persontype = 'EM' then 'Employee (non-sales)'
            when persontype = 'VC' then 'Vendor'
            when persontype = 'GC' then 'General Contact'
            else null
        end as person_type
    from {{ source('sap_adw', 'person') }}
)

select *
from source

