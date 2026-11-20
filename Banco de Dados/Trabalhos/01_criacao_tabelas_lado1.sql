-- ============================================================
-- EXERCÍCIO 9 - Criação de tabelas (somente lado 1 da cardinalidade)
-- ============================================================

-- ------------------- EXEMPLO DE SALA ----------------------
DROP DATABASE IF EXISTS curso_mysql_senac_2_semestre_2026;
CREATE DATABASE curso_mysql_senac_2_semestre_2026;
USE curso_mysql_senac_2_semestre_2026;
show databases;

# Apagar a Tabela fisicamente
DROP TABLE IF EXISTS funcionarios;
/*
    Bloco de Comentários
*/
# Criação de Tabela - Primeiro lado 1 da cardinalidade
# Só tenho chaves primárias
CREATE TABLE funcionarios
(
  id_func int not null PRIMARY KEY,
  nome varchar(200) not null,
  salario double not null default '0',
  departamento varchar(100) not null,
  data_de_admissao datetime not null
);

# Mostrar todas as linhas de uma tabela
SELECT * FROM funcionarios;
SELECT id_func, nome FROM funcionarios;

-- ------------------- EXERCÍCIO ----------------------------
/*
   Exercício
   Criar somente as tabelas do lado 1 da cardinalidade
   do modelo de vocês!!!
   Somente as tabelas que só tem chave primária

   Modelo usado: LOJA
     categorias (1) ---< (N) produtos
     clientes   (1) ---< (N) pedidos
   Aqui criamos apenas categorias e clientes (lado 1).
   As tabelas do lado N (produtos e pedidos) estão no arquivo 10.
*/
DROP DATABASE IF EXISTS loja_senac;
CREATE DATABASE loja_senac;
USE loja_senac;

DROP TABLE IF EXISTS categorias;
CREATE TABLE categorias
(
  id_categoria int not null PRIMARY KEY,
  nome_categoria varchar(100) not null,
  descricao varchar(300)
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes
(
  id_cliente int not null PRIMARY KEY,
  nome varchar(200) not null,
  email varchar(150) not null,
  cidade varchar(100) not null
);

SHOW TABLES;
SELECT * FROM categorias;
SELECT * FROM clientes;
DESCRIBE categorias;
DESCRIBE clientes;
