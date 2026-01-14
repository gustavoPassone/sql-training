USE db_vendas;

-- querys basicas
SELECT * FROM tb_client;
SELECT * FROM tb_produtos;
SELECT * FROM tb_pedidos;
SELECT * FROM tb_itens_pedidos;

-- -----------------------------

-- views
SELECT * FROM vw_total_por_pedido;
SELECT * FROM vw_total_gasto_por_cliente;
SELECT * FROM vw_total_gasto_por_cliente_concluidos;

-- -----------------------------

-- querys intermediarias

-- Total por pedido
CREATE VIEW vw_total_por_pedido AS
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    p.status_pedido,
    SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM tb_pedidos p
JOIN tb_client c ON c.id_client = p.client_id
JOIN tb_itens_pedidos i ON i.pedido_id = p.id_pedido
GROUP BY p.id_pedido, c.nome, p.status_pedido;


-- Total gasto por cliente
CREATE VIEW vw_total_gasto_por_cliente AS
SELECT
	p.client_id,
    c.nome as cliente,
    SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM tb_client c
JOIN tb_pedidos p ON p.client_id = c.id_client
JOIN tb_itens_pedidos i ON i.pedido_id = p.id_pedido
WHERE p.status_pedido = 'CONCLUIDO'
GROUP BY c.id_client, c.nome;

-- Total gasto por cliente somente com pedidos CONCLUIDOS
CREATE VIEW vw_total_gasto_por_cliente_concluidos AS
SELECT
    c.nome AS cliente,
    SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM tb_client c
JOIN tb_pedidos p ON p.client_id = c.id_client
JOIN tb_itens_pedidos i ON i.pedido_id = p.id_pedido
WHERE p.status_pedido = 'CONCLUIDO'
GROUP BY c.nome;