CREATE DATABASE banco;

USE banco;

CREATE TABLE clientes (
idcliente INT NOT NULL primary KEY,
nome VARCHAR(70),
CPF VARCHAR(15),
agencia VARCHAR(10),
conta VARCHAR(10)
);

DESC clientes;

INSERT INTO clientes (idcliente, nome, CPF, agencia, conta) VALUES
(1, 'João Silva', '123.456.789-00', '001', '12345-6'),
(2, 'Maria Santos', '987.654.321-00', '002', '54321-0'),
(3, 'Pedro Oliveira', '456.789.123-00', '003', '98765-4'),
(4, 'Ana Souza', '789.123.456-00', '001', '45678-9'),
(5, 'Carlos Pereira', '321.654.987-00', '002', '87654-3'),
(6, 'Mariana Costa', '654.321.987-00', '003', '23456-7'),
(7, 'Paulo Santos', '987.123.456-00', '001', '76543-2'),
(8, 'Lúcia Oliveira', '123.789.456-00', '002', '54321-9'),
(9, 'Fernando Sousa', '654.987.123-00', '003', '87654-1'),
(10, 'Carla Lima', '456.123.789-00', '001', '34567-8'),
(11, 'Antônio Martins', '987.456.321-00', '002', '98765-0'),
(12, 'Márcia Silva', '321.789.654-00', '003', '65432-6'),
(13, 'José Santos', '789.654.321-00', '001', '87654-3'),
(14, 'Juliana Oliveira', '654.987.321-00', '002', '23456-7'),
(15, 'Ricardo Pereira', '987.321.654-00', '003', '76543-2'),
(16, 'Amanda Costa', '321.456.789-00', '001', '45678-9'),
(17, 'Bruno Sousa', '654.987.321-00', '002', '87654-3'),
(18, 'Luiza Lima', '123.789.456-00', '003', '34567-8'),
(19, 'Roberto Martins', '987.654.321-00', '001', '98765-0'),
(20, 'Tatiane Silva', '456.123.789-00', '002', '65432-6'),
(21, 'Marcos Santos', '321.654.987-00', '003', '87654-3'),
(22, 'Aline Oliveira', '987.321.654-00', '001', '23456-7'),
(23, 'Gustavo Costa', '321.789.654-00', '002', '76543-2'),
(24, 'Camila Pereira', '654.987.321-00', '003', '45678-9'),
(25, 'Renato Souza', '789.654.321-00', '001', '87654-3'),
(26, 'Vanessa Lima', '123.789.456-00', '002', '34567-8'),
(27, 'Felipe Martins', '987.654.321-00', '003', '98765-0'),
(28, 'Patrícia Silva', '456.123.789-00', '001', '65432-6'),
(29, 'Lucas Santos', '321.654.987-00', '002', '87654-3'),
(30, 'Fernanda Oliveira', '987.321.654-00', '003', '23456-7'),
(31, 'Robson Costa', '321.789.654-00', '001', '76543-2'),
(32, 'Jéssica Pereira', '654.987.321-00', '002', '45678-9'),
(33, 'Thiago Souza', '789.654.321-00', '003', '87654-3'),
(34, 'Paula Lima', '123.789.456-00', '001', '34567-8'),
(35, 'Rafael Martins', '987.654.321-00', '002', '98765-0'),
(36, 'Natália Silva', '456.123.789-00', '003', '65432-6'),
(37, 'Gabriel Santos', '321.654.987-00', '001', '87654-3'),
(38, 'Bianca Oliveira', '987.321.654-00', '002', '23456-7'),
(39, 'Leandro Costa', '321.789.654-00', '003', '76543-2'),
(40, 'Alessandra Pereira', '654.987.321-00', '001', '45678-9'),
(41, 'Daniel Souza', '789.654.321-00', '002', '87654-3'),
(42, 'Caroline Lima', '123.789.456-00', '003', '34567-8'),
(43, 'Vinícius Martins', '987.654.321-00', '001', '98765-0'),
(44, 'Suzana Silva', '456.123.789-00', '002', '65432-6'),
(45, 'Diego Santos', '321.654.987-00', '003', '87654-3'),
(46, 'Isabela Oliveira', '987.321.654-00', '001', '23456-7'),
(47, 'Henrique Costa', '321.789.654-00', '002', '76543-2'),
(48, 'Laura Pereira', '654.987.321-00', '003', '45678-9'),
(49, 'Roberta Souza', '789.654.321-00', '001', '87654-3'),
(50, 'Matheus Lima', '123.789.456-00', '002', '34567-8');

SELECT * FROM clientes;

CREATE VIEW agencia001 AS SELECT * FROM clientes WHERE agencia = '001';

SELECT * FROM agencia001;





/* Crie um novo banco de dados chamado de banco, a tabela deve ser chamada de clientes, deve conter, id, nome, cpf, agencia, conta. Com os dados cadastrados na tabela, crie as views para guardar as consultas feitas.