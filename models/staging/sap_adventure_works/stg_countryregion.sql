with 
    source_ContryRegion as (
        select
            cast(countryregioncode as STRING) as CODE_ContryRegion					
            ,cast(name as STRING) as Country_Name		
        from {{ source('erp', 'countryregion') }}
    )

select * 
from source_ContryRegion