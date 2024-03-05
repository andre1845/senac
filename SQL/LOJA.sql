CREATE DATABASE loja;
USE loja;
CREATE TABLE produtos (
idproduto INT NOT NULL PRIMARY KEY auto_increment,
nomeprod VARCHAR (50) UNIQUE,
valor FLOAT(8,2),
quantidade INT(8)
);
CREATE TABLE cliente (
idcliente INT NOT NULL PRIMARY KEY auto_increment,
nome_cliente VARCHAR (100),
email VARCHAR (30),
tel VARCHAR (24),
CPF  VARCHAR (12) UNIQUE NOT NULL
);

INSERT INTO cliente (nome_cliente, email, tel, CPF) VALUES
('João Silva', 'joao@example.com', '(11) 1234-5678', '133.446.723-04'),
('Maria Oliveira', 'maria@example.com', '(22) 9876-5432', '214.547.890-12'),
('Pedro Santos', 'pedro@example.com', '(33) 6543-2109', '315.678.901-23'),
('Ana Souza', 'ana@example.com', '(44) 1357-2468', '456.789.042-34'),
('Lucas Pereira', 'lucas@example.com', '(55) 8642-9753', '567.890.123-45'),
('Fernanda Lima', 'fernanda@example.com', '(66) 2468-1357', '678.901.234-56'),
('Marcos Costa', 'marcos@example.com', '(77) 9753-8642', '789.012.345-67'),
('Carla Rodrigues', 'carla@example.com', '(88) 3210-9876', '890.123.456-78'),
('Bruno Martins', 'bruno@example.com', '(99) 7531-2468', '901.234.567-89'),
('Juliana Almeida', 'juliana@example.com', '(10) 2468-9753', '012.345.678-90'),
('Rafaela Silva', 'rafaela@example.com', '(11) 9753-8642', '123.426.779-01'),
('Rodrigo Santos', 'rodrigo@example.com', '(22) 8642-7531', '234.547.890-12'),
('Sandra Costa', 'sandra@example.com', '(33) 7531-6420', '335.678.901-23'),
('Paulo Oliveira', 'paulo@example.com', '(44) 6420-9753', '496.789.012-34'),
('Camila Pereira', 'camila@example.com', '(55) 9753-6420', '567.870.123-45'),
('Larissa Souza', 'larissa@example.com', '(66) 7531-9753', '658.901.234-56'),
('Gustavo Lima', 'gustavo@example.com', '(77) 6420-7531', '781.012.345-67'),
('Amanda Costa', 'amanda@example.com', '(88) 9753-3210', '860.123.456-78'),
('Diego Martins', 'diego@example.com', '(99) 2468-9753', '941.234.547-89'),
('Fabiana Almeida', 'fabiana@example.com', '(10) 9753-8642', '022.345.678-90');

ALTER TABLE cliente MODIFY COLUMN CPF varchar(20);

select * from cliente;

UPDATE cliente
SET email = REPLACE(email, 'example', 'teste') LIMIT 10;

SELECT nome_cliente, CPF FROM cliente WHERE email like '%teste%';

DELETE FROM cliente WHERE idcliente = 3;

UPDATE cliente SET email = 'udpdate@email.com'  WHERE nome_cliente LIKE '%Almei%';

ALTER TABLE cliente ADD COLUMN sexo enum ('M','F') AFTER nome_cliente;

DESC cliente;

SELECT * FROM cliente;

UPDATE cliente SET sexo = 'F' WHERE nome_cliente LIKE '%a';


UPDATE cliente SET sexo = 'M' WHERE idcliente IN (101,103,107,109,112,114,117,119);

UPDATE cliente SET sexo = 'F' WHERE sexo IS null;

ALTER TABLE cliente MODIFY COLUMN sexo enum ('M','F','X');

UPDATE cliente SET sexo = 'M' WHERE sexo NOT LIKE 'F';

SELECT * FROM cliente WHERE nome_cliente not LIKE '%anda%';

SELECT * FROM cliente WHERE tel not LIKE '%(11)%'AND tel NOT LIKE '%(99)%';

Select * from cliente Where nome_cliente like 'Ma%r_';

SELECT COUNT(DISTINCT(sexo)) as TESTE FROM cliente;

ALTER TABLE cliente ADD COLUMN peso DECIMAL(5,2) AFTER sexo;

INSERT INTO cliente (peso) VALUES 
(51.25), (89.50), (72.75), (96.00), (55.50), 
(78.25), (61.00), (84.75), (93.25), (67.00), 
(70.50), (58.75), (81.25), (64.50), (99.75), 
(52.00), (76.50), (97.25), (59.00), (88.25);


