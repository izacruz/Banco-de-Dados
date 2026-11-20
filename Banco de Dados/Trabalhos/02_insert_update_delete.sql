-- ============================================================
-- EXERCÍCIO 10 - INSERT, UPDATE e DELETE respeitando a cardinalidade
-- Regras:
--   INSERT: primeiro o lado 1, depois o lado N
--   DELETE: primeiro o lado N, depois o lado 1
-- ============================================================

-- ==================== EXEMPLO DE SALA =======================
DROP DATABASE IF EXISTS curso_mysql_senac_2_semestre_2026;
CREATE DATABASE curso_mysql_senac_2_semestre_2026;
USE curso_mysql_senac_2_semestre_2026;

DROP TABLE IF EXISTS veiculos;
DROP TABLE IF EXISTS funcionarios;
CREATE TABLE funcionarios
(
  id_func int not null PRIMARY KEY,
  nome varchar(200) not null,
  salario double not null default '0',
  departamento varchar(100) not null,
  data_de_admissao datetime not null
);
# Lado N: um funcionário pode ter vários veículos
# (a tabela veiculos não estava no material, foi criada a partir do INSERT)
CREATE TABLE veiculos
(
  id_veiculos int not null PRIMARY KEY,
  id_func int not null,
  veiculo varchar(100) not null,
  placa varchar(10) not null,
  FOREIGN KEY (id_func) REFERENCES funcionarios(id_func)
);

# Primeiro lado 1 da minha cardinalidade
INSERT INTO funcionarios
(id_func, nome, salario, departamento, data_de_admissao)
VALUES
(1, 'Rogerio da Silva', '1000.85', 'TI', '2024-05-25 19:47:35');
INSERT INTO funcionarios
(id_func, nome, salario, departamento, data_de_admissao)
VALUES
(2, 'Fernando Albuquerque', '101000.25', 'Contabilidade', '2024-05-06 20:30:35');
SELECT * FROM funcionarios;

# Depois lado n da minha cardinalidade
INSERT INTO veiculos
(id_veiculos, id_func, veiculo, placa)
VALUES
(1, 1, 'VW Fusca', 'XPT0120'),
(2, 1, 'VW Tiguan', 'ABC1234'),
(3, 2, 'Jaguar', 'XXX5678');
SELECT * FROM veiculos;
SELECT * FROM veiculos WHERE id_func = 1;
SELECT * FROM veiculos WHERE id_func = 2;
SELECT * FROM veiculos WHERE id_func IN (1, 2);
SELECT * FROM veiculos WHERE id_veiculos = 1 AND id_func = 1;
SELECT * FROM veiculos WHERE id_veiculos = 1 OR id_func = 1;

SELECT * FROM funcionarios;
UPDATE funcionarios SET salario = '234000.99' WHERE id_func = 1;
UPDATE funcionarios SET nome = 'Joao da Silva' WHERE id_func = 2;
SELECT * FROM funcionarios;

SELECT * FROM veiculos;
UPDATE veiculos SET veiculo = 'Ferrari' WHERE id_veiculos = 1;
SELECT * FROM veiculos;

/*
Regra para o comando DELETE
Primeiro deletar o lado N depois deletar o lado 1
*/
SELECT * FROM veiculos;
DELETE FROM veiculos WHERE id_func = 1;
SELECT * FROM funcionarios;
DELETE FROM funcionarios WHERE id_func = 1;
SELECT * FROM funcionarios;
SELECT * FROM veiculos;

-- ==================== EXERCÍCIO (modelo LOJA) ===============
/*
Exercício 1: inserir 10 registros para cada tabela do modelo.
  Primeiro TODAS AS TABELAS do lado 1, DEPOIS as tabelas do lado N.
Exercício 2: executar 5 UPDATE em cada tabela.
Exercício 3: deletar 5 registros de cada tabela (lado N antes do lado 1).
*/
DROP DATABASE IF EXISTS loja_senac;
CREATE DATABASE loja_senac;
USE loja_senac;

-- ---- Tabelas do lado 1 ----
CREATE TABLE categorias
(
  id_categoria int not null PRIMARY KEY,
  nome_categoria varchar(100) not null,
  descricao varchar(300)
);
CREATE TABLE clientes
(
  id_cliente int not null PRIMARY KEY,
  nome varchar(200) not null,
  email varchar(150) not null,
  cidade varchar(100) not null
);

