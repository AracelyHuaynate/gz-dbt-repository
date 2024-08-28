{% snapshot products_snapshot %}

-- Configuración del snapshot
config(
    target_schema='dbt_snapshots',  -- Esquema donde se almacenarán los snapshots
    unique_key='products_id',       -- Clave única para identificar registros
    strategy='check',               -- Estrategia de snapshot (puede ser 'check' o 'timestamp')
    check_cols='all'                -- Columnas a rastrear; 'all' significa todas las columnas
)

-- Consulta para seleccionar datos del snapshot
select * from {{ ref("stg_raw__product") }}

{% endsnapshot %}

