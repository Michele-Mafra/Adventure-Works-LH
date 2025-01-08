with 

    pedidos_venda as (

        select 
            cast(salesorderid as int) as id_pedido_venda
            , cast(salesorderdetailid as int) as id_pedido_venda_item
            , trim(carriertrackingnumber) as numero_rastreamento
            , coalesce(cast(orderqty as int),0) as qt_pedido_item
            , cast(productid as int) as id_produto
            , cast(specialofferid as int) as id_promocao
            , coalesce(cast(unitprice as bignumeric),0) as valor_unitario_item
            , coalesce(cast(unitpricediscount as bignumeric),0) as desconto_item
            , rowguid as linha_guia
            , cast(format_timestamp('%Y-%m-%d %H:%M:%S', cast(modifieddate as timestamp)) as timestamp) as data_modificacao  
        from {{ source('sap_adw', 'salesorderdetail') }}

    )

select *
from pedidos_venda

