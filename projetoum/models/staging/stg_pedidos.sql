with source as (
    select
        *
    from {{ source('ecommerce', 'pedidos') }}
)

select * from source