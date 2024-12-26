with 

    fonte_departamento as (

        select 
            cast(departmentid as int) as id_departamento
            , name as nome
            , groupname as nome_grupo
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
 
               
        from {{ source('sap_adw', 'department') }}

    )


select * 
from fonte_departamento
