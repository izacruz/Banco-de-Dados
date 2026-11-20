-- ============================================================
-- EXERCÍCIO 11 - INNER JOIN, RIGHT JOIN, LEFT JOIN,
--                SELECT COUNT(*), ORDER BY e GROUP BY
-- ============================================================

-- ==================== EXEMPLO DE SALA (escola) ==============
DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola;
USE escola;

DROP TABLE IF EXISTS professores;
DROP TABLE IF EXISTS enderecos;
CREATE TABLE enderecos
(
  cod_endereco int not null PRIMARY KEY,
  logradouro varchar(400) not null,
  numero int,
  complemento varchar(400),
  bairro varchar(400) not null,
  cidade varchar(400) not null,
  estado enum ('SP', 'RJ', 'MG', 'AL', 'PE', 'DF')
);
CREATE TABLE professores
(
  id_professor int PRIMARY KEY,
  nome varchar(200) not null,
  data_de_nascimento datetime,
  cod_endereco int null,
  FOREIGN KEY (cod_endereco) REFERENCES enderecos(cod_endereco)
);

INSERT INTO enderecos
(cod_endereco, logradouro, numero, complemento, bairro, cidade, estado)
VALUES
(1, 'Rua X', 36, 'ALA A', 'Socorro', 'SP', 'SP'),
(2, 'Rua Y', 23, 'Bloco 1', 'Socorro', 'SP', 'SP'),
(3, 'Rua C', 53, 'Bloco 2', 'Lapa', 'SP', 'SP'),
(4, 'Rua D', 64, 'Bloco 4', 'Morumbi', 'SP', 'SP'),
(5, 'Rua E', 55, '25 and', 'Paraiso', 'RJ', 'RJ'),
(6, 'Rua F', 49, null, 'Copacabana', 'RJ', 'RJ'),
(7, 'Rua G', 33, null, 'Leblon', 'RJ', 'RJ'),
(8, 'Rua H', 77, null, 'Pajuçara', 'AL', 'AL'),
(9, 'Rua I', 88, null, 'Ponta Verde', 'AL', 'AL'),
(10, 'Rua J', 897, null, 'Centro', 'MG', 'MG');

INSERT INTO professores
(id_professor, nome, data_de_nascimento, cod_endereco)
VALUES
(1, 'Alberto Silva', '2024-05-06 19:47:35', 1),
(2, 'Joao Abreu', '2000-05-08 19:47:35', 1),
(3, 'Cristina Santos', '1999-05-06 19:47:35', 2),
(4, 'Zagalo Oliveira', '1980-05-06 19:47:35', 2),
(5, 'Jose Luiz', '1900-05-06 19:47:35', null),
(6, 'Fernando Zaskowiski', '2001-05-06 19:47:35', null),
(7, 'Fernanda Zaskowiski', '2022-05-06 19:47:35', null),
(8, 'Zenaide Zenoide', '2024-05-06 19:47:35', null);

SELECT * FROM enderecos;
SELECT * FROM professores;
SELECT * FROM professores p INNER JOIN enderecos e ON p.cod_endereco = e.cod_endereco;
SELECT * FROM professores p RIGHT JOIN enderecos e ON p.cod_endereco = e.cod_endereco;
SELECT * FROM professores p LEFT JOIN enderecos e ON p.cod_endereco = e.cod_endereco;

SELECT COUNT(*) FROM enderecos;
SELECT * FROM enderecos ORDER BY cod_endereco;
SELECT * FROM enderecos ORDER BY cod_endereco DESC;
SELECT * FROM enderecos ORDER BY bairro;
SELECT estado, COUNT(*) FROM enderecos GROUP BY estado;

-- ==================== EXERCÍCIO (petshop) ===================
/*
- Criar um Database;
- Criar 2 tabelas;
- Inserir pelo menos 10 registros em cada uma das tabelas;
- Utilizar: INNER JOIN, RIGHT JOIN, LEFT JOIN, SELECT COUNT(*), ORDER BY e GROUP BY.
*/
DROP DATABASE IF EXISTS petshop;
CREATE DATABASE petshop;
USE petshop;

-- Lado 1
CREATE TABLE tutores
(
  id_tutor int not null PRIMARY KEY,
  nome varchar(200) not null,
  cidade varchar(100) not null
);
-- Lado N (id_tutor pode ser nulo: pet ainda sem tutor cadastrado)
CREATE TABLE pets
(
  id_pet int not null PRIMARY KEY,
  nome_pet varchar(100) not null,
  especie varchar(50) not null,
  idade int not null,
  id_tutor int null,
  FOREIGN KEY (id_tutor) REFERENCES tutores(id_tutor)
);

INSERT INTO tutores (id_tutor, nome, cidade) VALUES
(1,  'Marcos Oliveira',  'Sao Paulo'),
(2,  'Patricia Gomes',   'Sao Paulo'),
(3,  'Renato Barbosa',   'Santos'),
(4,  'Sandra Vieira',    'Campinas'),
(5,  'Tiago Ramos',      'Santos'),
(6,  'Ursula Ferraz',    'Sao Paulo'),
(7,  'Vitor Nascimento', 'Guarulhos'),
(8,  'Wanda Torres',     'Osasco'),
(9,  'Xavier Duarte',    'Campinas'),
(10, 'Yara Medeiros',    'Santos');

INSERT INTO pets (id_pet, nome_pet, especie, idade, id_tutor) VALUES
(1,  'Rex',    'Cachorro', 5, 1),
(2,  'Mia',    'Gato',     3, 1),
(3,  'Thor',   'Cachorro', 7, 2),
(4,  'Luna',   'Gato',     2, 3),
(5,  'Bob',    'Cachorro', 4, 4),
(6,  'Nina',   'Coelho',   1, 5),
(7,  'Mel',    'Cachorro', 9, 6),
(8,  'Fred',   'Passaro',  2, 7),
(9,  'Pipoca', 'Gato',     6, NULL),
(10, 'Toby',   'Cachorro', 3, NULL);

SELECT * FROM tutores;
SELECT * FROM pets;

-- INNER JOIN: somente pets que têm tutor
SELECT p.nome_pet, p.especie, t.nome AS tutor
  FROM pets p INNER JOIN tutores t ON p.id_tutor = t.id_tutor;

-- LEFT JOIN: todos os pets (inclusive os sem tutor)
SELECT p.nome_pet, p.especie, t.nome AS tutor
  FROM pets p LEFT JOIN tutores t ON p.id_tutor = t.id_tutor;

-- RIGHT JOIN: todos os tutores (inclusive os sem pets)
SELECT t.nome AS tutor, p.nome_pet
  FROM pets p RIGHT JOIN tutores t ON p.id_tutor = t.id_tutor;

-- SELECT COUNT(*)
SELECT COUNT(*) AS total_pets FROM pets;
SELECT COUNT(*) AS total_tutores FROM tutores;

-- ORDER BY
SELECT * FROM pets ORDER BY nome_pet;
SELECT * FROM pets ORDER BY idade DESC;
SELECT * FROM tutores ORDER BY cidade, nome;

-- GROUP BY
SELECT especie, COUNT(*) AS qtd FROM pets GROUP BY especie;
SELECT cidade, COUNT(*) AS qtd_tutores FROM tutores GROUP BY cidade ORDER BY qtd_tutores DESC;
SELECT t.nome, COUNT(p.id_pet) AS qtd_pets
  FROM tutores t LEFT JOIN pets p ON t.id_tutor = p.id_tutor
 GROUP BY t.nome ORDER BY qtd_pets DESC;
