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
        row_number() over (order by customerid) as sk_customer -- auto-incremental surrogate key    
            , *
            , case 
                when personid is null and storeid is not null then 'Store'
                when personid is not null and storeid is null then 'Natural Person'
                when personid is not null and storeid is not null then 'Store Contact'
                end as person_type
        from joined
    )

select *
from transformed