UPDATE cliente 
SET peso = CASE 
    WHEN idcliente = 101 THEN 51.25
    WHEN idcliente = 102 THEN 89.50
    WHEN idcliente = 103 THEN 72.75
    WHEN idcliente = 104 THEN 96.00
    WHEN idcliente = 105 THEN 55.50
    WHEN idcliente = 106 THEN 78.25
    WHEN idcliente = 107 THEN 61.00
    WHEN idcliente = 108 THEN 84.75
    WHEN idcliente = 109 THEN 93.25
    WHEN idcliente = 110 THEN 67.00
    WHEN idcliente = 111 THEN 70.50
    WHEN idcliente = 112 THEN 58.75
    WHEN idcliente = 113 THEN 81.25
    WHEN idcliente = 114 THEN 64.50
    WHEN idcliente = 115 THEN 99.75
    WHEN idcliente = 116 THEN 52.00
    WHEN idcliente = 117 THEN 76.50
    WHEN idcliente = 118 THEN 97.25
    WHEN idcliente = 119 THEN 59.00
    WHEN idcliente = 120 THEN 88.25
    ELSE peso
END;

DELETE FROM cliente WHERE idcliente >= 121;

SELECT * FROM cliente;

ALTER TABLE cliente ADD COLUMN datanasc DATE AFTER SEXO;

UPDATE cliente
SET datanasc = CASE 
    WHEN idcliente = 102 THEN '1998-12-02'
    WHEN idcliente = 101 THEN '2005-12-02'
    WHEN idcliente = 103 THEN '1998-07-08'
    WHEN idcliente = 104 THEN '1998-12-02'
    WHEN idcliente = 105 THEN '1996-12-02'
    WHEN idcliente = 106 THEN '2005-05-24'
    WHEN idcliente = 107 THEN '2001-12-02'
    WHEN idcliente = 108 THEN '1998-12-02'
    WHEN idcliente = 109 THEN '1998-12-02'
    WHEN idcliente = 110 THEN '2005-11-02'
    WHEN idcliente = 111 THEN '1998-12-02'
    WHEN idcliente = 112 THEN '2008-12-03'
    WHEN idcliente = 113 THEN '1997-12-02'
    WHEN idcliente = 114 THEN '1998-12-02'
    WHEN idcliente = 115 THEN '2007-12-02'
    WHEN idcliente = 116 THEN '1998-12-02'
    WHEN idcliente = 117 THEN '2006-10-11'
    WHEN idcliente = 118 THEN '1998-12-02'
    WHEN idcliente = 119 THEN '2004-09-01'
    WHEN idcliente = 120 THEN '1998-12-02'
    ELSE datanasc
END;


UPDATE cliente
SET altura = CASE 
    WHEN idcliente = 102 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 101 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 103 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 104 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 105 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 106 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 107 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 108 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 109 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 110 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 111 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 112 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 113 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 114 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 115 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 116 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 117 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 118 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 119 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    WHEN idcliente = 120 THEN ROUND(1.56 + RAND() * (1.90 - 1.56), 2)
    ELSE datanasc
END;

UPDATE cliente
SET pais = CASE 
    WHEN idcliente = 102 THEN 'Brasil'
    WHEN idcliente = 101 THEN 'Brasil'
    WHEN idcliente = 103 THEN 'Brasil'
    WHEN idcliente = 109 THEN 'Brasil'
    WHEN idcliente = 105 THEN 'Brasil'
    WHEN idcliente = 106 THEN 'Argentina'
    WHEN idcliente = 104 THEN 'Argentina'
    WHEN idcliente = 107 THEN 'Argentina'
    WHEN idcliente = 108 THEN 'Argentina'
    WHEN idcliente = 110 THEN 'Argentina'
    WHEN idcliente = 116 THEN 'China'
    WHEN idcliente = 111 THEN 'China'
    WHEN idcliente = 113 THEN 'China'
    WHEN idcliente = 112 THEN 'China'
    WHEN idcliente = 114 THEN 'India'
    WHEN idcliente = 119 THEN 'India'
    WHEN idcliente = 115 THEN 'India'
    WHEN idcliente = 117 THEN 'India'
    WHEN idcliente = 118 THEN 'Russia'
    WHEN idcliente = 120 THEN 'Russia'
    ELSE pais
END;

SELECT nome_cliente FROM cliente;

SELECT * FROM cliente WHERE pais = 'Brasil' AND  nome_cliente LIKE 'a%' AND sexo = 'F';

SELECT MAX(altura), nome_cliente FROM cliente WHERE pais = 'Brasil' AND sexo = 'M';

SELECT AVG(peso) FROM cliente WHERE sexo = 'M';

SELECT * FROM cliente;

SELECT pais, count(nome_cliente) as QTDE FROM cliente GROUP BY pais HAVING COUNT(pais) > 1 ORDER BY QTDE DESC, pais ;

SELECT COUNT(DISTINCT(pais)) FROM cliente;

SELECT  altura, COUNT(altura) AS Maior_que_60kg FROM cliente 
WHERE peso > 60 
GROUP BY altura 
HAVING altura > (select (AVG(altura)) FROM cliente);








