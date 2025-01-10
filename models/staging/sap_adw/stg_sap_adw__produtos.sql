with 
    produto as (
        select 
            cast(productid as int) as id_produto
            , cast(name as string) as nome_produto
            , cast(productnumber as string) as numero_produto
            , cast(makeflag as boolean) as producao_propria
            , cast(finishedgoodsflag as boolean) as item_vendavel
            , cast(color as string) as cor
            , cast(safetystocklevel as int) as quantidade_minima_estoque
            , cast(reorderpoint as int) as quantidade_minima_reabastecimento
            , coalesce(round(cast(standardcost as numeric), 2), 0) as valor_custo_produto
            , coalesce(round(cast(listprice as numeric), 2), 0) as valor_tabela_produto
            , cast(size as string) as nr_tamanho
            , cast(sizeunitmeasurecode as string) as codigo_unidade_medida_tamanho
            , cast(weightunitmeasurecode as string) as codigo_unidade_medida_peso
            , coalesce(round(cast(weight as numeric), 2), 0.0) as numero_peso
            , coalesce(cast(daystomanufacture as int), 0) as quantidade_dias_para_fabricacao
            , case upper(productline)
                when 'R' then 'Estrada'
                when 'M' then 'Montanha'
                when 'T' then 'Turismo'
                when 'S' then 'Padrão'
                else null
              end as linha_produto
            , case upper(class)
                when 'H' then 'Alto'
                when 'M' then 'Médio'
                when 'L' then 'Baixo'
                else null
              end as classificacao_produto
            , case upper(style)
                when 'M' then 'Homem'
                when 'W' then 'Mulher'
                when 'U' then 'Universal'
                else null     
              end as estilo_produto
            , cast(productsubcategoryid as int) as id_subcategoria_produto             
            , cast(productmodelid as int) as id_modelo_produto
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(sellstartdate as timestamp)) as timestamp) as data_inicio_venda        
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(sellenddate as timestamp)) as timestamp) as data_fim_venda
            , case 
                when discontinueddate is null then false
                else true
              end as descontinuado
            , cast(rowguid as string) as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao
        from {{ source('sap_adw', 'product') }}
    )

select * 
from produto
