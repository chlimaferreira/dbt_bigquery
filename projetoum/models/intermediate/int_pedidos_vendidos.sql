{{
    config(
        tags='vendas'
    )
}}

with pedidos as (
    select 
        * 
    from {{ ref('stg_pedidos') }}
),
clientes as (
    select 
        * 
    from {{ ref('stg_clientes') }}
),
itens_pedidos as (
    select 
        * 
    from {{ ref('stg_itens_pedidos') }}
),
produtos as (
    select 
        * 
    from {{ ref('stg_produtos') }}
),
categorias as (
    select 
        * 
    from {{ ref('stg_categorias') }}
),
pagamentos as (
    select 
        * 
    from {{ ref('stg_pagamentos') }}
)
,
joined as (
    select 
        pedidos.id as pedido_id,
        clientes.nome as cliente_nome,
        clientes.email as cliente_email,
        pagamentos.valor as valor_pagamento,
        pagamentos.metodo as metodo_pagamento,
        pagamentos.status as status_pagamento,
        pagamentos.data_pagamento,
        produtos.id as produto_id,
        produtos.nome as produto_name,
        categorias.nome as categoria_name,
        itens_pedidos.quantidade,
        itens_pedidos.preco_unitario
    from pedidos
    left join clientes
        on pedidos.cliente_id = clientes.id
    left join itens_pedidos
        on pedidos.id = itens_pedidos.pedido_id
    left join produtos
        on itens_pedidos.produto_id = produtos.id
    left join categorias
        on produtos.categoria_id = categorias.id
    left join pagamentos
        on pedidos.id = pagamentos.pedido_id
)

select * from joined

