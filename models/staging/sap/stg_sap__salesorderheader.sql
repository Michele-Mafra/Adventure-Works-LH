WITH source AS (
    SELECT
        salesorderid,
        customerid,
        creditcardid,
        salespersonid,
        shiptoaddressid,
        PARSE_DATE('%Y-%m-%d', SUBSTR(orderdate, 1, 10)) AS order_date,
        PARSE_DATE('%Y-%m-%d', SUBSTR(duedate, 1, 10)) AS due_date,
        PARSE_DATE('%Y-%m-%d', SUBSTR(shipdate, 1, 10)) AS ship_date,
        CASE  
            WHEN status = 1 THEN 'In process'
            WHEN status = 2 THEN 'Approved'
            WHEN status = 3 THEN 'Backordered'
            WHEN status = 4 THEN 'Rejected'
            WHEN status = 5 THEN 'Shipped'
            WHEN status = 6 THEN 'Cancelled'
            ELSE NULL
        END AS order_status,
        onlineorderflag AS ordered_online,
        subtotal,
        taxamt AS tax,
        freight,
        totaldue AS total
    FROM {{ source('sap_adw', 'salesorderheader') }}
)

SELECT *
FROM source

