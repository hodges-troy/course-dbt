{% snapshot products_snapshot %}

  {{
    config(
        target_database=target.database,
        target_schema=target.schema,
        strategy='check',
        unique_key='PRODUCT_ID',
        check_cols=['INVENTORY']
    )
  }}

  SELECT * FROM {{ source('postgres', 'products') }}

{% endsnapshot %}