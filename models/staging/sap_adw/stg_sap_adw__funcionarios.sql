with 

    funcionarios as (

        select
            cast(businessentityid as int) as id_empresarial
            , cast(nationalidnumber as int) as numero_identificacao_nacional
            , cast(loginid as string) as id_login
            , cast(jobtitle as string) as cargo
            , cast(birthdate as date) as data_de_contratacao
            --, maritalstatus
            , cast(gender as string) as genero
            , cast(hiredate as date) as contratado 
            --, salariedflag
            --, vacationhours
            --, sickleavehours
            --, currentflag
            , cast(rowguid as string) as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
            --, organizationnode
        
        from {{ source('sap_adw', 'employee') }}

    )


select * from funcionarios
