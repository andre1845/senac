CREATE DATABASE empresa;
USE empresa;
CREATE TABLE produtos (
idproduto INT NOT NULL PRIMARY KEY auto_increment,
nomeprod VARCHAR (50) UNIQUE,
valor FLOAT(8,2),
quantidade INT(8)
);
CREATE TABLE cliente (
idcliente INT NOT NULL PRIMARY KEY auto_increment,
nome_cliente VARCHAR (100),
email VARCHAR (30)
);

desc CLIENTE;

DESC PRODUTOS;

ALTER TABLE cliente ADD COLUMN tel VARCHAR(20) after nome_cliente;

INSERT INTO produtos (nomeprod, valor,quantidade) VALUES 
('Pneu', 280, 52),
('Bomba Comb', 589.21, 14),
('Vela', 25.04, 210),
('Correia dentada', 150.2, 28);

SELECT * FROM produtos;

drop table cliente;

INSERT INTO cliente (nome_cliente, tel, email) VALUES
('Mario', 34232121,' mario@gmail.com'),
('Ana Lucia', 985457878, 'ana@marc.com');

SELECT * FROM cliente;

ALTER TABLE cliente ADD UNIQUE (email);

INSERT INTO cliente (nome_cliente, tel, email) VALUES
('Lucio', 98576521,' lucioo@gmail.com');

ALTER TABLE cadastro CHANGE
 COLUMN nome nome_pessoa VARCHAR(55);
 
 SELECT nome, descricao, ano FROM cursos ORDER BY nome, ano;
 
  SELECT * FROM cursos ORDER BY nome, ano;
  
   SELECT nome, descricao, ano FROM cursos WHERE ANO = 2015;
   
     SELECT nome, descricao, ano FROM cursos WHERE ANO <> 2015 AND ANO <> 2014 AND ANO > 2000 order by ANO;
     
SELECT nome, descricao, ano FROM cursos WHERE ano BETWEEN  2001 and 2015 ORDER BY ano;
  
  
  
  UPDATE cursos SET ano = 2015 WHERE idcurso = 23;

desc cursos;

INSERT INTO cursos (nome, descricao, carga, totaulas, ano) VALUES
('Curso de Matemática', 'Curso introdutório de matemática', 40, 20, 2024),
('Curso de História', 'Curso abrangente sobre história mundial', 50, 25, 2024),
('Curso de Programação', 'Curso prático de desenvolvimento de software', 60, 30, 2024),
('Curso de Inglês', 'Curso de inglês para iniciantes', 45, 22, 2024),
('Curso de Fotografia', 'Curso de fotografia digital', 55, 28, 2024),
('Curso de Marketing', 'Curso de marketing digital', 50, 25, 2024),
('Curso de Economia', 'Curso sobre princípios de economia', 45, 22, 2024),
('Curso de Biologia', 'Curso introdutório sobre biologia', 40, 20, 2024),
('Curso de Química', 'Curso básico de química', 35, 18, 2024),
('Curso de Física', 'Curso de física para estudantes do ensino médio', 40, 20, 2024),
('Curso de Artes', 'Curso de introdução às artes visuais', 55, 28, 2024),
('Curso de Design', 'Curso de design gráfico', 60, 30, 2024),
('Curso de Medicina', 'Curso introdutório sobre medicina', 65, 32, 2024),
('Curso de Psicologia', 'Curso básico de psicologia', 50, 25, 2024),
('Curso de Filosofia', 'Curso de introdução à filosofia', 45, 22, 2024),
('Curso de Engenharia', 'Curso introdutório sobre engenharia', 55, 28, 2024),
('Curso de Direito', 'Curso de direito constitucional', 60, 30, 2024),
('Curso de Nutrição', 'Curso básico de nutrição', 40, 20, 2024),
('Curso de Administração', 'Curso de administração de empresas', 50, 25, 2024),
('Curso de Educação Física', 'Curso de educação física', 45, 22, 2024);

SELECT * FROM cursos;

 UPDATE cursos SET ano = 2009 WHERE carga BETWEEN 50 and 59;
 
 SELECT idcurso, nome, ano FROM cursos

WHERE ano IN (2014, 2015, 2001)

ORDER BY nome;

SELECT * FROM cadastro;

