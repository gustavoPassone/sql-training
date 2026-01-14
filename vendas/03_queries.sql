USE db_vendas;

-- querys basicas
SELECT * FROM tb_client;
SELECT * FROM tb_produtos;
SELECT * FROM tb_pedidos;
SELECT * FROM tb_itens_pedidos;

CREATE VIEW vw_client_pedido_data AS
SELECT
	c.nome,
    p.id_pedido,
    p.data_pedido
FROM tb_pedidos p
JOIN tb_client c ON c.id_client = p.client_id;

-- -----------------------------

-- views
SELECT * FROM vw_client_pedido_data;
SELECT * FROM vw_total_por_pedido;
SELECT * FROM vw_total_gasto_por_cliente;
SELECT * FROM vw_total_gasto_por_cliente_concluidos;

SELECT * 
FROM vw_cliente_que_mais_gastou
ORDER BY total_gasto DESC
LIMIT 1;

SELECT * FROM vw_total_por_pedido_e_cliente;

SELECT * 
FROM vw_produto_mais_vendido
ORDER BY total_vendido DESC
LIMIT 1;

SELECT * 
FROM vw_faturamento_por_produto
ORDER BY total_vendido DESC
LIMIT 1;

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

-- -----------------------------

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

-- -----------------------------

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

-- -----------------------------

-- Cliente que mais gastou
CREATE OR REPLACE VIEW vw_cliente_que_mais_gastou AS
SELECT
	c.id_client,
	c.nome as cliente,
    SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM tb_client c
JOIN tb_pedidos p ON p.client_id = c.id_client
JOIN tb_itens_pedidos i ON i.pedido_id = p.id_pedido
WHERE p.status_pedido = 'CONCLUIDO'
GROUP BY c.id_client, c.nome;
-- melhorias
-- Se dois clientes gastarem o mesmo valor, o LIMIT 1 traz só um.

-- -----------------------------

-- Pedido com nome do cliente e valor total
CREATE VIEW vw_total_por_pedido_e_cliente AS
SELECT
	p.id_pedido,
	c.nome AS cliente,
    SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM tb_pedidos p
JOIN tb_client c ON c.id_client = p.client_id
JOIN tb_itens_pedidos i ON i.pedido_id = p.id_pedido
GROUP BY p.id_pedido, c.nome
ORDER BY p.id_pedido ASC;

-- -----------------------------

-- Produto mais vendido
CREATE OR REPLACE VIEW vw_produto_mais_vendido AS
SELECT
	p.id_produto,
    p.nome_produto,
    SUM(i.quantidade) AS total_vendido
FROM tb_produtos p
JOIN tb_itens_pedidos i ON i.produto_id = p.id_produto
GROUP BY p.id_produto, p.nome_produto;

-- -----------------------------

-- Produto que mais faturou
CREATE VIEW vw_faturamento_por_produto AS
SELECT
	p.id_produto,
    p.nome_produto,
    SUM(i.quantidade * i.preco_unitario) AS total_vendido
FROM tb_produtos p
JOIN tb_itens_pedidos i ON i.produto_id = p.id_produto
GROUP BY p.id_produto, p.nome_produto;