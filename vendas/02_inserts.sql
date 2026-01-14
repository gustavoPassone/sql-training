USE db_vendas;

INSERT INTO tb_client (nome, email) VALUES
('João Silva', 'joao.silva@email.com'),
('Maria Oliveira', 'maria.oliveira@email.com'),
('Carlos Souza', 'carlos.souza@email.com'),
('Ana Pereira', 'ana.pereira@email.com'),
('Lucas Mendes', 'lucas.mendes@email.com');

INSERT INTO tb_produtos (nome_produto, preco_produto, estoque) VALUES
('Mouse Gamer', 150.00, 50),
('Teclado Mecânico', 450.00, 30),
('Monitor 24"', 1200.00, 20),
('Headset', 300.00, 40),
('Notebook', 4500.00, 10);

INSERT INTO tb_pedidos (client_id, data_pedido, status_pedido) VALUES
(1, '2025-01-05 10:30:00', 'CONCLUIDO'),
(2, '2025-01-06 14:20:00', 'CONCLUIDO'),
(1, '2025-01-10 09:15:00', 'CONCLUIDO'),
(3, '2025-01-12 16:40:00', 'CANCELADO'),
(4, '2025-01-15 11:00:00', 'CONCLUIDO'),
(5, '2025-01-18 19:25:00', 'PENDENTE');

INSERT INTO tb_itens_pedidos (pedido_id, produto_id, quantidade, preco_unitario) VALUES
-- pedido 1
(1, 1, 2, 150.00),
(1, 4, 1, 300.00),

-- pedido 2
(2, 2, 1, 450.00),
(2, 1, 1, 150.00),

-- pedido 3
(3, 3, 1, 1200.00),
(3, 4, 2, 300.00),

-- pedido 4 (cancelado)
(4, 1, 1, 150.00),
(4, 2, 1, 450.00),

-- pedido 5
(5, 5, 1, 4500.00),

-- pedido 6 (pendente)
(6, 2, 1, 450.00),
(6, 4, 1, 300.00);

-- -------------------------------