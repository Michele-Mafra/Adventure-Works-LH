with 
    stg_produtos as (
        select * 
        from {{ ref('stg_sap_adw__produtos') }}
    )
    , categoria as (
        select * 
        from {{ ref('stg_sap_adw__produtos_categoria') }}
    )
    , subcategoria as (
        select * 
        from {{ ref('stg_sap_adw__produtos_subcategorias') }}
    )
    , modelo as (
        select * 
        from {{ ref('stg_sap_adw__produtos_modelo') }}
    )
    , unidade_medida_produtos as (
        select *
        from {{ ref('stg_sap_adw__unidades_medidas') }}
    )
    
    , join_tables as (
        select
            stg_produtos.id_produto
            , stg_produtos.id_subcategoria_produto
            , stg_produtos.id_modelo_produto
            --, subcategoria.id_subcategoria_produto  
            , subcategoria.id_categoria_produto
            , categoria.id_produto_categoria
            , modelo.id_produto_modelo
            , stg_produtos.nome_produto
            , modelo.nome_modelo_produto
            , stg_produtos.cor
            , stg_produtos.numero_produto
            , stg_produtos.producao_propria
            , stg_produtos.item_vendavel             
            , stg_produtos.quantidade_minima_estoque
            , stg_produtos.quantidade_minima_reabastecimento
            , stg_produtos.valor_custo_produto
            , stg_produtos.valor_tabela_produto
            , stg_produtos.nr_tamanho
            , stg_produtos.codigo_unidade_medida_tamanho
            , stg_produtos.codigo_unidade_medida_peso
            , stg_produtos.numero_peso 
            , stg_produtos.quantidade_dias_para_fabricacao
            , stg_produtos.linha_produto
            , stg_produtos.classificacao_produto
            , stg_produtos.estilo_produto            
            , stg_produtos.data_inicio_venda
            , stg_produtos.data_fim_venda
            , stg_produtos.descontinuado                        
            , subcategoria.nome_subcategoria_produto            
            , modelo.descricao_catalago
            --, unidade_medida_produtos.unidade_de_medidas
      
        from stg_produtos
        left join subcategoria on subcategoria.id_subcategoria_produto = stg_produtos.id_subcategoria_produto
        left join categoria on categoria.id_produto_categoria = subcategoria.id_categoria_produto
        left join modelo on modelo.id_produto_modelo = stg_produtos.id_produto
        --left join unidade_medida_produtos on unidade_medida_produtos.codigo_unidade_medida = stg_produtos.codigo_unidade_medida_tamanho
       -- left join stg_unidade_medida_produtos as um_peso on um_peso.codigo_unidade_medida = stg_produtos.codigo_unidade_medida_peso

    )

    , join_tables_final as (

        select 
            {{ dbt_utils.generate_surrogate_key(['id_produto']) }} as sk_produto
            ,join_tables.*      
        from join_tables
        
    )

select*
from join_tables_final
            



    