-- ---- Tabelas do lado N ----
CREATE TABLE produtos
(
  id_produto int not null PRIMARY KEY,
  nome_produto varchar(200) not null,
  preco decimal(20,2) not null default 0,
  estoque int not null default 0,
  id_categoria int not null,
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
CREATE TABLE pedidos
(
  id_pedido int not null PRIMARY KEY,
  data_pedido datetime not null,
  valor_total decimal(20,2) not null default 0,
  status_pedido varchar(30) not null,
  id_cliente int not null,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ---- INSERT: primeiro lado 1 ----
INSERT INTO categorias (id_categoria, nome_categoria, descricao) VALUES
(1,  'Informatica',  'Computadores e acessorios'),
(2,  'Celulares',    'Smartphones e acessorios'),
(3,  'Moveis',       'Moveis para casa e escritorio'),
(4,  'Games',        'Consoles e jogos'),
(5,  'Audio',        'Fones e caixas de som'),
(6,  'Eletrodomesticos', 'Itens para a casa'),
(7,  'Papelaria',    'Material escolar e de escritorio'),
(8,  'Esportes',     'Artigos esportivos'),
(9,  'Livros',       'Livros impressos'),
(10, 'Brinquedos',   'Brinquedos em geral');

INSERT INTO clientes (id_cliente, nome, email, cidade) VALUES
(1,  'Ana Souza',      'ana@email.com',      'Sao Paulo'),
(2,  'Bruno Lima',     'bruno@email.com',    'Rio de Janeiro'),
(3,  'Carla Dias',     'carla@email.com',    'Belo Horizonte'),
(4,  'Daniel Rocha',   'daniel@email.com',   'Maceio'),
(5,  'Eduarda Melo',   'eduarda@email.com',  'Santos'),
(6,  'Felipe Nunes',   'felipe@email.com',   'Sao Paulo'),
(7,  'Gabriela Pires', 'gabriela@email.com', 'Campinas'),
(8,  'Hugo Alves',     'hugo@email.com',     'Niteroi'),
(9,  'Isabela Costa',  'isabela@email.com',  'Recife'),
(10, 'Joao Mendes',    'joao@email.com',     'Brasilia');

-- ---- INSERT: depois lado N ----
INSERT INTO produtos (id_produto, nome_produto, preco, estoque, id_categoria) VALUES
(1,  'Notebook',          3500.00, 15, 1),
(2,  'Smartphone',        2800.00, 30, 2),
(3,  'Cadeira Gamer',     1250.00,  8, 3),
(4,  'Console',           4200.00,  5, 4),
(5,  'Fone Bluetooth',     149.90, 100, 5),
(6,  'Liquidificador',     189.90, 40, 6),
(7,  'Caderno 10 materias', 24.90, 300, 7),
(8,  'Bola de Futebol',     79.90, 60, 8),
(9,  'Livro de SQL',        89.90, 25, 9),
(10, 'Quebra-cabeca',       49.90, 70, 10);

INSERT INTO pedidos (id_pedido, data_pedido, valor_total, status_pedido, id_cliente) VALUES
(1,  '2026-03-03 10:00:00', 3500.00, 'Entregue',  1),
(2,  '2026-03-10 11:20:00', 2800.00, 'Enviado',   2),
(3,  '2026-04-01 09:15:00', 1250.00, 'Cancelado', 3),
(4,  '2026-04-15 14:40:00', 4200.00, 'Pago',      4),
(5,  '2026-05-02 16:05:00',  149.90, 'Entregue',  5),
(6,  '2026-05-20 08:30:00',  189.90, 'Aberto',    6),
(7,  '2026-06-04 13:00:00',   24.90, 'Entregue',  7),
(8,  '2026-06-15 15:45:00',   79.90, 'Enviado',   8),
(9,  '2026-07-01 10:10:00',   89.90, 'Pago',      9),
(10, '2026-07-10 17:25:00',   49.90, 'Aberto',   10);

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;

-- ---- 5 UPDATE em cada tabela ----
-- categorias
UPDATE categorias SET descricao = 'Notebooks, perifericos e acessorios' WHERE id_categoria = 1;
UPDATE categorias SET nome_categoria = 'Smartphones'                    WHERE id_categoria = 2;
UPDATE categorias SET descricao = 'Moveis para escritorio'              WHERE id_categoria = 3;
UPDATE categorias SET nome_categoria = 'Video Games'                    WHERE id_categoria = 4;
UPDATE categorias SET descricao = 'Fones, caixas e microfones'          WHERE id_categoria = 5;
SELECT * FROM categorias;

-- clientes
UPDATE clientes SET cidade = 'Guarulhos'                 WHERE id_cliente = 1;
UPDATE clientes SET email  = 'bruno.lima@email.com'      WHERE id_cliente = 2;
UPDATE clientes SET nome   = 'Carla Dias Pereira'        WHERE id_cliente = 3;
UPDATE clientes SET cidade = 'Arapiraca'                 WHERE id_cliente = 4;
UPDATE clientes SET email  = 'eduarda.melo@email.com'    WHERE id_cliente = 5;
SELECT * FROM clientes;

-- produtos
UPDATE produtos SET preco = 3299.90                      WHERE id_produto = 1;
UPDATE produtos SET estoque = 25                         WHERE id_produto = 2;
UPDATE produtos SET nome_produto = 'Cadeira Gamer Pro'   WHERE id_produto = 3;
UPDATE produtos SET preco = 3999.00, estoque = 3         WHERE id_produto = 4;
UPDATE produtos SET preco = 129.90                       WHERE id_produto = 5;
SELECT * FROM produtos;

-- pedidos
UPDATE pedidos SET status_pedido = 'Pago'      WHERE id_pedido = 6;
UPDATE pedidos SET status_pedido = 'Entregue'  WHERE id_pedido = 2;
UPDATE pedidos SET valor_total = 3999.00       WHERE id_pedido = 4;
UPDATE pedidos SET status_pedido = 'Entregue'  WHERE id_pedido = 8;
UPDATE pedidos SET status_pedido = 'Enviado'   WHERE id_pedido = 9;
SELECT * FROM pedidos;

-- ---- DELETE: 5 registros de cada tabela (primeiro lado N, depois lado 1) ----
-- Lado N
DELETE FROM pedidos  WHERE id_pedido  IN (1, 2, 3, 4, 5);
DELETE FROM produtos WHERE id_produto IN (1, 2, 3, 4, 5);
SELECT * FROM pedidos;
SELECT * FROM produtos;
-- Lado 1
DELETE FROM clientes   WHERE id_cliente   IN (1, 2, 3, 4, 5);
DELETE FROM categorias WHERE id_categoria IN (1, 2, 3, 4, 5);
SELECT * FROM clientes;
SELECT * FROM categorias;
