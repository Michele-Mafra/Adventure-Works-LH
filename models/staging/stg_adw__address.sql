with source as (
    select
        addressid as address_id,
        stateprovinceid as stateprovince_id,
        city
    from {{ source('sap_adw', 'address') }}
)

select * from source