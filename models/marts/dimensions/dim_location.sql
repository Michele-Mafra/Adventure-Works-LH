with address as (
    select
        address_id,
        stateprovince_id,
        city
    from {{ ref('stg_adw__address') }}
),

businessentityaddress as (
    select
        businessentity_id,
        address_id
    from {{ ref('stg_adw__businessentityaddress') }}
),

countryregion as (
    select
        country_code,
        country_name
    from {{ ref('stg_adw__countryregion') }}
),

stateprovince as (
    select
        stateprovince_id,
        country_code,
        state_code,
        state_name
    from {{ ref('stg_adw__stateprovince') }}
)

select
    a.address_id,
    bea.businessentity_id,
    sp.country_code,
    a.stateprovince_id,
    sp.state_code,
    sp.state_name,
    a.city,
    cr.country_name
from address a
join businessentityaddress bea on a.address_id = bea.address_id
join stateprovince sp on a.stateprovince_id = sp.stateprovince_id
join countryregion cr on sp.country_code = cr.country_code