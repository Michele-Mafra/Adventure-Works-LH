with 
    max_dt_carga as (
        select max(data_carga) as ultima_dt_carga
        from {{ this }}
    )

select *
from refined
{% if is_incremental %}
    where data_modificacao >= (select ultima_dt_carga from max_dt_carga)
{% endif %}
