with
    salesorderheader as (
        select 
            distinct(shiptoaddressid)
        from {{ref('stg_sap__salesorderheader')}}
    )

    , address as (
        select *
        from {{ref('stg_sap__address')}}
    )

    , stateprovince as (
        select *
        from {{ref('stg_sap__stateprovince')}}
    )

    , countryregion as (
        select *
        from {{ref('stg_sap__countryregion')}}
    )

    , transformed as (
        select
            {{ surrogate_key('salesorderheader.shiptoaddressid') }} as sk_shiptoaddress
            , salesorderheader.shiptoaddressid 
            , address.city as city_name
            , stateprovince.state_name
            , countryregion.country_name
        from salesorderheader
        left join address on salesorderheader.shiptoaddressid = address.addressid
        left join stateprovince on address.stateprovinceid = stateprovince.stateprovinceid
        left join countryregion on stateprovince.country_code = countryregion.countryregioncode 
    )

select *
from transformed
