CREATE DATABASE db_vendas;

USE db_vendas;

CREATE TABLE tb_client(
	id_client INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_produtos(
	id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco_produto DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE tb_pedidos(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_pedido VARCHAR(30) DEFAULT 'Pendente',
    FOREIGN KEY (client_id) REFERENCES tb_client(id_client)
);

CREATE TABLE tb_itens_pedidos(
	id_itens INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (produto_id) REFERENCES tb_produtos(id_produto)
);