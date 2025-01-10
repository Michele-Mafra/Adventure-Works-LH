with 

    pessoas as (

        select 
            cast(businessentityid as int) as id_pessoa
            , case persontype
                when 'SC' then 'Contato Loja'
                when 'IN' then 'Varejo'
                when 'SP' then 'Vendedor'
                when 'EM' then 'Funcionário'
                when 'VC' then 'Contato Fornecedor'
                when 'GC' then 'Contato Geral'
                else null
            end as tipo_pessoa
            , cast(namestyle as boolean) as estilo_de_nome
            , concat(
                coalesce(title,''),' '
                , coalesce(firstname,''),' '
                , coalesce(middlename,''),' '
                , coalesce(lastname,''),' '
                , coalesce(suffix,'')) as nome_pessoa
            , case emailpromotion
                when 0 then 'Não Contatar'
                when 1 then 'Contatar por Adw'
                when 2 then 'Contatar por Adw + Parceiros'
                else null
            end as email_promocional     
            , case 
                when additionalcontactinfo = '[null]' then null 
                else additionalcontactinfo 
            end as contato_adicional
            , cast(demographics as string) as dados_demograficos
            , cast(rowguid as string) as linha_guia
            , cast(
                format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao        

        from {{ source('sap_adw', 'person') }}

    )


select* 
from pessoas
