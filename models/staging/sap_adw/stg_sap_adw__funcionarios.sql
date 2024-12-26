with 

    fonte_funcionarios as (

        select
            cast(businessentityid as int) as id_empresarial
            , cast(nationalidnumber as int) as numero_identificacao_nacional
            , loginid as id_login
            , jobtitle as cargo
            , cast(birthdate as date) as data_de_contratacao
            --, maritalstatus
            , gender as genero
            , cast(hiredate as date) as contratado 
            --, salariedflag
            --, vacationhours
            , sickleavehours
            --, currentflag
            , rowguid
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
            --, organizationnode
        
        from {{ source('sap_adw', 'employee') }}

    )


select * from fonte_funcionarios
