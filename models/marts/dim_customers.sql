with
    customer as (
        select *
        from {{ref('stg_sap__customer')}}
    ) 

    , person as (
        select *
        from {{ref('stg_sap__person')}}
    ) 

    , store as (
        select *
        from {{ref('stg_sap__store')}}
    ) 

    , joined as (
        select
            customer.customerid
            , customer.personid
            , person.name
            , customer.storeid
            , store.store_name
        from customer
        left join person on person.businessentityid = customer.personid
        left join store on store.businessentityid = customer.storeid
    )

    , transformed as (
        select
            {{ surrogate_key('customerid') }} as sk_customer
            , customerid
            , name
            , case 
                when personid is null and storeid is not null then 'Store'
                when personid is not null and storeid is null then 'Natural Person'
                when personid is not null and storeid is not null then 'Store Contact'
                end as person_type
            , store_name
        from joined
    )

select *
from transformed
